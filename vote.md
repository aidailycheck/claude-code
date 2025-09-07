---
allowed-tools: WebFetch, Bash(curl)
argument-hint: [sentiment|stats] [optional: why (if sentiment) or AI model (if stats)]
description: Vote on AI performance or view current stats for AI Daily Check
---

# AI Daily Check Voting

$1 represents your vote or command (genius/smart/mid/dumb/terrible/stats)
$2 represents optional context or AI model name

## If this is a stats request:

If $1 is "stats", fetch current AI performance data and display it in a formatted table.
If $2 is provided (claude/chatgpt/gemini), show stats for that specific AI.
Otherwise show stats for all AI models.

Make a GET request to https://api.aidailycheck.com/totals
Parse the response and display current performance metrics in a readable format.

## If this is a vote:

Vote $1 for the current AI model being used in this conversation.
Optional context: "$2"

Auto-detect which AI model we're currently using (Claude, ChatGPT, Gemini, etc.) from conversation context.

Use curl to make a POST request to https://api.aidailycheck.com/vote_claude_code with JSON payload:
```json
{
  "sentiment": "$1",
  "llm": "claude",
  "message": "$2",
  "source": "claude_code"
}
```

Show confirmation of the vote submission with a brief summary.

## Valid sentiments:
- genius: AI performed exceptionally well
- smart: AI performed well
- mid: AI performed average  
- dumb: AI performed poorly
- terrible: AI performed very poorly

## Examples:
- `/vote genius` - Simple positive vote
- `/vote terrible "Generated code with syntax errors"` - Vote with context
- `/vote stats` - Show all AI performance stats
- `/vote stats claude` - Show Claude-specific stats
