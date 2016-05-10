# Path to your oh-my-zsh installation.
export ZSH=/Users/lucasbittar/Projects/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="suvash"

plugins=(z)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.homebrew/bin:$PATH

source $ZSH/oh-my-zsh.sh

# z
source $ZSH/plugins/z/z.sh

# Load default dotfiles
source ~/.bash_profile
