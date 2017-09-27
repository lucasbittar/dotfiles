#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_termite() {

    git clone --recursive https://github.com/thestinger/termite.git
    git clone https://github.com/thestinger/vte-ng.git
    sudo apt-get install -y \
        g++ \
        libgtk-3-dev \
        gtk-doc-tools \
        gnutls-bin \
        valac \
        intltool \
        libpcre2-dev \
        libglib3.0-cil-dev \
        libgnutls28-dev \
        libgirepository1.0-dev \
        libxml2-utils \
        gperf

    echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
    cd vte-ng && ./autogen.sh && make && sudo make install
    cd ../termite && make && sudo make install
    sudo ldconfig
    sudo mkdir -p /lib/terminfo/x; sudo ln -s \
    /usr/local/share/terminfo/x/xterm-termite \
    /lib/terminfo/x/xterm-termite

}

install_apps() {

    # Install tools for compiling/building software from source.

    install_package "Build Essential" "build-essential"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # GnuPG archive keys of the Debian archive.

    install_package "GnuPG archive keys" "debian-archive-keyring"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons.

    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "google-chrome-unstable"; then

        add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
            || print_error "Chrome Canary (add key)"

        add_to_source_list "[arch=amd64] https://dl.google.com/linux/deb/ stable main" "google-chrome.list" \
            || print_error "Chrome Canary (add to package resource list)"

        update &> /dev/null \
            || print_error "Chrome Canary (resync package index files)"

    fi

    install_package "Chrome Canary" "google-chrome-unstable"
    install_package "cURL" "curl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "firefox-trunk"; then

        add_ppa "ubuntu-mozilla-daily/ppa" \
            || print_error "Firefox Nightly (add PPA)"

        update &> /dev/null \
            || print_error "Firefox Nightly (resync package index files)"

    fi

    install_package "Compton" "compton"
    install_package "Dropbox" "dropbox"
    install_package "Feh" "feh"
    install_package "Firefox Nightly" "firefox-trunk"
    install_package "Franz" "franz-bin"
    install_package "GIMP" "gimp"
    install_package "Git" "git"
    install_package "Hack Font" "fonts-hack-ttf"
    install_package "ImageMagick" "imagemagick"
    install_package "Numix Icons" "numix-icon-theme"
    install_package "Numix Theme" "numix-gtk-theme"
    install_package "OpenSSH" "openssh"
    install_package "ScreenFetch" "screenfetch"
    install_package "ShellCheck" "shellcheck"
    install_package "Skype" "skype"
    install_package "Spotify" "spotify"
    install_package "Transmission" "transmission"
    install_package "Tree" "tree"
    install_package "VLC" "vlc"
    install_package "Wget" "wget"
    install_package "ZSH" "zsh"
    install_package "Zoom" "zoom"
    install_package "cURL" "curl"
    install_package "i3 Blocks" "i3blocks"
    install_package "i3 WM" "i3"
    install_package "tmux" "tmux"
    install_package "vim" "vim"
    install_package "xclip" "xclip"
    install_package "zsh-completions" "zsh-completions"
    install_package "zsh-syntax-highlighting" "zsh-syntax-highlighting"

    install_termite

}

main() {

    print_in_purple "   Apps and CLI tools\n\n"

    update
    upgrade
    printf "\n"
    install_apps
    printf "\n"
    autoremove

}

main
