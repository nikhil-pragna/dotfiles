#!/bin/bash
WAVFILE="/tmp/dictation.wav"

/opt/homebrew/bin/rec -r 16000 -c 1 -b 16 "$WAVFILE"
