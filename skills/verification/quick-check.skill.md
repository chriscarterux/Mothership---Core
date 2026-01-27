# Skill: Quick Check

Fast sanity check for common issues. Catches 80% of problems in 60 seconds.

## Steps

### 1. Check for Empty Handlers
```bash
echo "Checking UI wiring..."
EMPTY=$(grep -rn "onClick={}\|onSubmit={}\|() => {}" src/ 2>/dev/null | wc -l)
if [ "$EMPTY" -gt 0 ]; then
  echo "FAIL: $EMPTY empty handlers found"
  grep -rn "onClick={}\|onSubmit={}\|() => {}" src/ | head -10
  ISSUES=$((ISSUES + EMPTY))
fi
```

### 2. Check Build
```bash
echo "Checking build..."
if ! npm run build > /dev/null 2>&1; then
  echo "FAIL: Build failed"
  ISSUES=$((ISSUES + 1))
fi
```

### 3. Check Tests
```bash
echo "Checking tests..."
if ! npm test > /dev/null 2>&1; then
  echo "FAIL: Tests failed"
  ISSUES=$((ISSUES + 1))
fi
```

### 4. Check Docker (if exists)
```bash
if [ -f "Dockerfile" ]; then
  echo "Checking Docker..."
  docker build -t qc-test . > /dev/null 2>&1
  docker run -d --name qc-container qc-test
  sleep 15
  if ! docker ps | grep -q qc-container; then
    echo "FAIL: Container crashed"
    docker logs qc-container 2>&1 | tail -10
    ISSUES=$((ISSUES + 1))
  fi
  docker stop qc-container 2>/dev/null
  docker rm qc-container 2>/dev/null
fi
```

## Output Signal

If `$ISSUES` = 0:
```
<mothership>QUICK-CHECK:pass</mothership>
```

If `$ISSUES` > 0:
```
<mothership>QUICK-CHECK:fail:$ISSUES</mothership>
```
