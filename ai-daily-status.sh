#!/bin/bash

# AI Daily Check Status Bar Script
# Simplified version based on claude-stats.sh

# Get session data from stdin
input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')

# Create session tracking directory if it doesn't exist
session_dir="$HOME/.claude/sessions"
mkdir -p "$session_dir"

session_file="$session_dir/$session_id"
current_time=$(date +%s)

# Check if this is a new session or if we're within the display window
if [ ! -f "$session_file" ]; then
    # New session - record the start time
    echo "$current_time" > "$session_file"
    show_stats=true
else
    # Existing session - check if 5 seconds have passed
    session_start=$(cat "$session_file" 2>/dev/null || echo "0")
    elapsed=$((current_time - session_start))
    
    if [ "$elapsed" -lt 5 ]; then
        show_stats=true
    else
        show_stats=false
    fi
fi

# If we shouldn't show stats, just exit silently
if [ "$show_stats" != "true" ]; then
    exit 0
fi

# Fetch Claude stats
API_URL="https://api.aidailycheck.com/totals"
response=$(curl -s --connect-timeout 3 --max-time 5 "$API_URL" 2>/dev/null)

# Simple error checking
if [ -z "$response" ] || ! echo "$response" | jq . >/dev/null 2>&1; then
    echo "AI Daily: offline 🔌"
    exit 0
fi

# Extract Claude's vote counts
genius=$(echo "$response" | jq -r '.data.claude.genius // 0')
smart=$(echo "$response" | jq -r '.data.claude.smart // 0')
mid=$(echo "$response" | jq -r '.data.claude.mid // 0')
dumb=$(echo "$response" | jq -r '.data.claude.dumb // 0')
terrible=$(echo "$response" | jq -r '.data.claude.terrible // 0')

# Calculate total votes
total=$((genius + smart + mid + dumb + terrible))

# Handle case where there are no votes
if [ "$total" -eq 0 ]; then
    echo "AI Daily: no votes yet"
    exit 0
fi

# Calculate percentages
genius_pct=$(echo "scale=1; $genius * 100 / $total" | bc -l 2>/dev/null | sed 's/\.0$//')
smart_pct=$(echo "scale=1; $smart * 100 / $total" | bc -l 2>/dev/null | sed 's/\.0$//')
mid_pct=$(echo "scale=1; $mid * 100 / $total" | bc -l 2>/dev/null | sed 's/\.0$//')
dumb_pct=$(echo "scale=1; $dumb * 100 / $total" | bc -l 2>/dev/null | sed 's/\.0$//')
terrible_pct=$(echo "scale=1; $terrible * 100 / $total" | bc -l 2>/dev/null | sed 's/\.0$//')

# Format output with emojis and percentages
printf "AI Daily Check 🤯 %s%% 🧠 %s%% 😐 %s%% 🤔 %s%% 🤦 %s%%" "$genius_pct" "$smart_pct" "$mid_pct" "$dumb_pct" "$terrible_pct"