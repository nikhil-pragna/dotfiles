#!/bin/bash

KITTY_CONFIG="$HOME/.dotfiles/.config/kitty/kitty.conf"
NVIM_CONFIG="$HOME/.dotfiles/.config/nvim/lua/plugins/colorscheme.lua"
THEME_FILE="$HOME/.theme_state"

# Initialize theme state file if it doesn't exist
if [ ! -f "$THEME_FILE" ]; then
    echo "mocha" >"$THEME_FILE"
fi

current_theme=$(cat "$THEME_FILE")

toggle_theme() {
    if [ "$current_theme" = "mocha" ]; then
        # Switch to latte
        sed -i '' 's/mocha/latte/g' "$KITTY_CONFIG"
        sed -i '' "s/mocha/latte/g" "$NVIM_CONFIG"
        echo "latte" >"$THEME_FILE"
        killall -SIGUSR1 kitty
        # Switch macOS to light mode
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
        echo "Switched to Latte theme"
    else
        # Switch to mocha
        sed -i '' 's/latte/mocha/g' "$KITTY_CONFIG"
        sed -i '' 's/latte/mocha/g' "$NVIM_CONFIG"
        echo "mocha" >"$THEME_FILE"
        killall -SIGUSR1 kitty
        # Switch macOS to dark mode
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
        echo "Switched to Mocha theme"
    fi
}

toggle_theme
