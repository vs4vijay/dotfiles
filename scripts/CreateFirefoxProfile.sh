#!/usr/bin/env bash

# open -n -a Firefox.app --args -no-remote -P New

name="$1"

# Path=/path

echo "
[Desktop Entry]
Type=Application
Name=${name}Firefox
Comment=Firefox Profile (${name})
Exec=firefox -no-remote -P ${name} --class ${name}
Icon=firefox
Terminal=false
StartupNotify=false
StartupWMClass=${name}
" > "/usr/share/applications/${name}Firefox.desktop"

# desktop-file-install <name>.desktop
# icons at /usr/share/pixmaps/
# download from: https://www.iconfinder.com/search/?q=firefox
# https://design.firefox.com/photon/visuals/product-identity-assets.html
