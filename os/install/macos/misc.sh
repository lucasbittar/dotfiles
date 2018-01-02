#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # CLI Tools - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "Ag" "the_silver_searcher"
    brew_install "Core Utils" "coreutils"
    brew_install "FFmpeg" "ffmpeg"
    brew_install "Git" "git"
    brew_install "Htop" "htop"
    brew_install "ImageMagick" "imagemagick --with-webp"
    brew_install "More Utils" "moreutils"
    brew_install "NeoFetch" "neofetch"
    brew_install "Open SSL" "openssl"
    brew_install "Postgre SQL" "postgresql"
    brew_install "RB Env" "rbenv"
    brew_install "Ruby Build" "ruby-build"
    brew_install "Ruby" "ruby"
    brew_install "Shopify Theme" "themekit" "shopify/shopify"
    brew_install "WP CLI" "wp-cli" "josegonzalez/homebrew-php"
    brew_install "Wget" "wget"
    brew_install "tmux (pasteboard)" "reattach-to-user-namespace"
    brew_install "tmux" "tmux"
    brew_install "tree" "tree"

    # Apps  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "Adobe Creative Cloud" "adobe-creative-cloud" "caskroom/cask" "cask"
    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"
    brew_install "AppCleaner" "appcleaner" "caskroom/cask" "cask"
    brew_install "Cerebro" "cerebro" "caskroom/cask" "cask"
    brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"
    brew_install "Day-O" "day-o" "caskroom/cask" "cask"
    brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"
    brew_install "Firefox Nightly" "firefoxnightly" "caskroom/versions" "cask"
    brew_install "Firefox" "firefox" "caskroom/cask" "cask"
    brew_install "Font Hack" "font-hack" "caskroom/fonts" "cask"
    brew_install "Franz" "franz" "caskroom/cask" "cask"
    brew_install "Karabiner Elements" "karabiner-elements" "caskroom/cask" "cask"
    brew_install "Sequel Pro" "sequel-pro" "caskroom/cask" "cask"
    brew_install "Skype" "skype" "caskroom/cask" "cask"
    brew_install "Spectacle" "spectacle" "caskroom/cask" "cask"
    brew_install "Spotify" "spotify" "caskroom/cask" "cask"
    brew_install "TeamViewer" "teamviewer" "caskroom/cask" "cask"
    brew_install "The Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
    brew_install "Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
    brew_install "VLC" "vlc" "caskroom/cask" "cask"
    brew_install "Vagrant" "vagrant" "caskroom/cask" "cask"
    brew_install "Vim" "vim --with-override-system-vi"
    brew_install "VirtualBox" "virtualbox" "caskroom/cask" "cask"
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
