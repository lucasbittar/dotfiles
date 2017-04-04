#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # CLI Tools - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "FFmpeg" "ffmpeg"
    brew_install "Git" "git"
    brew_install "ImageMagick" "imagemagick --with-webp"
    brew_install "tmux" "tmux"
    brew_install "tree" "tree"
    brew_install "Core Utils" "coreutils"
    brew_install "More Utils" "moreutils"
    brew_install "Ruby" "ruby"
    brew_install "Ruby Build" "ruby-build"
    brew_install "RB Env" "rbenv"
    brew_install "Open SSL" "openssl"
    brew_install "Postgre SQL" "postgresql"

    # Apps  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    brew_install "Android File Transfer" "android-file-transfer" "caskroom/cask" "cask"
    brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"
    brew_install "Firefox" "firefox" "caskroom/cask" "cask"
    brew_install "Firefox Developer" "firefoxdeveloperedition" "caskroom/versions" "cask"
    brew_install "Firefox Nightly" "firefoxnightly" "caskroom/versions" "cask"
    brew_install "Flash" "flash-npapi" "caskroom/cask" "cask"
    brew_install "Spectacle" "spectacle" "caskroom/cask" "cask"
    brew_install "tmux (pasteboard)" "reattach-to-user-namespace"
    brew_install "uTorrent" "utorrent" "caskroom/cask" "cask"
    brew_install "Unarchiver" "the-unarchiver" "caskroom/cask" "cask"
    brew_install "Vim" "vim --with-override-system-vi"
    brew_install "VLC" "vlc" "caskroom/cask" "cask"
    brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"
    brew_install "Skype" "skype" "caskroom/cask" "cask"
    brew_install "Spotify" "spotify" "caskroom/cask" "cask"
    brew_install "Zoom" "zoom" "caskroom/cask" "cask"
    brew_install "Franz" "franz" "caskroom/cask" "cask"
    brew_install "Adobe Creative Cloud" "adobe-creative-cloud" "caskroom/cask" "cask"
    brew_install "iTerm 2" "iterm2" "caskroom/cask" "cask"
    brew_install "Font Hack" "font-hack" "caskroom/cask" "cask"

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
