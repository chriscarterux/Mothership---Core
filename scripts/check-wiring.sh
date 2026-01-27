#!/bin/bash
# check-wiring.sh - Detect unwired UI handlers
# Exit code 1 = issues found, 0 = clean
# Run in CI to block PRs with unwired components

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ISSUES=0
SRC_DIR="${1:-src}"

echo "╔════════════════════════════════════════════╗"
echo "║         UI WIRING CHECK                    ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Check for empty onClick handlers
echo "Checking for empty onClick handlers..."
EMPTY_ONCLICK=$(grep -rn "onClick={}" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$EMPTY_ONCLICK" ]]; then
    echo -e "${RED}❌ Empty onClick handlers found:${NC}"
    echo "$EMPTY_ONCLICK" | head -20
    ISSUES=$((ISSUES + $(echo "$EMPTY_ONCLICK" | wc -l)))
fi

# Check for empty onSubmit handlers
echo "Checking for empty onSubmit handlers..."
EMPTY_ONSUBMIT=$(grep -rn "onSubmit={}" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$EMPTY_ONSUBMIT" ]]; then
    echo -e "${RED}❌ Empty onSubmit handlers found:${NC}"
    echo "$EMPTY_ONSUBMIT" | head -20
    ISSUES=$((ISSUES + $(echo "$EMPTY_ONSUBMIT" | wc -l)))
fi

# Check for empty onChange handlers
echo "Checking for empty onChange handlers..."
EMPTY_ONCHANGE=$(grep -rn "onChange={}" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$EMPTY_ONCHANGE" ]]; then
    echo -e "${RED}❌ Empty onChange handlers found:${NC}"
    echo "$EMPTY_ONCHANGE" | head -20
    ISSUES=$((ISSUES + $(echo "$EMPTY_ONCHANGE" | wc -l)))
fi

# Check for empty arrow functions as handlers
echo "Checking for empty arrow function handlers..."
EMPTY_ARROWS=$(grep -rn "() => {}" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$EMPTY_ARROWS" ]]; then
    echo -e "${RED}❌ Empty arrow function handlers found:${NC}"
    echo "$EMPTY_ARROWS" | head -20
    ISSUES=$((ISSUES + $(echo "$EMPTY_ARROWS" | wc -l)))
fi

# Check for undefined handlers
echo "Checking for undefined handlers..."
UNDEFINED_HANDLERS=$(grep -rn "={undefined}" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$UNDEFINED_HANDLERS" ]]; then
    echo -e "${RED}❌ Undefined handlers found:${NC}"
    echo "$UNDEFINED_HANDLERS" | head -20
    ISSUES=$((ISSUES + $(echo "$UNDEFINED_HANDLERS" | wc -l)))
fi

# Check for console.log only handlers
echo "Checking for console-only handlers..."
CONSOLE_ONLY=$(grep -rn "onClick={() => console.log" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$CONSOLE_ONLY" ]]; then
    echo -e "${YELLOW}⚠️  Console-only handlers (likely placeholders):${NC}"
    echo "$CONSOLE_ONLY" | head -10
    # Warning only, not a failure
fi

# Check for TODO/FIXME in handlers
echo "Checking for TODO/FIXME in event handlers..."
TODO_HANDLERS=$(grep -rn "on[A-Z].*TODO\|on[A-Z].*FIXME" "$SRC_DIR" 2>/dev/null || true)
if [[ -n "$TODO_HANDLERS" ]]; then
    echo -e "${YELLOW}⚠️  TODO/FIXME in handlers:${NC}"
    echo "$TODO_HANDLERS" | head -10
fi

echo ""
echo "════════════════════════════════════════════"
if [[ $ISSUES -gt 0 ]]; then
    echo -e "${RED}FAILED: $ISSUES unwired handlers found${NC}"
    echo ""
    echo "Fix these issues before merging."
    exit 1
else
    echo -e "${GREEN}PASSED: No unwired handlers found${NC}"
    exit 0
fi
