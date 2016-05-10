#!/bin/bash

# brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# Install native apps

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# daily
brew cask install spectacle
brew cask install dropbox
brew cask install skype
brew cask install adobe-creative-cloud

# dev
brew cask install iterm2
brew cask install sublime-text3
brew cask install font-hack

# browsers
brew cask install google-chrome-beta
brew cask install firefoxnightly

# less often
brew cask install vlc
brew cask install utorrent
