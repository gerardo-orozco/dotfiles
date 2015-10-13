# First download the dotfiles
cd; curl -#L https://github.com/gerardo-orozco/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,install.sh,LICENSE-MIT.txt} 1> /dev/null

# Install Homebrew and Git (required for some package installs)
if [[ $(uname) == "Darwin" ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2> /dev/null
    brew install git 2> /dev/null


    if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
      # First try to load from a user install
      echo "Local RVM found."

    elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
      # Then try to load from a root install
      echo "RVM root install found"

    else
        # No RVM found. Install it
        echo "Installing RVM"
        \curl -sSL https://get.rvm.io | bash -s stable --ruby 2> /dev/null
    fi

    ./.osx && ./brew.sh
fi

source ~/.bash_profile
