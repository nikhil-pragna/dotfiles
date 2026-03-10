# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **Neovim** - LazyVim-based config with LSP, formatting, and custom keymaps
- **Tmux** - Tokyo Night theme, vim-aware pane navigation, session management
- **Zsh** - Zinit plugin manager, Powerlevel10k prompt, fzf + zoxide integration
- **Aerospace** - Tiling window manager for macOS
- **Kitty** - Terminal emulator config
- **Alacritty** - Terminal emulator config
- **Yazi** - Terminal file manager
- **btop** - System monitor

## Setup

### Prerequisites

- macOS
- [Homebrew](https://brew.sh)
- GNU Stow (`brew install stow`)

### Install

```bash
git clone https://github.com/nikhil/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Manual Steps

- Tmux plugins are installed automatically via tpm. Press `prefix + I` inside tmux to install if needed.
- Zsh plugins are managed by Zinit and install automatically on first shell launch.
- Secrets (API keys, tokens) go in `~/.config/zsh/config.d/` which is gitignored.

## Structure

```
.dotfiles/
├── .config/
│   ├── aerospace/     # Tiling WM config
│   ├── alacritty/     # Terminal config
│   ├── btop/          # System monitor
│   ├── kitty/         # Terminal config
│   ├── nvim/          # Neovim config (LazyVim)
│   ├── tealdeer/      # tldr client config
│   ├── tmux/          # Tmux config
│   ├── yazi/          # File manager config
│   └── zsh/           # Zsh config fragments
├── scripts/           # Utility scripts
├── .zshrc             # Main shell config
└── install.sh         # Stow-based installer
```
