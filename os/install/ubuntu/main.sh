#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

    OSarchitecture="$(uname -i)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # Install tools for compiling/building software from source.

    install_package "Build Essential" "build-essential"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # GnuPG archive keys of the Debian archive.

    install_package "GnuPG archive keys" "debian-archive-keyring"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"
    install_package "Wget" "wget"

    # Install Chrome Stable

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $HOME/Downloads/chrome.deb
    sudo apt install $HOME/Downloads/chrome.deb
    print_result "Google Chrome"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install Ulauncher

    wget https://github.com/Ulauncher/Ulauncher/releases/download/5.8.0/ulauncher_5.8.0_all.deb -O $HOME/Downloads/ulauncher.deb
    sudo apt install $HOME/Downloads/ulauncher.deb
    print_result "Ulauncher"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Dropbox" "nautilus-dropbox"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git" "git"
    install_package "Guake" "guake"
    install_package "FD" "fd-find"
    install_package "RG" "ripgrep"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    git clone https://github.com/vinceliuice/vimix-gtk-themes.git $HOME/Downloads/vimix-gtk-themes
    ./$HOME/Downloads/vimix-gtk-themes/install.sh

    git clone https://github.com/vinceliuice/vimix-icon-theme.git $HOME/Downloads/vimix-icon-theme
    ./$HOME/Downloads/vimix-icon-theme/install.sh

    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "ScreenFetch" "screenfetch"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    update
    install_package "Spotify" "spotify-client"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    add_ppa "transmissionbt/ppa"
    update
    install_package "Transmission" "transmission transmission-qt"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Tree" "tree"
    install_package "VLC" "vlc"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    wget https://zoom.us/client/latest/zoom_amd64.deb -O $HOME/Downloads/zoom.deb
    sudo dpkg -i $HOME/Downloads/zoom.deb

    print_result "Zoom"

    # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "tmux" "tmux"
    install_package "nvim" "neovim"
    install_package "xclip" "xclip"
    install_package "zsh" "zsh"

}

main() {

    print_in_purple "   Apps and CLI tools\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    update
    # upgrade
    printf "\n"
    install_apps
    printf "\n"
    autoremove

}

main
