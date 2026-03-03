#!/bin/bash
BG="default"
win=$(tmux display-message -p '#{session_windows}')
path=$(tmux display-message -p '#{pane_current_path}')
branch=$(git -C "$path" branch --show-current 2>/dev/null)
batt=$(pmset -g batt | grep -Eo '[0-9]+%' | head -1)
time=$(date +%H:%M)

# Create a styled pill: left-round + colored content + right-round
pill() {
    echo -n "#[fg=$1,bg=$BG]#[fg=#1a1b26,bg=$1,bold] $2 $3 #[fg=$1,bg=$BG] "
}

right=""
# Git segment (≤3 tabs)
if [ "$win" -le 3 ] && [ -n "$branch" ]; then
    right="${right}$(pill '#7aa2f7' '' "$branch")"
fi
# Battery segment (≤6 tabs)
if [ "$win" -le 6 ] && [ -n "$batt" ]; then
    right="${right}$(pill '#bb9af7' '' "$batt")"
fi
# Time segment (always)
right="${right}$(pill '#9ece6a' '' "$time")"

echo "$right"
