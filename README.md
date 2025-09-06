# AI Daily Check - Claude Code Integration

Vote and Check Claude Code performance directly from Claude Code with the `/vote` slash command!

## 🚀 Quick Start

Choose your preferred installation method:

### Option 1: Automatic Setup (Recommended)
```bash
# Download and run the installer
curl -sSL https://raw.githubusercontent.com/yourusername/aidailycheck-claude-code/main/install.sh | bash
```

### Option 2: Manual Installation
1. Download the `vote.md` file from this repository
2. Copy it to your Claude Code commands directory:  `~/.claude/commands/vote.md`
3. Create the directory if it doesn't exist: `mkdir -p ~/.claude/commands`
4. Restart Claude Code if it's running

## 📖 Usage

### Basic Voting
```bash
# Simple sentiment vote
/vote genius      # AI performed exceptionally well
/vote smart       # AI performed well  
/vote mid         # AI performed average
/vote dumb        # AI performed poorly
/vote terrible    # AI performed very poorly
```

### Voting with Context
```bash
# Add context about what happened
/vote genius "Perfect React component with proper error handling"
/vote terrible "Generated Python code with multiple syntax errors"
/vote smart "Good solution but missed an edge case in validation"
```

### View Current Performance
```bash
# See live performance stats
/vote stats       # Show current AI performance for all models
/vote stats claude # Show performance for specific AI model
```


## 🛠 How It Works

1. You type `/vote [sentiment] [optional context]` or `/vote stats`
2. Claude detects the AI model from conversation history  
3. Vote gets submitted to AI Daily Check community database
4. Your contribution helps others track AI performance trends

## 📊 What This Helps With

- **Performance tracking**: See which AI is performing best today
- **Issue awareness**: Know when an AI model is having problems  
- **Usage decisions**: Pick the right AI for your current task
- **Community insights**: Help others avoid frustrated debugging sessions

## 🔧 Installation Verification

After installation, verify it works:
```bash
# Check if file exists
ls ~/.claude/commands/vote.md  # or .claude/commands/vote.md for project

# Test in Claude Code
> /help          # Should show /vote command
> /vote stats    # Check current AI performance
> /vote genius   # Test voting
```

**Uninstall:**
```bash
rm ~/.claude/commands/vote.md
# or for project-level
rm .claude/commands/vote.md
```

---

Made with ❤️ for the Claude Code community

**Support**: [GitHub Issues](https://github.com/aidailycheck/claude-code/issues)
**Website**: [aidailycheck.com](https://aidailycheck.com)
