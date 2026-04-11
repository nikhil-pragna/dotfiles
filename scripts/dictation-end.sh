#!/bin/bash
WAVFILE="/tmp/dictation.wav"

WHISPER="$HOME/work/thirdparty/whisper.cpp/build/bin/whisper-cli"
MODEL="$HOME/work/thirdparty/whisper.cpp/models/ggml-small.en.bin"

if [ ! -f "$WAVFILE" ]; then
  exit 1
fi

# Transcribe
TEXT=$("$WHISPER" -m "$MODEL" -f "$WAVFILE" --no-timestamps -nt 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Paste into active window
if [ -n "$TEXT" ]; then
  echo -n "$TEXT" | /usr/bin/pbcopy
  osascript -e 'tell application "System Events" to keystroke "v" using command down'
fi
