#!/bin/bash
win=$(tmux display-message -p '#{session_windows}')
path=$(tmux display-message -p '#{pane_current_path}')
branch=$(git -C "$path" branch --show-current 2>/dev/null)
batt=$(pmset -g batt | grep -Eo '[0-9]+%' | head -1)
time=$(date +%H:%M)

if [ "$win" -gt 6 ]; then
    # Many tabs: just time
    echo "#[fg=#9ece6a] $time "
elif [ "$win" -gt 3 ]; then
    # Medium: branch + time
    if [ -n "$branch" ]; then
        echo "#[fg=#7aa2f7] $branch #[fg=#565f89]| #[fg=#9ece6a] $time "
    else
        echo "#[fg=#9ece6a] $time "
    fi
else
    # Few tabs: full info
    right=""
    [ -n "$branch" ] && right="#[fg=#7aa2f7] $branch #[fg=#565f89]| "
    [ -n "$batt" ] && right="${right}#[fg=#bb9af7] $batt #[fg=#565f89]| "
    echo "${right}#[fg=#9ece6a] $time "
fi
