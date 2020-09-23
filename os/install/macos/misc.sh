#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # CLI Tools - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "BAT" "bat"
    brew_install "FD" "fd"
    brew_install "Fzf" "fzf"
    brew_install "Git" "git"
    brew_install "Htop" "htop"
    brew_install "More Utils" "moreutils"
    brew_install "NeoFetch" "neofetch"
    brew_install "NeoVim" "neovim"
    brew_install "Python3" "python3"
    brew_install "Rg" "ripgrep"
    brew_install "Stow" "stow"
    brew_install "Wget" "wget"
    brew_install "Z" "z"
    brew_install "ZSH" "zsh"
    brew_install "exa" "exa"
    brew_install "tmux" "tmux"

    # Apps  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "Adobe Creative Cloud" "adobe-creative-cloud" "caskroom/cask" "cask"
    brew_install "AppCleaner" "appcleaner" "caskroom/cask" "cask"
    brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"
    brew_install "Docker" "docker" "caskroom/cask" "cask"
    brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"
    brew_install "Fira Code" "font-fira-code" "caskroom/cask" "cask"
    brew_install "Firefox Nightly" "firefoxnightly" "caskroom/versions" "cask"
    brew_install "Firefox" "firefox" "caskroom/cask" "cask"
    brew_install "Font Hack" "font-hack" "caskroom/fonts" "cask"
    brew_install "Insomnia" "insomnia" "caskroom/cask" "cask"
    brew_install "Karabiner Elements" "karabiner-elements" "caskroom/cask" "cask"
    brew_install "Skype" "skype" "caskroom/cask" "cask"
    brew_install "Slack" "slack" "caskroom/cask" "cask"
    brew_install "Spectacle" "spectacle" "caskroom/cask" "cask"
    brew_install "Spotify" "spotify" "caskroom/cask" "cask"
    brew_install "Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
    brew_install "VLC" "vlc" "caskroom/cask" "cask"
    brew_install "Zoom" "zoomus" "caskroom/cask" "cask"
    brew_install "iTerm 2" "iterm2" "caskroom/cask" "cask"
    brew_install "uTorrent" "utorrent" "caskroom/cask" "cask"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # `Safari Technology Preview` requires macOS 10.11.4 or la
    # https://github.com/alrra/dotfiles/issues

    if is_supported_version "$(get_os_version)" "10.11.4"; then
        brew_install "Safari Technology Preview" "safari-technology-preview" "caskroom/versions" "cask"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Apps and CLI tools\n\n"

    install_apps
    printf "\n"
    brew_cleanup

}

main
