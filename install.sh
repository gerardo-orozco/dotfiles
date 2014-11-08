# First install Homebrew and Git
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2> /dev/null
brew install git 2> /dev/null

echo -n "Download the dotfiles..."
cd; curl -#L https://github.com/gerardo-orozco/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,install.sh,LICENSE-MIT.txt}
echo "[DONE]"

echo -n "Installing RVM"
\curl -sSL https://get.rvm.io | bash -s stable --ruby 2> /dev/null
echo "[DONE]"

source ~/.bash_profile
./.osx && ./brew.sh
