#!/bin/bash
# Mothership Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/chriscarterux/Mothership/main/install.sh | bash

set -e

echo ""
echo "🛸 Mothership Installer"
echo ""

# Detect if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository. Initialize with 'git init' first."
    exit 1
fi

# Ask for tier
echo "Which tier?"
echo "  1) shard  - One file, ~180 lines, solo devs"
echo "  2) array  - Specialized agents, teams"
echo "  3) matrix - Enterprise, governance & multi-service"
echo ""
read -p "Choice [1/2/3]: " TIER_CHOICE

case "$TIER_CHOICE" in
    2|array) TIER="array" ;;
    3|matrix) TIER="matrix" ;;
    *) TIER="shard" ;;
esac

# Create .mothership directory
mkdir -p .mothership

# Download files
BASE_URL="https://raw.githubusercontent.com/chriscarterux/Mothership/main"

if [ "$TIER" == "shard" ]; then
    echo "Downloading Shard tier..."
    curl -fsSL "$BASE_URL/shard/mothership.md" -o .mothership/mothership.md

elif [ "$TIER" == "array" ]; then
    echo "Downloading Array tier..."
    mkdir -p .mothership/agents/extras
    curl -fsSL "$BASE_URL/array/mothership.md" -o .mothership/mothership.md
    curl -fsSL "$BASE_URL/array/agents/cipher.md" -o .mothership/agents/cipher.md
    curl -fsSL "$BASE_URL/array/agents/vector.md" -o .mothership/agents/vector.md
    curl -fsSL "$BASE_URL/array/agents/cortex.md" -o .mothership/agents/cortex.md
    curl -fsSL "$BASE_URL/array/agents/sentinel.md" -o .mothership/agents/sentinel.md
    curl -fsSL "$BASE_URL/array/config.json" -o .mothership/config.json

else
    echo "Downloading Matrix tier..."
    mkdir -p .mothership/agents/extras/enterprise
    curl -fsSL "$BASE_URL/matrix/mothership.md" -o .mothership/mothership.md
    curl -fsSL "$BASE_URL/matrix/agents/cipher.md" -o .mothership/agents/cipher.md
    curl -fsSL "$BASE_URL/matrix/agents/vector.md" -o .mothership/agents/vector.md
    curl -fsSL "$BASE_URL/matrix/agents/cortex.md" -o .mothership/agents/cortex.md
    curl -fsSL "$BASE_URL/matrix/agents/sentinel.md" -o .mothership/agents/sentinel.md
    curl -fsSL "$BASE_URL/matrix/agents/extras/enterprise/arbiter.md" -o .mothership/agents/extras/enterprise/arbiter.md
    curl -fsSL "$BASE_URL/matrix/agents/extras/enterprise/conductor.md" -o .mothership/agents/extras/enterprise/conductor.md
    curl -fsSL "$BASE_URL/matrix/agents/extras/enterprise/coalition.md" -o .mothership/agents/extras/enterprise/coalition.md
    curl -fsSL "$BASE_URL/matrix/agents/extras/enterprise/vault.md" -o .mothership/agents/extras/enterprise/vault.md
    curl -fsSL "$BASE_URL/matrix/agents/extras/enterprise/telemetry.md" -o .mothership/agents/extras/enterprise/telemetry.md
    curl -fsSL "$BASE_URL/matrix/config.json" -o .mothership/config.json
fi

# Download loop script
curl -fsSL "$BASE_URL/mothership.sh" -o mothership.sh
chmod +x mothership.sh

# Create initial checkpoint
cat > .mothership/checkpoint.md << 'EOF'
phase: ready
project: null
branch: null
story: null
EOF

# Add to .gitignore
if [ -f .gitignore ]; then
    if ! grep -q "progress.md" .gitignore; then
        echo "" >> .gitignore
        echo "# Mothership" >> .gitignore
        echo "progress.md" >> .gitignore
    fi
else
    echo "# Mothership" > .gitignore
    echo "progress.md" >> .gitignore
fi

echo ""
echo "🛸 Installation complete!"
echo ""
echo "Created:"
echo "  .mothership/         - Agent configuration ($TIER tier)"
echo "  mothership.sh        - Loop script"
echo ""
echo "Next steps:"
echo "  1. Add docs to ./docs/ describing your feature"
echo "  2. Tell your AI: \"Read .mothership/mothership.md and run: plan [feature]\""
echo "  3. Or loop it: ./mothership.sh build 20"
echo ""
echo "The Mothership awaits your command. 🛸"
