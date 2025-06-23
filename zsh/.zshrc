#!/bin/bash

export HISTFILE=$HOME/.zsh_history
export TERM="xterm-256color"

export PATH=$HOME/Library/Android/sdk/cmdline-tools:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/scripts:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Autoload any functions in your fpath (like compinit for autocompletion)
# Initialize tab completion
autoload -Uz compinit
compinit

# Enable history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

plugins=(z git-prompt vi-mode tmux fzf)

setopt sharehistory       # Share history between all sessions

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.homebrew/bin:$PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# FZF Setup

# Set fzf installation directory path
FD_OPTIONS="--hidden --exclude .git --exclude node_modules"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND="fd $FD_OPTIONS"

export FZF_BASE=/usr/local/opt/fzf
# export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --multi --inline-info"
export FZF_DEFAULT_OPTS="--layout=default --height=100% --info=inline"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -500'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--sort --exact"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export VISUAL=nvim
export EDITOR="$VISUAL"

ZSH_DISABLE_COMPFIX=true

# Source files
source ~/.aliases
source ~/.extras

# VI mode
bindkey -v
export KEYTIMEOUT=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
