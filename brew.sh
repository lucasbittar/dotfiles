#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils

# Bash
brew tap homebrew/versions
brew install homebrew/completions/brew-cask-completion

# Install more recent versions of some OS X tools
brew install vim --override-system-vi

# Dev - General
brew install git
brew install imagemagick
brew install node # This installs `npm` too using the recommended installation method
brew install tree

# Dev - Ruby
brew install ruby
brew install ruby-build
brew install rbenv
brew install openssl
brew install postgresql

# Remove outdated versions from the cellar
brew cleanup
