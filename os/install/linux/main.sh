#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {


    install_package "Compton" "compton"
    install_package "Dropbox" "dropbox"
    install_package "Feh" "feh"
    install_package "Firefox Nightly" "firefox-trunk"
    install_package "Franz" "franz-bin"
    install_package "GIMP" "gimp"
    install_package "Git" "git"
    install_package "Google Chrome" "google-chrome"
    install_package "ImageMagick" "imagemagick"
    install_package "Network Manager Applet" "network-manager-applet"
    install_package "Network Manager" "networkmanager"
    install_package "Nemo File Manager" "nemo"
    install_package "Numix Icons" "numix-icon-theme-git"
    install_package "Numix Theme" "numix-gtk-theme"
    install_package "Pavu Control" "pavucontrol"
    install_package "Polybar" "polybar"
    install_package "Pulse Audio Alsa" "pulseaudio-alsa"
    install_package "Pulse Audio" "pulseaudio"
    install_package "Rofi" "rofi"
    install_package "OpenSSH" "openssh"
    install_package "Rsync" "rsync"
    install_package "ScreenFetch" "screenfetch"
    install_package "Scrot" "scrot"
    install_package "Skype" "skype"
    install_package "Spotify" "spotify"
    install_package "Transmission" "transmission-gtk-git"
    install_package "Tree" "tree"
    install_package "VLC" "vlc"
    install_package "Wget" "wget"
    install_package "Zoom" "zoom"
    install_package "cURL" "curl"
    install_package "i3 Blocks" "i3blocks-git"
    install_package "tmux" "tmux"
    install_package "vim" "vim"
    install_package "xclip" "xclip"
    install_package "zsh-completions" "zsh-completions"
    install_package "zsh-syntax-highlighting" "zsh-syntax-highlighting"

}

main() {

    print_in_purple "   Apps and CLI tools\n\n"

    update
    printf "\n"
    install_apps
    printf "\n"

}

main
