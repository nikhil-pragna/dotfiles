#!/bin/bash
set -e

cd "$(dirname "$0")"

# Check for stow
if ! command -v stow &> /dev/null; then
    echo "GNU Stow is required. Install it with: brew install stow"
    exit 1
fi

# Stow everything into $HOME
stow --target="$HOME" --restow .

echo "Dotfiles linked successfully."

# Install tmux plugins if tpm is present
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    echo "Installing tmux plugins..."
    "$TPM_DIR/bin/install_plugins"
elif command -v git &> /dev/null; then
    echo "Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    "$TPM_DIR/bin/install_plugins"
fi
