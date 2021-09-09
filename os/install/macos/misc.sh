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
    brew_install "Yarn" "yarn"
    brew_install "YouTube Downloader" "youtube-dl"

    # Apps  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "Adobe Creative Cloud" "adobe-creative-cloud"
    brew_install "Alfred" "alfred"
    brew_install "AppCleaner" "appcleaner"
    brew_install "Chrome" "google-chrome"
    brew_install "Docker" "docker"
    brew_install "Dropbox" "dropbox"
    brew_install "Express VPN" "expressvpn"
    brew_install "Fira Code" "font-fira-code"
    brew_install "Firefox Nightly" "firefoxnightly"
    brew_install "Firefox" "firefox"
    brew_install "Font Fira" "font-fira-code"
    brew_install "Insomnia" "insomnia"
    brew_install "Karabiner Elements" "karabiner-elements"
    brew_install "Slack" "slack"
    brew_install "Spectacle" "spectacle"
    brew_install "Spotify" "spotify"
    brew_install "TeamViewer" "teamviewer"
    brew_install "Unarchiver" "the-unarchiver"
    brew_install "VLC" "vlc"
    brew_install "WebTorrent" "webtorrent"
    brew_install "Zoom" "zoomus"
    brew_install "iTerm 2" "iterm2"

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
