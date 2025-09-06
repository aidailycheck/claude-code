---
version: 1.0
allowed-tools: WebFetch
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

Make a GET request to https://aidailycheck-vote.eric-test.workers.dev/totals
Parse the response and display current performance metrics in a readable format.

## If this is a vote:

Vote $1 for the current AI model being used in this conversation.
Optional context: "$2"

Auto-detect which AI model we're currently using (Claude, ChatGPT, Gemini, etc.) from conversation context.

Make a POST request to https://aidailycheck-vote.eric-test.workers.dev/vote_claude_code with:
- sentiment: $1 (terrible, dumb, mid, smart, genius)  
- llm: auto-detected from conversation context
- message: $2 (optional context about what happened)
- client_version: "1.0" (from this command's frontmatter version)

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