---
description: Environment verification - check env vars, services, and dependencies before deployment
tags: [mothership, environment, verify, pre-deploy]
---

# Verify Environment Mode - Sentinel Agent

You are **Sentinel** in environment verification mode. Your role is to ensure the deployment environment is correctly configured BEFORE any code runs.

## Why This Exists

Common production failures:
- `STRIPE_SECRET_KEY is undefined` - env var missing
- `ECONNREFUSED 127.0.0.1:5432` - database not reachable
- `Redis connection timeout` - cache service down
- `certificate has expired` - SSL cert not renewed

These are NOT code bugs. They're environment misconfigurations that should be caught BEFORE deployment.

## Usage

```
/verify-env                    # Check current environment
/verify-env --staging          # Check staging environment
/verify-env --production       # Check production environment
/verify-env --ci               # CI-friendly output (exit codes)
```

## Environment Verification Checklist

### 1. Required Environment Variables

Scan for required env vars and verify they're set:

```bash
#!/bin/bash
echo "=== Environment Variable Check ==="

REQUIRED_VARS=(
  # Core
  "NODE_ENV"
  "DATABASE_URL"

  # Auth
  "NEXTAUTH_SECRET"
  "NEXTAUTH_URL"

  # Integrations (check .env.example for full list)
  # "STRIPE_SECRET_KEY"
  # "STRIPE_PUBLISHABLE_KEY"
  # "STRIPE_WEBHOOK_SECRET"
  # "RESEND_API_KEY"
  # "ANTHROPIC_API_KEY"
)

MISSING=0
for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "MISSING: $var"
    ((MISSING++))
  else
    # Don't print value, just confirm it exists
    echo "OK: $var is set"
  fi
done

if [ $MISSING -gt 0 ]; then
  echo "FAIL: $MISSING required variables missing"
  exit 1
fi
echo "PASS: All required variables set"
```

### 2. Database Connectivity

```bash
echo "=== Database Connectivity Check ==="

# PostgreSQL
if [ -n "$DATABASE_URL" ]; then
  if psql "$DATABASE_URL" -c "SELECT 1" > /dev/null 2>&1; then
    echo "PASS: PostgreSQL connected"
  else
    echo "FAIL: Cannot connect to PostgreSQL"
    exit 1
  fi
fi

# Check migrations are up to date
npm run db:status 2>/dev/null || echo "WARN: Cannot check migration status"
```

### 3. External Service Reachability

```bash
echo "=== External Service Reachability ==="

# Stripe API
if [ -n "$STRIPE_SECRET_KEY" ]; then
  STRIPE_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: Bearer $STRIPE_SECRET_KEY" \
    https://api.stripe.com/v1/balance)
  if [ "$STRIPE_STATUS" = "200" ]; then
    echo "PASS: Stripe API reachable"
  else
    echo "FAIL: Stripe API returned $STRIPE_STATUS"
  fi
fi

# Resend API
if [ -n "$RESEND_API_KEY" ]; then
  RESEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: Bearer $RESEND_API_KEY" \
    https://api.resend.com/domains)
  if [ "$RESEND_STATUS" = "200" ]; then
    echo "PASS: Resend API reachable"
  else
    echo "FAIL: Resend API returned $RESEND_STATUS"
  fi
fi

# Claude/Anthropic API
if [ -n "$ANTHROPIC_API_KEY" ]; then
  ANTHROPIC_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    https://api.anthropic.com/v1/models)
  if [ "$ANTHROPIC_STATUS" = "200" ]; then
    echo "PASS: Anthropic API reachable"
  else
    echo "WARN: Anthropic API returned $ANTHROPIC_STATUS (may require different test)"
  fi
fi
```

### 4. Redis/Cache Connectivity

```bash
echo "=== Cache Connectivity Check ==="

if [ -n "$REDIS_URL" ]; then
  if redis-cli -u "$REDIS_URL" ping | grep -q "PONG"; then
    echo "PASS: Redis connected"
  else
    echo "FAIL: Cannot connect to Redis"
  fi
fi
```

### 5. SSL Certificate Validation

```bash
echo "=== SSL Certificate Check ==="

DOMAINS=(
  "${NEXTAUTH_URL:-https://localhost}"
  # Add other domains
)

for domain in "${DOMAINS[@]}"; do
  # Extract hostname
  HOST=$(echo "$domain" | sed 's|https://||' | sed 's|/.*||')

  if [ "$HOST" != "localhost" ]; then
    EXPIRY=$(echo | openssl s_client -servername "$HOST" -connect "$HOST:443" 2>/dev/null \
      | openssl x509 -noout -enddate 2>/dev/null \
      | cut -d= -f2)

    if [ -n "$EXPIRY" ]; then
      EXPIRY_EPOCH=$(date -d "$EXPIRY" +%s 2>/dev/null || date -j -f "%b %d %T %Y %Z" "$EXPIRY" +%s 2>/dev/null)
      NOW_EPOCH=$(date +%s)
      DAYS_LEFT=$(( (EXPIRY_EPOCH - NOW_EPOCH) / 86400 ))

      if [ $DAYS_LEFT -lt 0 ]; then
        echo "FAIL: $HOST certificate EXPIRED"
      elif [ $DAYS_LEFT -lt 14 ]; then
        echo "WARN: $HOST certificate expires in $DAYS_LEFT days"
      else
        echo "PASS: $HOST certificate valid ($DAYS_LEFT days)"
      fi
    fi
  fi
done
```

### 6. Port Availability

```bash
echo "=== Port Availability Check ==="

REQUIRED_PORTS=(3000 5432)

for port in "${REQUIRED_PORTS[@]}"; do
  if lsof -i ":$port" > /dev/null 2>&1; then
    PROCESS=$(lsof -i ":$port" | tail -1 | awk '{print $1}')
    echo "WARN: Port $port in use by $PROCESS"
  else
    echo "PASS: Port $port available"
  fi
done
```

### 7. Disk Space

```bash
echo "=== Disk Space Check ==="

USAGE=$(df -h . | tail -1 | awk '{print $5}' | tr -d '%')
if [ "$USAGE" -gt 90 ]; then
  echo "FAIL: Disk usage at ${USAGE}%"
elif [ "$USAGE" -gt 80 ]; then
  echo "WARN: Disk usage at ${USAGE}%"
else
  echo "PASS: Disk usage at ${USAGE}%"
fi
```

### 8. Memory Availability

```bash
echo "=== Memory Check ==="

if command -v free &> /dev/null; then
  AVAILABLE=$(free -m | awk '/^Mem:/ {print $7}')
  if [ "$AVAILABLE" -lt 512 ]; then
    echo "FAIL: Only ${AVAILABLE}MB memory available"
  elif [ "$AVAILABLE" -lt 1024 ]; then
    echo "WARN: ${AVAILABLE}MB memory available"
  else
    echo "PASS: ${AVAILABLE}MB memory available"
  fi
fi
```

## Full Verification Script

```bash
#!/bin/bash
set -e

echo "╔════════════════════════════════════════════╗"
echo "║     ENVIRONMENT VERIFICATION               ║"
echo "╚════════════════════════════════════════════╝"

ERRORS=0
WARNINGS=0

check() {
  if $1; then
    echo "✅ $2"
  else
    echo "❌ $2"
    ((ERRORS++))
  fi
}

warn() {
  echo "⚠️  $1"
  ((WARNINGS++))
}

# 1. Check .env exists
check "[ -f .env ]" ".env file exists"

# 2. Check required vars
source .env 2>/dev/null || true
[ -n "$DATABASE_URL" ] && check true "DATABASE_URL set" || { check false "DATABASE_URL"; }
[ -n "$NEXTAUTH_SECRET" ] && check true "NEXTAUTH_SECRET set" || { check false "NEXTAUTH_SECRET"; }

# 3. Check database
if [ -n "$DATABASE_URL" ]; then
  psql "$DATABASE_URL" -c "SELECT 1" > /dev/null 2>&1 && \
    check true "Database connected" || check false "Database connected"
fi

# 4. Check build
npm run build > /dev/null 2>&1 && \
  check true "Build succeeds" || check false "Build succeeds"

# 5. Summary
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║  ERRORS: $ERRORS  WARNINGS: $WARNINGS"
echo "╚════════════════════════════════════════════╝"

exit $ERRORS
```

## Integration with Workflow

Environment verification runs BEFORE deploy:

```
... → review → VERIFY-ENV → deploy
```

If verify-env fails, deployment is blocked.

## Signals

**All checks pass:**
```
<sentinel>ENV-VERIFIED</sentinel>
```

**Checks failed:**
```
<sentinel>ENV-FAILED:[count] errors, [count] warnings</sentinel>
```

## Configuration

Create `.mothership/env-requirements.json`:

```json
{
  "required_vars": [
    "DATABASE_URL",
    "NEXTAUTH_SECRET",
    "NEXTAUTH_URL"
  ],
  "optional_vars": [
    "STRIPE_SECRET_KEY",
    "RESEND_API_KEY"
  ],
  "services": [
    {
      "name": "database",
      "type": "postgres",
      "env_var": "DATABASE_URL"
    },
    {
      "name": "redis",
      "type": "redis",
      "env_var": "REDIS_URL",
      "optional": true
    }
  ],
  "min_disk_gb": 5,
  "min_memory_mb": 1024
}
```
