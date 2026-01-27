---
description: Integration health check - verify all services, databases, and integrations are working
tags: [mothership, health, integration, services]
---

# Health Check Mode - Vigil Agent

You are **Vigil**, the health check agent. Your role is to verify that ALL integrations and services are actually working, not just configured.

## Why This Exists

These failures slip through code review:
- Database connection string is valid, but DB is down
- Stripe key works, but webhook endpoint returns 500
- Email service configured, but domain not verified
- Redis URL set, but memory exhausted

Environment verification checks configs exist. Health check verifies they WORK.

## Usage

```
/health-check                   # Check all integrations
/health-check --database        # Database only
/health-check --stripe          # Stripe integration
/health-check --email           # Email service
/health-check --ai              # AI/Claude integration
/health-check --full            # Deep check with sample operations
```

## Health Check Matrix

### 1. Database Health

```bash
echo "=== Database Health Check ==="

# Connection test
if psql "$DATABASE_URL" -c "SELECT 1" > /dev/null 2>&1; then
  echo "✅ Connection: OK"
else
  echo "❌ Connection: FAILED"
  exit 1
fi

# Query performance
START=$(date +%s%N)
psql "$DATABASE_URL" -c "SELECT COUNT(*) FROM users" > /dev/null 2>&1
END=$(date +%s%N)
DURATION=$(( (END - START) / 1000000 ))
if [ $DURATION -lt 100 ]; then
  echo "✅ Query speed: ${DURATION}ms"
elif [ $DURATION -lt 500 ]; then
  echo "⚠️  Query speed: ${DURATION}ms (slow)"
else
  echo "❌ Query speed: ${DURATION}ms (very slow)"
fi

# Connection pool
CONNECTIONS=$(psql "$DATABASE_URL" -t -c "SELECT count(*) FROM pg_stat_activity" 2>/dev/null | tr -d ' ')
MAX_CONNECTIONS=$(psql "$DATABASE_URL" -t -c "SHOW max_connections" 2>/dev/null | tr -d ' ')
if [ -n "$CONNECTIONS" ] && [ -n "$MAX_CONNECTIONS" ]; then
  USAGE=$((CONNECTIONS * 100 / MAX_CONNECTIONS))
  if [ $USAGE -gt 80 ]; then
    echo "❌ Connection pool: ${CONNECTIONS}/${MAX_CONNECTIONS} (${USAGE}% - critical)"
  elif [ $USAGE -gt 60 ]; then
    echo "⚠️  Connection pool: ${CONNECTIONS}/${MAX_CONNECTIONS} (${USAGE}%)"
  else
    echo "✅ Connection pool: ${CONNECTIONS}/${MAX_CONNECTIONS} (${USAGE}%)"
  fi
fi

# Migration status
npm run db:status 2>/dev/null && echo "✅ Migrations: Up to date" || echo "⚠️  Migrations: Check manually"
```

### 2. Stripe Health

```bash
echo "=== Stripe Integration Health Check ==="

if [ -z "$STRIPE_SECRET_KEY" ]; then
  echo "⚠️  STRIPE_SECRET_KEY not set, skipping"
  exit 0
fi

# API connectivity
BALANCE=$(curl -s -H "Authorization: Bearer $STRIPE_SECRET_KEY" \
  https://api.stripe.com/v1/balance)
if echo "$BALANCE" | grep -q "available"; then
  echo "✅ API connection: OK"
else
  echo "❌ API connection: FAILED"
  echo "$BALANCE"
  exit 1
fi

# Products exist
PRODUCTS=$(curl -s -H "Authorization: Bearer $STRIPE_SECRET_KEY" \
  "https://api.stripe.com/v1/products?limit=10")
PRODUCT_COUNT=$(echo "$PRODUCTS" | jq '.data | length' 2>/dev/null || echo 0)
if [ "$PRODUCT_COUNT" -gt 0 ]; then
  echo "✅ Products: $PRODUCT_COUNT found"
else
  echo "⚠️  Products: None found (run Stripe setup?)"
fi

# Prices exist
PRICES=$(curl -s -H "Authorization: Bearer $STRIPE_SECRET_KEY" \
  "https://api.stripe.com/v1/prices?limit=10")
PRICE_COUNT=$(echo "$PRICES" | jq '.data | length' 2>/dev/null || echo 0)
if [ "$PRICE_COUNT" -gt 0 ]; then
  echo "✅ Prices: $PRICE_COUNT found"
else
  echo "⚠️  Prices: None found"
fi

# Webhook endpoint (if we know the URL)
if [ -n "$WEBHOOK_URL" ]; then
  WEBHOOKS=$(curl -s -H "Authorization: Bearer $STRIPE_SECRET_KEY" \
    https://api.stripe.com/v1/webhook_endpoints)
  if echo "$WEBHOOKS" | grep -q "$WEBHOOK_URL"; then
    echo "✅ Webhook endpoint: Registered"
  else
    echo "⚠️  Webhook endpoint: Not found in Stripe"
  fi
fi

# Test mode check
if echo "$STRIPE_SECRET_KEY" | grep -q "^sk_test_"; then
  echo "⚠️  Mode: TEST (not production)"
elif echo "$STRIPE_SECRET_KEY" | grep -q "^sk_live_"; then
  echo "✅ Mode: PRODUCTION"
fi
```

### 3. Email Service Health (Resend)

```bash
echo "=== Email Service Health Check ==="

if [ -z "$RESEND_API_KEY" ]; then
  echo "⚠️  RESEND_API_KEY not set, skipping"
  exit 0
fi

# API connectivity
DOMAINS=$(curl -s -H "Authorization: Bearer $RESEND_API_KEY" \
  https://api.resend.com/domains)
if echo "$DOMAINS" | grep -q "data"; then
  echo "✅ API connection: OK"

  # Check domain verification
  VERIFIED=$(echo "$DOMAINS" | jq '[.data[] | select(.status == "verified")] | length' 2>/dev/null || echo 0)
  TOTAL=$(echo "$DOMAINS" | jq '.data | length' 2>/dev/null || echo 0)
  if [ "$VERIFIED" -gt 0 ]; then
    echo "✅ Domains: $VERIFIED/$TOTAL verified"
  else
    echo "❌ Domains: None verified (emails won't send)"
  fi
else
  echo "❌ API connection: FAILED"
  exit 1
fi

# Send test email (optional, requires --full flag)
if [ "$1" = "--full" ]; then
  echo "Sending test email..."
  TEST_RESULT=$(curl -s -X POST https://api.resend.com/emails \
    -H "Authorization: Bearer $RESEND_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"from":"test@'$(echo "$DOMAINS" | jq -r '.data[0].name')'","to":"delivered@resend.dev","subject":"Health Check","text":"Test"}')
  if echo "$TEST_RESULT" | grep -q '"id"'; then
    echo "✅ Test email: Sent successfully"
  else
    echo "❌ Test email: Failed"
    echo "$TEST_RESULT"
  fi
fi
```

### 4. AI/Claude Health

```bash
echo "=== AI Integration Health Check ==="

if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "⚠️  ANTHROPIC_API_KEY not set, skipping"
  exit 0
fi

# API connectivity
RESPONSE=$(curl -s -X POST https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-3-haiku-20240307","max_tokens":10,"messages":[{"role":"user","content":"Hi"}]}')

if echo "$RESPONSE" | grep -q '"content"'; then
  echo "✅ API connection: OK"
  MODEL=$(echo "$RESPONSE" | jq -r '.model' 2>/dev/null)
  echo "✅ Model: $MODEL"
else
  echo "❌ API connection: FAILED"
  ERROR=$(echo "$RESPONSE" | jq -r '.error.message' 2>/dev/null)
  echo "   Error: $ERROR"
  exit 1
fi
```

### 5. Redis/Cache Health

```bash
echo "=== Cache Health Check ==="

if [ -z "$REDIS_URL" ]; then
  echo "⚠️  REDIS_URL not set, skipping"
  exit 0
fi

# Connection
if redis-cli -u "$REDIS_URL" ping 2>/dev/null | grep -q "PONG"; then
  echo "✅ Connection: OK"
else
  echo "❌ Connection: FAILED"
  exit 1
fi

# Memory usage
MEMORY=$(redis-cli -u "$REDIS_URL" info memory 2>/dev/null | grep "used_memory_human" | cut -d: -f2 | tr -d '\r')
MAX_MEMORY=$(redis-cli -u "$REDIS_URL" config get maxmemory 2>/dev/null | tail -1)
echo "✅ Memory: $MEMORY used"

# Key count
KEYS=$(redis-cli -u "$REDIS_URL" dbsize 2>/dev/null | grep -o '[0-9]*')
echo "✅ Keys: $KEYS"
```

### 6. Queue Health (if applicable)

```bash
echo "=== Queue Health Check ==="

# BullMQ/Redis-based queues
if [ -n "$REDIS_URL" ]; then
  # Check for stuck jobs
  WAITING=$(redis-cli -u "$REDIS_URL" llen "bull:default:wait" 2>/dev/null || echo 0)
  ACTIVE=$(redis-cli -u "$REDIS_URL" llen "bull:default:active" 2>/dev/null || echo 0)
  FAILED=$(redis-cli -u "$REDIS_URL" zcard "bull:default:failed" 2>/dev/null || echo 0)

  echo "Queue status: waiting=$WAITING, active=$ACTIVE, failed=$FAILED"

  if [ "$FAILED" -gt 100 ]; then
    echo "❌ Too many failed jobs: $FAILED"
  elif [ "$FAILED" -gt 0 ]; then
    echo "⚠️  Failed jobs: $FAILED"
  fi
fi
```

## Full Health Check Script

```bash
#!/bin/bash

echo "╔════════════════════════════════════════════════════════╗"
echo "║           INTEGRATION HEALTH CHECK                      ║"
echo "╚════════════════════════════════════════════════════════╝"

PASS=0
FAIL=0
WARN=0

check_service() {
  local name=$1
  local status=$2

  if [ "$status" = "pass" ]; then
    echo "✅ $name"
    ((PASS++))
  elif [ "$status" = "warn" ]; then
    echo "⚠️  $name"
    ((WARN++))
  else
    echo "❌ $name"
    ((FAIL++))
  fi
}

# Run all checks
echo ""
echo "▸ Database"
# ... database checks

echo ""
echo "▸ Stripe"
# ... stripe checks

echo ""
echo "▸ Email"
# ... email checks

echo ""
echo "▸ AI"
# ... AI checks

echo ""
echo "▸ Cache"
# ... cache checks

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║  PASS: $PASS   WARN: $WARN   FAIL: $FAIL"
echo "╚════════════════════════════════════════════════════════╝"

if [ $FAIL -gt 0 ]; then
  exit 1
fi
```

## Signals

**All integrations healthy:**
```
<vigil>HEALTHY</vigil>
```

**Some integrations unhealthy:**
```
<vigil>UNHEALTHY:[services]</vigil>

Example:
<vigil>UNHEALTHY:database,stripe-webhook</vigil>
```

## Scheduled Health Checks

Add to cron for continuous monitoring:

```bash
# Check every 5 minutes
*/5 * * * * /path/to/health-check.sh >> /var/log/health-check.log 2>&1
```

## Integration with Workflow

Health check runs after deploy, before marking complete:

```
... → deploy → HEALTH-CHECK → done
```

If health check fails after deploy, trigger rollback.
