#!/usr/bin/env bash

if [ "$1" = "-h" -o "$1" = "--help" -o -z "$1" ]; then cat <<EOF
Usage:
    `basename "$0"` my-script.sh
    `basename "$0"` my-script.sh "My App"
EOF
exit; fi

APP_NAME=${2:-$(basename "$1" ".sh")}
DIR="$APP_NAME.app/Contents/MacOS"

if [ -a "$APP_NAME.app" ]; then
	echo "$PWD/$APP_NAME.app already exists :("
	exit 1
fi

mkdir -p "$DIR"
cp "$1" "$DIR/$APP_NAME"
chmod +x "$DIR/$APP_NAME"

echo "$PWD/$APP_NAME.app"
