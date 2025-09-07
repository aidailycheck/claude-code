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
echo -e "${YELLOW}Optional: Install AI Daily Check status bar?${NC}"
echo "This adds AI performance stats to your Claude Code status bar."

# Check if we can read from terminal
if [ -t 0 ]; then
    # stdin is a terminal, can read directly
    read -p "Install status bar? (y/N): " install_status
else
    # stdin is not a terminal (piped execution), try to read from tty
    if [ -r /dev/tty ]; then
        read -p "Install status bar? (y/N): " install_status < /dev/tty
    else
        echo "Unable to read user input in this environment."
        echo "Skipping status bar installation. You can install it manually later:"
        echo "  curl -sSL https://raw.githubusercontent.com/aidailycheck/claude-code/main/ai-daily-status.sh -o ~/.claude/ai-daily-status.sh"
        echo "  chmod +x ~/.claude/ai-daily-status.sh"
        echo '  # Add to ~/.claude/settings.json: "statusLine": {"type": "command", "command": "bash ~/.claude/ai-daily-status.sh"}'
        install_status="N"
    fi
fi

if [[ "$install_status" =~ ^[Yy]$ ]]; then
    STATUS_SCRIPT_URL="https://raw.githubusercontent.com/aidailycheck/claude-code/main/ai-daily-status.sh"
    STATUS_SCRIPT_PATH="$HOME/.claude/ai-daily-status.sh"
    
    echo "Downloading status bar script..."
    if curl -sSL "$STATUS_SCRIPT_URL" -o "$STATUS_SCRIPT_PATH"; then
        chmod +x "$STATUS_SCRIPT_PATH"
        echo -e "${GREEN}✅ Status bar script installed${NC}"
        
        # Check if settings.json exists and has statusLine config
        SETTINGS_FILE="$HOME/.claude/settings.json"
        if [ -f "$SETTINGS_FILE" ]; then
            echo -e "${YELLOW}⚠️  You already have a status line configured.${NC}"
            echo "To use AI Daily Check status bar, update your ~/.claude/settings.json:"
            echo '  "statusLine": {"type": "command", "command": "bash ~/.claude/ai-daily-status.sh"}'
        else
            echo "Creating settings.json with AI Daily Check status bar..."
            cat > "$SETTINGS_FILE" << 'EOF'
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/ai-daily-status.sh"
  }
}
EOF
            echo -e "${GREEN}✅ Status bar configured${NC}"
        fi
    else
        echo -e "${RED}❌ Failed to download status bar script${NC}"
    fi
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