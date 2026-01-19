#!/bin/bash

set -e

# Colors for alien-themed output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}"
cat << 'EOF'
    .     .       .  .   . .   .   . .    +  .
      .     .  :     .    .. :. .___---------___.
           .  .   .    .  :.:. _".^ .^ ^.  '.. :"-_. .
        .  :       .  .  .:../:            . .^  :.:\.
            .   . :: +. :.:/: .   .    .        . . .:\
     .  :    .     . _ :::/:               .  ^ .  . .:\
      .. . .   . - : :.:./.                        .  .:\
      .      .     . :..|:                    .  .  ^. .:|
        .       . : : ..||        .                . . !:|
      .     . . . ::. ::\(                           . :)/
     .   .     : . : .:.|. ######              .#######::|
      :.. .  ணை .  . :googly . #######          ########:|
     .  .  .  . :  :  : :|:. ########       ########  :|
      .        .+ :: : :.:./ ####### / _)    ########  :/
       .## ## #..: .# #: ::/  ###### /_/      ######## :/
      .  .googly## : :#: : :./googly ########.googly ######  .googly#  :/
         : .googly## :# :: :googly:/  ###### #  .  #### googly ######   :/
      + googly+##.#: .googly :#: :_googly/+googly  ## ### + +.### #+ #### ### :/
      ...googly ## ### .## :  ::/_ ### ###   # ######  ### ### :/
        .:# # #  # ### :: ::/ _ ### ## ### ## ## ## #   :. :/
        ..### ###  #   ## :/  ## ## ## ### ##  ### ##  :/
          :.. .... . : :/ . ##  ##  ##  ### ##  ##  ### . :|
         .   .   .  . :| .  . .      .        . :|
              . .   |:  .     . .         .  . /
        .          .:. . .  .     . + .      .:/
        .   .            :. . .    .  . . . ::/
           .  .   . . . :.  :.:    .:  .  . :/
        .      .   .   .  .  :: . .. + . . :/
         .   .       .  :  .+:  .  . + .  :|
         .   .  . .  . : :|..   . .    . :|
             .. :+ .. .+:. .. . .  .  . /
                .  .  .:  . .     . . :/
               .  . . .:  :  .  .   :/
                . . :. :: .       :/
               . +.  :. . . :    :/
               . . :  : . . :   /
                   .   .. : . :|
                   . . .. :. /
                      .  : :/
                     . .  :/
                       . /
                        /
EOF
echo -e "${NC}"

echo -e "${CYAN}🛸 MOTHERSHIP INSTALLATION PROTOCOL${NC}"
echo -e "${YELLOW}   Initiating colonization sequence...${NC}"
echo ""

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MOTHERSHIP_SOURCE="$SCRIPT_DIR/.mothership"
TARGET_DIR="$(pwd)/.mothership"

# Check if .mothership source exists
if [ ! -d "$MOTHERSHIP_SOURCE" ]; then
    echo -e "${RED}⚠️  ERROR: Source .mothership folder not found at $MOTHERSHIP_SOURCE${NC}"
    echo -e "${YELLOW}   The mothership seems to have... vanished. Very concerning.${NC}"
    exit 1
fi

# Check if already installed
if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}⚠️  WARNING: .mothership already detected in this sector!${NC}"
    echo -e "   Previous colonization attempt found at: $TARGET_DIR"
    echo ""
    read -p "   Overwrite existing installation? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}   Colonization aborted. The existing settlement remains undisturbed.${NC}"
        exit 0
    fi
    echo -e "${YELLOW}   Dismantling previous installation...${NC}"
    rm -rf "$TARGET_DIR"
fi

# Copy .mothership folder
echo -e "${CYAN}📡 Beaming down mothership components...${NC}"
cp -r "$MOTHERSHIP_SOURCE" "$TARGET_DIR"

if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}⚠️  ERROR: Failed to materialize .mothership folder${NC}"
    echo -e "${YELLOW}   Transporter malfunction. Please try again.${NC}"
    exit 1
fi

echo -e "${GREEN}   ✓ Components successfully materialized${NC}"

# Prompt for Linear team name
echo ""
echo -e "${CYAN}🔧 Configuration Protocol${NC}"
echo -e "   Enter your Linear team name (for issue tracking integration)"
read -p "   Team name [springfield]: " TEAM_NAME
TEAM_NAME="${TEAM_NAME:-springfield}"

# Update config.json
CONFIG_FILE="$TARGET_DIR/config.json"
if [ -f "$CONFIG_FILE" ]; then
    echo -e "${CYAN}   Updating navigation systems...${NC}"
    # Use sed to replace the team name in config
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\"team\": \"[^\"]*\"/\"team\": \"$TEAM_NAME\"/" "$CONFIG_FILE"
    else
        sed -i "s/\"team\": \"[^\"]*\"/\"team\": \"$TEAM_NAME\"/" "$CONFIG_FILE"
    fi
    echo -e "${GREEN}   ✓ Team configured: $TEAM_NAME${NC}"
else
    echo -e "${YELLOW}   ⚠ No config.json found. Creating default configuration...${NC}"
    cat > "$CONFIG_FILE" << EOF
{
  "team": "$TEAM_NAME",
  "version": "1.0.0"
}
EOF
    echo -e "${GREEN}   ✓ Configuration created${NC}"
fi

# Add to .gitignore
echo ""
echo -e "${CYAN}🔒 Cloaking sensitive materials from git...${NC}"
GITIGNORE="$(pwd)/.gitignore"

# Entries to add
GITIGNORE_ENTRIES=(
    ".mothership/checkpoint.md"
    ".mothership/codebase.md"
    ".mothership/history/"
)

# Create .gitignore if it doesn't exist
if [ ! -f "$GITIGNORE" ]; then
    touch "$GITIGNORE"
fi

# Add entries if not already present
for entry in "${GITIGNORE_ENTRIES[@]}"; do
    if ! grep -qxF "$entry" "$GITIGNORE" 2>/dev/null; then
        echo "$entry" >> "$GITIGNORE"
        echo -e "${GREEN}   ✓ Added: $entry${NC}"
    else
        echo -e "${YELLOW}   → Already cloaked: $entry${NC}"
    fi
done

# Success message
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🛸 COLONIZATION COMPLETE${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}   The Mothership awaits your command, human.${NC}"
echo ""
echo -e "${YELLOW}   NEXT STEPS:${NC}"
echo -e "   1. Review .mothership/config.json for additional settings"
echo -e "   2. Run 'mothership scan' to analyze your codebase"
echo -e "   3. Run 'mothership status' to check mission readiness"
echo ""
echo -e "${CYAN}   May your commits be atomic and your merges conflict-free.${NC}"
echo -e "${GREEN}   👽 Live long and push to main.${NC}"
echo ""
