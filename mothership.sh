#!/bin/bash
# Mothership Loop - Iterative build/test/plan automation
# Works with any AI CLI tool (amp, claude, cursor, openai, etc.)

set -e
trap 'echo -e "\n\n🛸 Mothership interrupted. Progress saved to progress.md"; exit 130' INT

MODE="${1:-build}"
MAX_ITERATIONS="${2:-10}"
PLAN_CONTEXT="$2"

# Detect AI tool (set AI_TOOL env var or auto-detect)
if [[ -n "$AI_TOOL" ]]; then
    AI_CMD="$AI_TOOL"
elif command -v amp &> /dev/null; then
    AI_CMD="amp"
elif command -v claude &> /dev/null; then
    AI_CMD="claude"
elif command -v cursor &> /dev/null; then
    AI_CMD="cursor"
else
    echo "🛸 No AI CLI tool found. Set AI_TOOL env var or install amp/claude/cursor."
    echo "   Example: AI_TOOL='my-ai-cli' ./mothership.sh build"
    exit 1
fi

# Detect version
if [[ -d ".mothership/agents" ]]; then
    VERSION="full"
else
    VERSION="lite"
fi

# Archive previous run if exists
ARCHIVE_DIR=".mothership/archive"
if [ -f ".mothership/checkpoint.md" ]; then
    # Read current project from checkpoint
    CURRENT_PROJECT=$(grep "^project:" .mothership/checkpoint.md | cut -d' ' -f2-)
    if [ -n "$CURRENT_PROJECT" ] && [ "$CURRENT_PROJECT" != "null" ]; then
        DATE=$(date +%Y-%m-%d)
        ARCHIVE_FOLDER="$ARCHIVE_DIR/$DATE-$(echo $CURRENT_PROJECT | tr ' ' '-' | tr '[:upper:]' '[:lower:]')"
        
        # Only archive if this looks like a different project
        if [ ! -d "$ARCHIVE_FOLDER" ]; then
            echo "📦 Archiving previous run: $CURRENT_PROJECT"
            mkdir -p "$ARCHIVE_FOLDER"
            [ -f ".mothership/checkpoint.md" ] && cp .mothership/checkpoint.md "$ARCHIVE_FOLDER/"
            [ -f ".mothership/stories.json" ] && cp .mothership/stories.json "$ARCHIVE_FOLDER/"
            [ -f "progress.md" ] && cp progress.md "$ARCHIVE_FOLDER/"
        fi
    fi
fi

# Set completion signals based on mode
case "$MODE" in
    build)  SIGNALS="BUILD-COMPLETE|COMPLETE" ;;
    test)   SIGNALS="TEST-COMPLETE|COMPLETE" ;;
    plan)   SIGNALS="PLANNED"; MAX_ITERATIONS=1 ;;
    review) SIGNALS="APPROVED|NEEDS-WORK"; MAX_ITERATIONS=1 ;;
    *)      echo "Usage: ./mothership.sh [build|test|plan|review] [max_iterations|context]"; exit 1 ;;
esac

echo "🛸 Mothership Loop - Mode: $MODE, Max: $MAX_ITERATIONS iterations"
echo "   Version: $VERSION | AI Tool: $AI_CMD"
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting $MODE mode" >> progress.md

for ((i=1; i<=MAX_ITERATIONS; i++)); do
    echo "═══════════════════════════════════════════════════════"
    echo " Iteration $i of $MAX_ITERATIONS"
    echo "═══════════════════════════════════════════════════════"
    
    # Build the prompt
    if [[ "$MODE" == "plan" && -n "$PLAN_CONTEXT" ]]; then
        PROMPT="Read .mothership/mothership.md and run: plan $PLAN_CONTEXT"
    else
        PROMPT="Read .mothership/mothership.md and run: $MODE"
    fi
    
    # Run AI tool and capture output
    OUTPUT=$(echo "$PROMPT" | $AI_CMD 2>&1) || true
    echo "$OUTPUT"
    
    # Log to progress.md
    echo "" >> progress.md
    echo "### Iteration $i - $(date '+%H:%M:%S')" >> progress.md
    echo '```' >> progress.md
    echo "$OUTPUT" | tail -50 >> progress.md
    echo '```' >> progress.md
    
    # Check for completion signals (various formats)
    if echo "$OUTPUT" | grep -qE "<(mothership|drone|probe|oracle|overseer)>($SIGNALS)<"; then
        echo ""
        echo "🛸 Mothership complete! Finished at iteration $i."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Completed at iteration $i" >> progress.md
        exit 0
    fi
    
    # Also check for signal without tags (flexibility)
    if echo "$OUTPUT" | grep -qE "($SIGNALS)"; then
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
