#!/usr/bin/env bash

echo "########################################################################"
echo "Install command-line tools using Homebrew."
echo "########################################################################"

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
echo "Updating & upgrading brew..."
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

if brew list -1 | grep -q "^coreutils\$"; then
    echo "+ '$formula_name' already installed"
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
formulae=$(<Brewfile)
for formula in $formulae; do
    formula_name=$(echo $formula | cut -d' ' -f1)
    if [ -z "${formula_name}" ]; then
        if brew list -1 | grep -q "^${formula_name}\$"; then
            echo "+ '$formula_name' already installed"
        else
            brew install $formula
        fi
    fi
done

brew tap phinze/homebrew-cask
brew install brew-cask

###############################################################################
# Casks
###############################################################################
echo "------------------------------------------------------------------------"
echo "Installing Casks"
echo "------------------------------------------------------------------------"
formulae=$(<Caskfile)
for formula in $formulae; do
    formula_name=$(echo $formula | cut -d' ' -f1)
    if [ -z "${formula_name}" ]; then
        if brew cask list -1 | grep -q "^${formula_name}\$"; then
            echo "+ '$formula_name' already installed"
        else
            brew cask install $formula
        fi
    fi
done

# Remove outdated versions from the cellar.
brew cleanup


# Install the Monokai theme for iTerm
open "${HOME}/monokai.terminal/Monokai.itermcolors"
# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
