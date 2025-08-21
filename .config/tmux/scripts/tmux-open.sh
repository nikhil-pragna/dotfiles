#!/bin/bash
#
# Reads a file path from stdin, strips any trailing line/column numbers,
# and opens it using the default system application.

input=$(cat)

# Exit if stdin is empty
if [ -z "$input" ]; then
  exit 0
fi

# Regex to match file paths like /path/to/file:123 or /path/to/file:123:45
if [[ "$input" =~ ^(.*)(:[0-9]+:[0-9]+|:[0-9]+)$ ]]; then
  echo "Match found: $input"
  file="${BASH_REMATCH[0]}"
else
  file="$input"
fi

# Use 'open' on macOS or 'xdg-open' on Linux
if command -v open &>/dev/null; then
  echo "Opening $file with 'open'"
  open "$file"
elif command -v xdg-open &>/dev/null; then
  xdg-open "$file"
fi
