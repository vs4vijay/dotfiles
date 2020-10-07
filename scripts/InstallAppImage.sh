#!/usr/bin/env bash

name="$1"
file="$2"

TARGET="/usr/local/bin"


echo "[+] Moving ${file} to ${TARGET}"
cp "${file}" "${TARGET}/${name}"
chmod 755 "${TARGET}/${name}"

echo "[+] Creating Desktop file"
echo "
[Desktop Entry]
Type=Application
Name=${name}
Comment=${name}
Exec=${name} --class ${name}
Terminal=false
StartupNotify=false
StartupWMClass=${name}
" > "/usr/share/applications/${name}.desktop"
