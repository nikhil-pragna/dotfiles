#!/bin/bash

CATEGORIES=(
  "BASH"
  "BILLINN"
  "CONFIG"
  "WASTED"
  "STOP"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | fzf --margin 10% --color="bw" --bind 'q:abort')
sk_status=$?

if [[ $sk_status -ne 0 || -z "$selected" ]]; then
  exit 0
fi

if [[ "$selected" == "STOP" ]]; then
  timew stop
else
  timew start "$selected"
fi
