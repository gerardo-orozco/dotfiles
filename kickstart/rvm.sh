# First try to load from a user install
[[ -s "$HOME/.rvm/scripts/rvm" ]] && {
  echo "Local RVM found."; exit
}

# Then try to load from a root install
[[ -s "/usr/local/rvm/scripts/rvm" ]] && {
  echo "RVM root install found"; exit
}

echo "No RVM found. Installing RVM..."
\curl -sSL https://get.rvm.io | bash -s stable --ruby 2> /dev/null
