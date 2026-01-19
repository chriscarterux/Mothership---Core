#!/bin/bash
# Mothership Loop - Iterative build/test/plan automation
# Works with any AI CLI tool (claude, cursor, aider, openai, etc.)

set -e

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Error handling
error() {
    echo -e "${RED}🛸 Error: $1${NC}" >&2
    exit 1
}

warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

info() {
    echo -e "${CYAN}🛸 $1${NC}"
}

success() {
    echo -e "${GREEN}✓ $1${NC}"
}

trap 'echo -e "\n\n${YELLOW}🛸 Interrupted. Progress saved to progress.md${NC}"; exit 130' INT

# Parse arguments
MODE="${1:-build}"
MAX_ITERATIONS="${2:-10}"
PLAN_CONTEXT="$2"

# Validate mode
case "$MODE" in
    build|test|plan|review) ;;
    -h|--help|help)
        echo "Usage: ./mothership.sh [mode] [max_iterations]"
        echo ""
        echo "Modes:"
        echo "  plan [feature]  Create stories from feature description"
        echo "  build [n]       Build features (default: 10 iterations)"
        echo "  test [n]        Run and fix tests (default: 10 iterations)"
        echo "  review          Review code quality"
        echo ""
        echo "Examples:"
        echo "  ./mothership.sh plan \"user authentication\""
        echo "  ./mothership.sh build 20"
        echo "  ./mothership.sh test 5"
        echo "  ./mothership.sh review"
        echo ""
        echo "Environment:"
        echo "  AI_TOOL    Override AI CLI detection (default: auto-detect)"
        echo "             Example: AI_TOOL=claude ./mothership.sh build"
        exit 0
        ;;
    *)
        error "Unknown mode: '$MODE'

Available modes: plan, build, test, review
Run './mothership.sh --help' for usage"
        ;;
esac

# Check for .mothership directory
if [[ ! -d ".mothership" ]]; then
    error "No .mothership/ directory found

To set up Mothership, run:
  curl -fsSL https://raw.githubusercontent.com/chriscarterux/Mothership/main/install.sh | bash

Or manually create .mothership/ with mothership.md"
fi

# Check for mothership.md
if [[ ! -f ".mothership/mothership.md" ]]; then
    error "No .mothership/mothership.md found

Run the installer to set up:
  curl -fsSL https://raw.githubusercontent.com/chriscarterux/Mothership/main/install.sh | bash"
fi

# Detect AI tool (set AI_TOOL env var or auto-detect)
if [[ -n "$AI_TOOL" ]]; then
    AI_CMD="$AI_TOOL"
    if ! command -v "$AI_CMD" &> /dev/null; then
        error "AI tool '$AI_CMD' not found in PATH

Either:
  1. Install $AI_CMD
  2. Set AI_TOOL to a valid CLI tool
  3. Add $AI_CMD to your PATH"
    fi
elif command -v amp &> /dev/null; then
    AI_CMD="amp"
elif command -v claude &> /dev/null; then
    AI_CMD="claude"
elif command -v cursor &> /dev/null; then
    AI_CMD="cursor"
else
    error "No AI CLI tool found

Install one of:
  • amp     - https://ampcode.com (recommended)
  • claude  - https://claude.ai/code
  • cursor  - https://cursor.sh
  • aider   - https://aider.chat

Or set AI_TOOL environment variable:
  AI_TOOL=my-ai-cli ./mothership.sh build"
fi

# Detect version (shard → array → matrix)
if [[ -d ".mothership/agents/enterprise" ]]; then
    VERSION="matrix"
elif [[ -d ".mothership/agents" ]]; then
    VERSION="array"
else
    VERSION="shard"
fi

# Archive previous run if exists
ARCHIVE_DIR=".mothership/archive"
if [ -f ".mothership/checkpoint.md" ]; then
    CURRENT_PROJECT=$(grep "^project:" .mothership/checkpoint.md 2>/dev/null | cut -d' ' -f2- || echo "")
    if [ -n "$CURRENT_PROJECT" ] && [ "$CURRENT_PROJECT" != "null" ]; then
        DATE=$(date +%Y-%m-%d)
        ARCHIVE_FOLDER="$ARCHIVE_DIR/$DATE-$(echo $CURRENT_PROJECT | tr ' ' '-' | tr '[:upper:]' '[:lower:]')"
        
        if [ ! -d "$ARCHIVE_FOLDER" ]; then
            info "Archiving previous run: $CURRENT_PROJECT"
            mkdir -p "$ARCHIVE_FOLDER"
            [ -f ".mothership/checkpoint.md" ] && cp .mothership/checkpoint.md "$ARCHIVE_FOLDER/"
            [ -f ".mothership/stories.json" ] && cp .mothership/stories.json "$ARCHIVE_FOLDER/"
            [ -f "progress.md" ] && cp progress.md "$ARCHIVE_FOLDER/"
        fi
    fi
fi

# Set completion signals based on mode (supports both verbose and compressed)
case "$MODE" in
    build)  SIGNALS="BUILD-COMPLETE|COMPLETE|B:[^<]+|C" ;;
    test)   SIGNALS="TEST-COMPLETE|COMPLETE|T:[^<]+" ;;
    plan)   SIGNALS="PLANNED|P:[0-9]+"; MAX_ITERATIONS=1 ;;
    review) SIGNALS="APPROVED|NEEDS-WORK|A|NW"; MAX_ITERATIONS=1 ;;
esac

# Header
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  🛸 Mothership Loop${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  Mode:       ${CYAN}$MODE${NC}"
echo -e "  Iterations: ${CYAN}$MAX_ITERATIONS${NC}"
echo -e "  Version:    ${CYAN}$VERSION${NC}"
echo -e "  AI Tool:    ${CYAN}$AI_CMD${NC}"
echo ""

# Initialize progress log
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting $MODE mode" >> progress.md

for ((i=1; i<=MAX_ITERATIONS; i++)); do
    echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"
    echo -e " Iteration ${CYAN}$i${NC} of ${CYAN}$MAX_ITERATIONS${NC}"
    echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"
    
    # Build the prompt
    if [[ "$MODE" == "plan" && -n "$PLAN_CONTEXT" ]]; then
        PROMPT="Read .mothership/mothership.md and run: plan $PLAN_CONTEXT"
    else
        PROMPT="Read .mothership/mothership.md and run: $MODE"
    fi
    
    # Run AI tool and capture output
    OUTPUT=$(echo "$PROMPT" | $AI_CMD 2>&1) || {
        EXIT_CODE=$?
        if [ $EXIT_CODE -eq 130 ]; then
            exit 130  # User interrupted
        fi
        warn "AI tool exited with code $EXIT_CODE"
    }
    echo "$OUTPUT"
    
    # Log to progress.md
    echo "" >> progress.md
    echo "### Iteration $i - $(date '+%H:%M:%S')" >> progress.md
    echo '```' >> progress.md
    echo "$OUTPUT" | tail -50 >> progress.md
    echo '```' >> progress.md
    
    # Check for completion signals (various formats)
    if echo "$OUTPUT" | grep -qE "<(mothership|vector|cortex|cipher|sentinel|arbiter|conductor|coalition|vault|telemetry)>($SIGNALS)<"; then
        echo ""
        success "Mothership complete! Finished at iteration $i."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Completed at iteration $i" >> progress.md
        exit 0
    fi
    
    # Also check for signal without tags (flexibility)
    if echo "$OUTPUT" | grep -qE "($SIGNALS)"; then
        echo ""
        success "Mothership complete! Finished at iteration $i."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Completed at iteration $i" >> progress.md
        exit 0
    fi
    
    # Check for blocked signal (verbose: BLOCKED, compressed: X:)
    if echo "$OUTPUT" | grep -qE "BLOCKED|X:[^<]+"; then
        echo ""
        warn "Agent reported BLOCKED. Check output above for details."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Blocked at iteration $i" >> progress.md
        exit 1
    fi
    
    echo ""
    info "Iteration $i complete. Continuing..."
    echo ""
    sleep 1
done

echo ""
warn "Reached max iterations ($MAX_ITERATIONS)"
echo ""
echo "Next steps:"
echo "  1. Check progress.md for status"
echo "  2. Run again with more iterations: ./mothership.sh $MODE $((MAX_ITERATIONS * 2))"
echo "  3. Check .mothership/checkpoint.md for current state"
echo ""
echo "$(date '+%Y-%m-%d %H:%M:%S') - Reached max iterations" >> progress.md
exit 1
