#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

    install_package "Firefox Nightly" "firefox-trunk"
    install_package "Flash" "flashplugin-installer"
    install_package "GIMP" "gimp"
    install_package "Git" "git"
    install_package "Gnome Screensaver" "gnome-screensaver"
    install_package "ImageMagick" "imagemagick"
    install_package "Hack Font" "fonts-hack-ttf"
    install_package "ShellCheck" "shellcheck"
    install_package "Transmission" "transmission"
    install_package "VLC" "vlc"
    install_package "ZSH" "zsh"
    install_package "tmux" "tmux"
    install_package "vim" "vim"
    install_package "xclip" "xclip"

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
