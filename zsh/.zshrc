#!/bin/bash

# Path to your oh-my-zsh installation.
export HISTFILE=$HOME/.zsh_history
export TERM="xterm-256color"

export PATH=$HOME/Library/Android/sdk/cmdline-tools:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/scripts:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Initialize zsh completion system
autoload -Uz compinit
compinit

HISTSIZE=10000
SAVEHIST=10000

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

# Initialize Starship prompt
eval "$(starship init zsh)"

# --- Zsh Plugins (Manually Sourced) ---
# Quick tutorial
# mkdir -p ~/.zsh/plugins
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
# git clone https://github.com/rupa/z.git ~/.zsh/plugins/z

# Initialize z (rupa/z)
source ~/.zsh/plugins/z/z.sh

# zsh-autosuggestions
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf key-bindings and completion (sourced directly from Homebrew installation)
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# zsh-syntax-highlighting
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
