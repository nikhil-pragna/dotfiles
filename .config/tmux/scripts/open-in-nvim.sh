#!/bin/bash

# This script is called by tmux's copy-pipe-and-cancel command.
# It reads a file path (potentially with line/column numbers) from standard input,
# and sends a command back to the original tmux pane to open it in Neovim.

# Read the selected text from stdin.
input=$(cat)

# Trim leading/trailing whitespace.
input=$(echo "$input" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# Default values
file="$input"
line=""
col=""

# Regex to match file:line:col
if [[ "$input" =~ ^(.*):([0-9]+):([0-9]+)$ ]]; then
  file="${BASH_REMATCH[1]}"
  line="${BASH_REMATCH[2]}"
  col="${BASH_REMATCH[3]}"
# Regex to match file:line
elif [[ "$input" =~ ^(.*):([0-9]+)$ ]]; then
  file="${BASH_REMATCH[1]}"
  line="${BASH_REMATCH[2]}"
fi

# Construct the nvim command.
# We use `printf %q` to safely escape the filename for the shell,
# preventing issues with spaces or special characters.
escaped_file=$(printf "%q" "$file")
cmd="nvim"

if [[ -n "$line" ]]; then
  cmd="$cmd +$line"
  if [[ -n "$col" ]]; then
    cmd="$cmd -c \"normal! ${col}|zz\""
  fi
fi

# The final command to be sent to the tmux pane.
full_cmd="$cmd $escaped_file"

# Send the command to the original tmux pane to be executed.
# $TMUX_PANE is an environment variable set by tmux.
tmux send-keys -t "$TMUX_PANE" "$full_cmd" C-m
