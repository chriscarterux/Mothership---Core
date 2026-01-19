#!/bin/bash
# Mothership Loop - Iterative build/test/plan automation

set -e
trap 'echo -e "\n\n🛸 Mothership interrupted. Progress saved to progress.md"; exit 130' INT

MODE="${1:-build}"
MAX_ITERATIONS="${2:-10}"
PLAN_CONTEXT="$2"

# Detect version
if [[ -d ".mothership/drones" ]]; then
    VERSION="full"
else
    VERSION="lite"
fi

# Set completion signals based on mode
case "$MODE" in
    build)  SIGNALS="BUILD-COMPLETE|COMPLETE" ;;
    test)   SIGNALS="TEST-COMPLETE|COMPLETE" ;;
    plan)   SIGNALS="PLANNED"; MAX_ITERATIONS=1 ;;
    review) SIGNALS="APPROVED|NEEDS-WORK"; MAX_ITERATIONS=1 ;;
    *)      echo "Usage: ./mothership.sh [build|test|plan|review] [max_iterations|context]"; exit 1 ;;
esac

echo "🛸 Mothership Loop - Mode: $MODE, Max: $MAX_ITERATIONS iterations ($VERSION)"
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting $MODE mode" >> progress.md

for ((i=1; i<=MAX_ITERATIONS; i++)); do
    echo "═══════════════════════════════════════════════════════"
    echo " Iteration $i of $MAX_ITERATIONS"
    echo "═══════════════════════════════════════════════════════"
    
    # Build the prompt
    if [[ "$MODE" == "plan" && -n "$PLAN_CONTEXT" ]]; then
        PROMPT="@.mothership Plan: $PLAN_CONTEXT"
    else
        PROMPT="@.mothership Continue $MODE mode. Check status and proceed."
    fi
    
    # Run amp and capture output
    OUTPUT=$(amp "$PROMPT" 2>&1) || true
    echo "$OUTPUT"
    
    # Log to progress.md
    echo "" >> progress.md
    echo "### Iteration $i - $(date '+%H:%M:%S')" >> progress.md
    echo '```' >> progress.md
    echo "$OUTPUT" | tail -50 >> progress.md
    echo '```' >> progress.md
    
    # Check for completion signals
    if echo "$OUTPUT" | grep -qE "<drone>($SIGNALS)</drone>"; then
        echo ""
        echo "🛸 Mothership complete! Finished at iteration $i."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Completed at iteration $i" >> progress.md
        exit 0
    fi
    
    # Also check for signal without drone tags (flexibility)
    if echo "$OUTPUT" | grep -qE "^($SIGNALS)$"; then
        echo ""
        echo "🛸 Mothership complete! Finished at iteration $i."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Completed at iteration $i" >> progress.md
        exit 0
    fi
    
    echo ""
    echo "Iteration $i complete. Continuing..."
    echo ""
    sleep 1
done

echo ""
echo "🛸 Mothership reached max iterations ($MAX_ITERATIONS). Review progress.md for status."
echo "$(date '+%Y-%m-%d %H:%M:%S') - Reached max iterations" >> progress.md
exit 1
