#!/bin/bash

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export HISTFILE=$HOME/.zsh_history
export TERM="xterm-256color"

export PATH=$HOME/Library/Android/sdk/cmdline-tools:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

HISTSIZE=10000
SAVEHIST=10000

# My own custom theme.
# I like: ys, apple, avit, fino
ZSH_THEME="spaceship"

# plugins=(sublime z vi-mode zsh-syntax-highlighting zsh-autosuggestions git-prompt tmux)
plugins=(z vi-mode git-prompt tmux fzf)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.homebrew/bin:$PATH

# FZF Setup
# Set fzf installation directory path
FD_OPTIONS="--hidden --exclude .git --exclude node_modules"
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND="fd $FD_OPTIONS"

export FZF_BASE=/usr/local/opt/fzf
export FZF_DEFAULT_OPTS="--reverse --no-mouse --height 50% -1 --multi --inline-info"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -500'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--sort --exact"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export KEYTIMEOUT=1
export VISUAL=nvim
export EDITOR="$VISUAL"

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

# z
source $ZSH/plugins/z/z.sh

# Source files
source ~/.aliases
source ~/.extras


# VI mode
export KEYTIMEOUT=1

# Checks if session home exists, if so attach it, if not create one
# tmux=$(tmux ls)

# if [[ $tmux == *"Home"* ]]; then
#   tmux attach-session -t Home
#   # clear
# else
#   tmux new -s Home
#   # clear
# fi

### Added by Zplugin's installer
if [[ ! -d $HOME/.zplugin/bin ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing Zplugin…%f"
    command mkdir -p $HOME/.zplugin
    command git clone https://github.com/zdharma/zplugin $HOME/.zplugin/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-completions

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  node
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
