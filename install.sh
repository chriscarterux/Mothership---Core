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

# Ask for version
echo "Which version?"
echo "  1) lite  - One file, ~200 lines, simple"
echo "  2) full  - Specialized agents, more control"
echo ""
read -p "Choice [1/2]: " VERSION_CHOICE

case "$VERSION_CHOICE" in
    2|full) VERSION="full" ;;
    *) VERSION="lite" ;;
esac

# Create .mothership directory
mkdir -p .mothership

# Download files
BASE_URL="https://raw.githubusercontent.com/chriscarterux/Mothership/main"

if [ "$VERSION" == "lite" ]; then
    echo "Downloading lite version..."
    curl -fsSL "$BASE_URL/lite/mothership.md" -o .mothership/mothership.md
else
    echo "Downloading full version..."
    mkdir -p .mothership/agents
    curl -fsSL "$BASE_URL/full/mothership.md" -o .mothership/mothership.md
    curl -fsSL "$BASE_URL/full/agents/oracle.md" -o .mothership/agents/oracle.md
    curl -fsSL "$BASE_URL/full/agents/drone.md" -o .mothership/agents/drone.md
    curl -fsSL "$BASE_URL/full/agents/probe.md" -o .mothership/agents/probe.md
    curl -fsSL "$BASE_URL/full/agents/overseer.md" -o .mothership/agents/overseer.md
    curl -fsSL "$BASE_URL/full/config.json" -o .mothership/config.json
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
echo "  .mothership/         - Agent configuration"
echo "  mothership.sh        - Loop script"
echo ""
echo "Next steps:"
echo "  1. Add docs to ./docs/ describing your feature"
echo "  2. Tell your AI: \"Read .mothership/mothership.md and run: plan [feature]\""
echo "  3. Or loop it: ./mothership.sh build 20"
echo ""
echo "The Mothership awaits your command. 🛸"
