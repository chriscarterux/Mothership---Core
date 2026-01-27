#!/bin/bash
# load-skill.sh - Load a skill and format it for any AI tool
# Usage: ./scripts/load-skill.sh <skill-name> [ai-tool]
#
# Examples:
#   ./scripts/load-skill.sh build
#   ./scripts/load-skill.sh quick-check gemini
#   ./scripts/load-skill.sh verify-env codex

set -e

SKILL_NAME="$1"
AI_TOOL="${2:-auto}"
SKILLS_DIR="$(dirname "$0")/../skills"

# Find skill file
find_skill() {
    local name="$1"
    local skill_file=""

    # Search in all skill directories
    for dir in development verification infrastructure utility; do
        if [[ -f "$SKILLS_DIR/$dir/$name.skill.md" ]]; then
            skill_file="$SKILLS_DIR/$dir/$name.skill.md"
            break
        fi
    done

    # Also check root skills dir
    if [[ -z "$skill_file" && -f "$SKILLS_DIR/$name.skill.md" ]]; then
        skill_file="$SKILLS_DIR/$name.skill.md"
    fi

    echo "$skill_file"
}

# Format skill for specific AI tool
format_for_ai() {
    local skill_content="$1"
    local ai_tool="$2"

    case "$ai_tool" in
        claude)
            # Claude can read markdown directly
            echo "$skill_content"
            echo ""
            echo "Execute this skill now. Output the appropriate signal when done."
            ;;
        gemini)
            # Gemini prompt format
            echo "You are a coding assistant. Follow these instructions exactly:"
            echo ""
            echo "$skill_content"
            echo ""
            echo "Execute each step. Output the signal specified when complete."
            ;;
        codex)
            # Codex prompt format
            echo "# Instructions"
            echo ""
            echo "$skill_content"
            echo ""
            echo "# Execute"
            echo "Follow the steps above. Output the completion signal."
            ;;
        opencode)
            # OpenCode prompt format
            echo "$skill_content"
            echo ""
            echo "Run this skill. Output signal when done."
            ;;
        *)
            # Generic format
            echo "$skill_content"
            ;;
    esac
}

# Detect AI tool if auto
detect_ai() {
    if command -v claude &> /dev/null; then
        echo "claude"
    elif command -v gemini &> /dev/null; then
        echo "gemini"
    elif command -v codex &> /dev/null; then
        echo "codex"
    elif command -v opencode &> /dev/null; then
        echo "opencode"
    else
        echo "generic"
    fi
}

# Main
if [[ -z "$SKILL_NAME" ]]; then
    echo "Usage: $0 <skill-name> [ai-tool]"
    echo ""
    echo "Available skills:"
    find "$SKILLS_DIR" -name "*.skill.md" -exec basename {} .skill.md \; | sort | sed 's/^/  /'
    exit 1
fi

SKILL_FILE=$(find_skill "$SKILL_NAME")

if [[ -z "$SKILL_FILE" || ! -f "$SKILL_FILE" ]]; then
    echo "Error: Skill '$SKILL_NAME' not found"
    echo ""
    echo "Available skills:"
    find "$SKILLS_DIR" -name "*.skill.md" -exec basename {} .skill.md \; | sort | sed 's/^/  /'
    exit 1
fi

if [[ "$AI_TOOL" == "auto" ]]; then
    AI_TOOL=$(detect_ai)
fi

SKILL_CONTENT=$(cat "$SKILL_FILE")
format_for_ai "$SKILL_CONTENT" "$AI_TOOL"
