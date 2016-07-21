function goback() {
  popd > /dev/null
}
pushd ${HOME} > /dev/null
trap goback ERR EXIT
curl -#L https://github.com/gerardo-orozco/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,install.sh,LICENSE-MIT.txt} 1> /dev/null
[[ "$?" != "0" ]] && exit 1
for f_name in 'osx_defaults.sh brew.sh sublime.sh rvm.sh'; do
  ./kickstart/$f_name
  [[ "$?" == "0" ]] && exit 1
done
source ${HOME}/.bash_profile
