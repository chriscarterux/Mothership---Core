#!/bin/bash
# Mothership 2.0 - Zero-config autonomous loop
# Usage: ./m2 [goal]   or just: ./m2

set -e

STATE_FILE=".mothership/state.json"
GOAL="$*"

# Colors
R='\033[0;31m' G='\033[0;32m' Y='\033[0;33m' B='\033[0;34m' C='\033[0;36m' N='\033[0m'

# Ensure state dir exists
mkdir -p .mothership

# Auto-detect AI
detect_ai() {
    for cmd in claude gemini codex opencode; do
        command -v "$cmd" &>/dev/null && echo "$cmd" && return
    done
    echo ""
}

# Auto-detect stack
detect_stack() {
    local stack=""
    [[ -f "package.json" ]] && stack="node"
    [[ -f "requirements.txt" || -f "pyproject.toml" ]] && stack="python"
    [[ -f "go.mod" ]] && stack="go"
    [[ -f "Cargo.toml" ]] && stack="rust"
    [[ -f "Gemfile" ]] && stack="ruby"
    [[ -f "composer.json" ]] && stack="php"
    echo "${stack:-unknown}"
}

# Auto-detect what needs doing
detect_next() {
    # Priority 1: Uncommitted changes → build/test
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo "commit"
        return
    fi

    # Priority 2: Failing tests → fix
    if ! run_tests_quiet; then
        echo "fix"
        return
    fi

    # Priority 3: Open stories → build
    if [[ -f ".mothership/stories.md" ]] && grep -q "^\- \[ \]" .mothership/stories.md 2>/dev/null; then
        echo "build"
        return
    fi

    # Priority 4: No stories → plan
    if [[ ! -f ".mothership/stories.md" ]] || ! grep -q "^\- \[" .mothership/stories.md 2>/dev/null; then
        echo "plan"
        return
    fi

    # Priority 5: All done → review
    echo "review"
}

# Stack-aware test runner
run_tests_quiet() {
    case "$(detect_stack)" in
        node)   npm test --if-present 2>/dev/null ;;
        python) pytest -q 2>/dev/null || python -m pytest -q 2>/dev/null ;;
        go)     go test ./... 2>/dev/null ;;
        rust)   cargo test --quiet 2>/dev/null ;;
        ruby)   bundle exec rspec --format progress 2>/dev/null ;;
        *)      return 0 ;;  # Unknown stack, assume OK
    esac
}

# Stack-aware build
run_build() {
    case "$(detect_stack)" in
        node)   npm run build --if-present 2>/dev/null ;;
        python) python -m py_compile *.py 2>/dev/null ;;
        go)     go build ./... 2>/dev/null ;;
        rust)   cargo build --quiet 2>/dev/null ;;
        *)      return 0 ;;
    esac
}

# Stack-aware lint
run_lint() {
    case "$(detect_stack)" in
        node)   npm run lint --if-present 2>/dev/null ;;
        python) ruff check . 2>/dev/null || flake8 . 2>/dev/null ;;
        go)     golint ./... 2>/dev/null ;;
        rust)   cargo clippy --quiet 2>/dev/null ;;
        *)      return 0 ;;
    esac
}

# Quick health check
health_check() {
    local pass=0 fail=0

    echo -e "${B}Health Check${N}"

    # Build
    if run_build; then
        echo -e "  ${G}✓${N} Build"
        ((pass++))
    else
        echo -e "  ${R}✗${N} Build"
        ((fail++))
    fi

    # Tests
    if run_tests_quiet; then
        echo -e "  ${G}✓${N} Tests"
        ((pass++))
    else
        echo -e "  ${R}✗${N} Tests"
        ((fail++))
    fi

    # Lint
    if run_lint; then
        echo -e "  ${G}✓${N} Lint"
        ((pass++))
    else
        echo -e "  ${Y}~${N} Lint"
    fi

    echo ""
    if [[ $fail -eq 0 ]]; then
        echo -e "${G}All checks passed${N}"
        return 0
    else
        echo -e "${R}$fail check(s) failed${N}"
        return 1
    fi
}

# Save state
save_state() {
    local phase="$1"
    local story="$2"
    cat > "$STATE_FILE" << EOF
{
  "phase": "$phase",
  "story": "$story",
  "stack": "$(detect_stack)",
  "updated": "$(date -Iseconds)"
}
EOF
}

# Load state
load_state() {
    if [[ -f "$STATE_FILE" ]]; then
        cat "$STATE_FILE"
    else
        echo '{"phase": "init"}'
    fi
}

# Build the AI prompt - context-aware, minimal
build_prompt() {
    local action="$1"
    local context=""

    # Add goal if provided
    [[ -n "$GOAL" ]] && context="Goal: $GOAL\n"

    # Add current stories if they exist
    if [[ -f ".mothership/stories.md" ]]; then
        context+="Stories:\n$(cat .mothership/stories.md)\n"
    fi

    # Add recent git context
    context+="Recent: $(git log --oneline -3 2>/dev/null | tr '\n' ' ')\n"

    # Minimal action-specific prompt
    case "$action" in
        plan)
            echo -e "${context}Create atomic stories in .mothership/stories.md. Format: - [ ] [TYPE] Title. Types: ui/api/database/integration. Each needs verifiable AC. Signal: <vector>PLANNED:N</vector>"
            ;;
        build)
            echo -e "${context}Build the next unchecked story. Verify before commit. Mark done: - [x]. Signal: <cipher>BUILT:ID</cipher> or <cipher>BUILD-COMPLETE</cipher>"
            ;;
        fix)
            echo -e "${context}Tests are failing. Fix them. Signal: <cortex>FIXED</cortex>"
            ;;
        commit)
            echo -e "${context}Uncommitted changes detected. Review, test, commit if good. Signal: <cipher>COMMITTED</cipher>"
            ;;
        review)
            echo -e "${context}All stories done. Final review for gaps, security, edge cases. Signal: <sentinel>APPROVED</sentinel>"
            ;;
    esac
}

# Run AI with prompt
run_ai() {
    local prompt="$1"
    local ai=$(detect_ai)

    if [[ -z "$ai" ]]; then
        echo -e "${R}No AI found. Install: claude, gemini, codex, or opencode${N}"
        exit 1
    fi

    case "$ai" in
        claude)   claude --print -p "$prompt" ;;
        gemini)   gemini "$prompt" ;;
        codex)    codex "$prompt" ;;
        opencode) opencode "$prompt" ;;
    esac
}

# Main
main() {
    local ai=$(detect_ai)
    local stack=$(detect_stack)
    local next=$(detect_next)

    echo -e "${C}┌─────────────────────────────────────┐${N}"
    echo -e "${C}│${N}  ${B}Mothership${N}                         ${C}│${N}"
    echo -e "${C}├─────────────────────────────────────┤${N}"
    echo -e "${C}│${N}  AI: ${G}${ai:-none}${N}  Stack: ${Y}${stack}${N}          ${C}│${N}"
    echo -e "${C}│${N}  Next: ${B}${next}${N}                        ${C}│${N}"
    echo -e "${C}└─────────────────────────────────────┘${N}"
    echo ""

    # If goal provided, always plan first
    if [[ -n "$GOAL" && "$next" != "commit" && "$next" != "fix" ]]; then
        next="plan"
    fi

    # Quick health check first
    if [[ "$next" != "plan" ]]; then
        health_check || true
        echo ""
    fi

    # Save state
    save_state "$next" ""

    # Build and run
    local prompt=$(build_prompt "$next")
    echo -e "${G}▶ Running: $next${N}"
    echo ""

    run_ai "$prompt"
}

# Handle help
if [[ "$1" == "-h" || "$1" == "help" || "$1" == "--help" ]]; then
    echo -e "${B}Mothership 2.0${N} - Zero-config autonomous loop"
    echo ""
    echo "Usage:"
    echo "  ./m2              Auto-detect what to do next"
    echo "  ./m2 [goal]       Start with a goal"
    echo "  ./m2 check        Just run health checks"
    echo ""
    echo "It figures out:"
    echo "  • Your stack (node/python/go/rust/ruby)"
    echo "  • What needs doing (plan/build/fix/commit/review)"
    echo "  • Which AI to use (claude/gemini/codex/opencode)"
    echo ""
    echo "State saved in: .mothership/"
    exit 0
fi

# Handle check-only mode
if [[ "$1" == "check" ]]; then
    health_check
    exit $?
fi

main
