
# Keep VPS / Hermes local environment available.
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Env variables
export EDITOR="nvim"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Speed up zsh?
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Add in zsh plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
  command -v p10k >/dev/null 2>&1 && p10k reload >/dev/null 2>&1 || true
fi
# VPS fallback prompt: if Powerlevel10k doesn't initialize cleanly in this headless shell,
# still avoid the default `factory%` prompt.
autoload -Uz colors && colors
_git_prompt_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
  local dirty=''
  git diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty='*'
  print -r -- " %F{magenta} ${branch}${dirty}%f"
}
setopt prompt_subst
precmd() {
  local exit_code=$?
  local prompt_status=''
  [[ $exit_code -ne 0 ]] && prompt_status="%F{red}✘ ${exit_code}%f "
  PROMPT="${prompt_status}%F{cyan}%n%f@%F{blue}%m%f %F{green}%~%f$(_git_prompt_branch)
%F{yellow}❯%f "
}


# Keybindings
bindkey -v
bindkey '^Y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias n="nvim ."
alias g="nvim +Git"
alias vim='nvim'
alias nvims='nvim -c SessionRestore'
alias ls='ls --color'
alias la="ls -latrh"

alias fman="compgen -c | fzf | xargs man"
alias ftldr="compgen -c | fzf | xargs tldr --list | tldr "

#Directories shortcuts
alias cdl="cd ~/work/learning/"
alias cdw="cd ~/work/"
alias cdb="cd $HOME/work/billinn"
alias cdbash="cd $HOME/work/bash/codebase"

#Dark mode toggle
if [[ "$OSTYPE" == darwin* ]]; then
  alias dark="osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to true'"
  alias light="osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to false'"
fi

#Paths
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/emulator:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"
alias air="$HOME/go/bin/air"

# Flutter path setting
export PATH="$PATH:$HOME/development/flutter/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Turso
export PATH="$HOME/.turso:$PATH"

# Shell integrations
if command -v fzf >/dev/null 2>&1; then
  if [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh || -r /usr/share/doc/fzf/examples/completion.zsh ]]; then
    [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null
    [[ -r /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh 2>/dev/null
  elif fzf --zsh >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
  fi
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Load separated config files
if [[ -d "$HOME/.config/zsh/config.d" ]]; then
  for conf in "$HOME/.config/zsh/config.d/"*.zsh(N); do
    source "${conf}"
  done
  unset conf
fi

#yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

if command -v aerospace >/dev/null 2>&1; then
  function ff() {
      aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
  }
fi

[[ -t 0 ]] && ulimit -n 10240 2>/dev/null || true

alias claude="$HOME/.local/bin/claude"
alias cc="claude --dangerously-skip-permissions"
alias ccc="cc --continue"

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/nikhil/.dart-cli-completion/zsh-config.zsh ]] && . /Users/nikhil/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# sqz — context intelligence layer (auto-installed)
sqz_run() {
    "$@" 2>&1 | SQZ_CMD="$*" sqz compress
}
preexec() {
    export __SQZ_CMD="$1"
}
# sqz — end of auto-installed block

