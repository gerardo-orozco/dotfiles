#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# First off, install Homebrew and Git
echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2> /dev/null

echo "########################################################################"
echo "Install command-line tools using Homebrew."
echo "########################################################################"

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `brew.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
echo "Updating & upgrading brew..."
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

# Install formulae tat requires install arguments
# @TODO: Find a way to include the arguments in the iterative process below
if brew list -1 | grep -q "^coreutils\$"; then
    echo "+ 'coreutils' already installed"
else
    brew install coreutils
fi
sudo ln -sf /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

##############################################################################
# Formulas
###############################################################################
echo "------------------------------------------------------------------------"
echo "Installing formulas"
echo "------------------------------------------------------------------------"

formulae=$(<$SCRIPT_DIR/Brewfile)
for formula in $formulae; do
    if brew list -1 | grep -q "^${formula}\$"; then
        echo "+ '$formula' already installed"
    else
        echo "+ Installing '$formula'..."
        brew install $formula 1> /dev/null
    fi
done

if brew list -1 | grep -q "^brew-cask\$"; then
    echo "+ 'brew-cask' already installed"
else
    echo "+ Installing '$formula'..."
    brew tap phinze/homebrew-cask 1> /dev/null
    brew install brew-cask 1> /dev/null
fi

###############################################################################
# Casks
###############################################################################
echo "------------------------------------------------------------------------"
echo "Installing Casks"
echo "------------------------------------------------------------------------"
formulae=$(<$SCRIPT_DIR/Caskfile)
for formula in $formulae; do
    if brew cask list -1 | grep -q "^${formula}\$"; then
        echo "+ '$formula' already installed"
    else
        echo "+ Installing '$formula'..."
        brew install --cask $formula 1> /dev/null
    fi
done

# Remove outdated versions from the cellar.
brew cleanup

# Install the Monokai theme for iTerm
open "${HOME}/monokai.terminal/Monokai.itermcolors"
# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
