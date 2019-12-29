#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

"./$(get_os)/main.sh"
./nvm.sh
./npm.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   ZSH Plugins\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   NeoVim Plugins\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall


printf "\n"
