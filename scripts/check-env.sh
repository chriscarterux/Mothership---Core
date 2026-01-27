#!/bin/bash
# check-env.sh - Verify required environment variables
# Exit code 1 = missing vars, 0 = all present
# Run in CI or before deployment

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Default required vars (override with REQUIRED_VARS env or .env.required file)
DEFAULT_REQUIRED=(
    "NODE_ENV"
    "DATABASE_URL"
)

# Load from .env.required if exists
if [[ -f ".env.required" ]]; then
    mapfile -t REQUIRED_VARS < <(grep -v '^#' .env.required | grep -v '^$')
elif [[ -n "$REQUIRED_VARS" ]]; then
    IFS=',' read -ra REQUIRED_VARS <<< "$REQUIRED_VARS"
else
    REQUIRED_VARS=("${DEFAULT_REQUIRED[@]}")
fi

echo "╔════════════════════════════════════════════╗"
echo "║         ENVIRONMENT CHECK                  ║"
echo "╚════════════════════════════════════════════╝"
echo ""

MISSING=0
PRESENT=0

for var in "${REQUIRED_VARS[@]}"; do
    # Trim whitespace
    var=$(echo "$var" | xargs)
    [[ -z "$var" ]] && continue

    if [[ -z "${!var}" ]]; then
        echo -e "${RED}❌ MISSING: $var${NC}"
        ((MISSING++))
    else
        echo -e "${GREEN}✓ Present: $var${NC}"
        ((PRESENT++))
    fi
done

echo ""
echo "════════════════════════════════════════════"
if [[ $MISSING -gt 0 ]]; then
    echo -e "${RED}FAILED: $MISSING required variables missing${NC}"
    echo ""
    echo "Set these variables before deploying."
    exit 1
else
    echo -e "${GREEN}PASSED: All $PRESENT required variables present${NC}"
    exit 0
fi
