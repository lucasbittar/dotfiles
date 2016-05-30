# Path to your oh-my-zsh installation.
export ZSH=~/Projects/dotfiles/oh-my-zsh

# My own custom theme.
ZSH_THEME="lucasbittar"

plugins=(sublime z)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.homebrew/bin:$PATH

source $ZSH/oh-my-zsh.sh

# z
source $ZSH/plugins/z/z.sh

# Load default dotfiles
source ~/.bash_profile
