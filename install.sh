#!/bin/bash

# AI Daily Check - Claude Code Integration Installer
# This script installs the /vote command for Claude Code

set -e

echo "🚀 AI Daily Check - Claude Code Integration Installer"
echo "===================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is required but not installed.${NC}"
    exit 1
fi

# Define installation path
USER_COMMANDS_DIR="$HOME/.claude/commands"
VOTE_FILE_URL="https://raw.githubusercontent.com/aidailycheck/claude-code/main/vote.md"

echo -e "${BLUE}Installing to $USER_COMMANDS_DIR...${NC}"

# Create directory if it doesn't exist
if [ ! -d "$USER_COMMANDS_DIR" ]; then
    echo "Creating directory: $USER_COMMANDS_DIR"
    mkdir -p "$USER_COMMANDS_DIR"
fi

# Backup existing vote.md if it exists
if [ -f "$USER_COMMANDS_DIR/vote.md" ]; then
    echo -e "${YELLOW}Backing up existing vote.md to vote.md.backup${NC}"
    cp "$USER_COMMANDS_DIR/vote.md" "$USER_COMMANDS_DIR/vote.md.backup"
fi

# Download the vote.md file
echo "Downloading latest vote.md..."
if curl -sSL "$VOTE_FILE_URL" -o "$USER_COMMANDS_DIR/vote.md"; then
    echo -e "${GREEN}✅ Successfully installed vote.md to $USER_COMMANDS_DIR${NC}"
else
    echo -e "${RED}❌ Failed to download vote.md${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Restart Claude Code if it's currently running"
echo "2. Test the command:"
echo "   > /help           # Should show /vote command"
echo "   > /vote stats     # Check current AI performance"
echo "   > /vote genius    # Cast a vote"
echo ""
echo "Usage examples:"
echo "   /vote genius                           # Simple vote"
echo '   /vote terrible "Generated buggy code"  # Vote with context'
echo "   /vote stats                            # View all AI stats"
echo "   /vote stats claude                     # View Claude stats"
echo ""
echo -e "${BLUE}📈 View live results: https://aidailycheck.com${NC}"
echo ""
echo "Thanks for contributing to AI performance insights! 🚀"