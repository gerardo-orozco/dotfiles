set -x

# ---------------
# Install the app
# ---------------
echo "Installing Sublime Text 3..."

test -f "$(readlink $(which subl))"
[[ "$?" == "0" ]] && {
  echo -e "\talready installed. Skipping."; exit
}

SCRIPT_DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))
SUBLIME_DMG="${HOME}/Downloads/SublimeText.dmg"
SUBLIME_DIR="${HOME}/Library/Application Support/Sublime Text 3"
SUBLIME_VOLUME="/Volumes/Sublime Text"
PKG_CTRL_DIR="${HOME}/Downloads/Package Control.sublime-package"

# Download the DMG file
curl https://download.sublimetext.com/Sublime%20Text%20Build%203176.dmg -o $SUBLIME_DMG

# Mount the DMG
hdiutil mount $SUBLIME_DMG 2> /dev/null
# copy the app to the Applications directory
cp -R "${SUBLIME_VOLUME}/Sublime Text.app" /Applications
# unmount the DMG
hiutil unmount "${SUBLIME_VOLUME}" 2> /dev/null
# and remove the DMG file, we don't need it anymore
rm $SUBLIME_DMG

# --------------------------------
# Install the settings and plugins
# --------------------------------
curl "https://sublime.wbond.net/Package%20Control.sublime-package" -o "$PKG_CTRL_DIR" 1> /dev/null
mv -f "$PKG_CTRL_DIR" "${SUBLIME_DIR}/Installed Packages/Package Control.sublime-package"

# With "Package Control" installed, Sublime will automatically install the
# packages in "Package Control.sublime-settings" when it runs for the
# first time, so it just needs to be copied to the appropriate location.
cp -Rf $SCRIPT_DIR/../sublime/ "$SUBLIME_DIR/Packages/User/"
