# First install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
# Download the dotfiles!
cd; curl -#L https://github.com/gerardo-orozco/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,install.sh,LICENSE-MIT.txt}
source ~/.bash_profile
# Install formulae and RVM (http://rvm.io/rvm/install)
./.osx && ./brew.sh
#&& \curl -sSL https://get.rvm.io | bash -s stable --ruby
