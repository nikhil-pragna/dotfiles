#!/bin/bash

# This script is called by tmux's copy-pipe-and-cancel command.
# It reads a file path (potentially with line/column numbers) from standard input.
# It then attempts to open the file in the most recently used Neovim pane within the current tmux session.
# If no Neovim pane is found in the current session, it opens the file in a new tmux window in the current session.

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

# Construct the Neovim command for a *new* window.
# We use `printf %q` to safely escape the filename for the shell,
# preventing issues with spaces or special characters.
escaped_file=$(printf "%q" "$file")
new_window_nvim_cmd="nvim"
if [[ -n "$line" ]]; then
  new_window_nvim_cmd="$new_window_nvim_cmd +$line"
  if [[ -n "$col" ]]; then
    new_window_nvim_cmd="$new_window_nvim_cmd -c \"normal! ${col}|zz\""
  fi
fi
new_window_nvim_cmd="$new_window_nvim_cmd $escaped_file"

# Construct the Neovim Ex command to send to an *existing* instance.
# This command uses '|' to chain Ex commands.
existing_nvim_ex_cmd=":e ${escaped_file}"
if [[ -n "$line" ]]; then
  existing_nvim_ex_cmd="${existing_nvim_ex_cmd} | ${line}" # Go to line
  if [[ -n "$col" ]]; then
    existing_nvim_ex_cmd="${existing_nvim_ex_cmd} | normal! ${col}|" # Go to column
  fi
fi

# Get the current session ID.
current_session_id=$(tmux display-message -p '#{session_id}')

# Try to find the most recently active Neovim pane within the CURRENT SESSION.
# List all panes, filter for Neovim (using pane_current_command) AND current session, and sort by last activity.
# Format: pane_id:current_command:last_activity_timestamp:session_id:window_id
nvim_panes_info=$(tmux list-panes -a -F '#{pane_id}:#{pane_current_command}:#{pane_last_activity}:#{session_id}:#{window_id}' | \
                  awk -F: -v current_sid="$current_session_id" '$2 ~ /nvim/ && $4 == current_sid {print}' | \
                  sort -t: -k3,3nr) # Sort by last_activity_timestamp (field 3) descending numerically

target_pane_id=""
target_window_id=""
open_in_new_window=true

if [[ -n "$nvim_panes_info" ]]; then
  # Pick the first one (most recently active Neovim pane in the current session).
  first_nvim_pane=$(echo "$nvim_panes_info" | head -n 1)
  IFS=':' read -r target_pane_id _ _ _ target_window_id <<< "$first_nvim_pane" # session_id is already filtered for current_session_id

  if [[ -n "$target_pane_id" ]]; then
    # Send the Neovim Ex command to the identified Neovim pane.
    tmux send-keys -t "$target_pane_id" "$existing_nvim_ex_cmd" C-m

    # Switch to that window/pane within the current session.
    current_window_id=$(tmux display-message -p '#{window_id}')
    current_pane_id=$(tmux display-message -p '#{pane_id}')

    # Only switch if necessary to avoid redundant tmux commands
    if [[ "$target_window_id" != "$current_window_id" ]]; then
      tmux select-window -t "$target_window_id"
    fi
    # Select pane must be after select window if they are different
    if [[ "$target_pane_id" != "$current_pane_id" ]]; then
      tmux select-pane -t "$target_pane_id"
    fi
    open_in_new_window=false
  fi
fi

# If no Neovim pane was found in the current session, or could not be targeted, open in a new window.
if [[ "$open_in_new_window" = true ]]; then
  tmux new-window -c "$new_window_nvim_cmd"
fi
```
