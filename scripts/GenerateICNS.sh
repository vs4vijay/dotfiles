#!/usr/bin/env bash

PNG_FILE="$1"
NAME=${2:-$(basename "$PNG_FILE" ".png")}
ICONSET="${NAME}.iconset"

mkdir -p ${ICONSET}

sips -z 16 16     ${PNG_FILE} --out ${ICONSET}/icon_16x16.png
sips -z 32 32     ${PNG_FILE} --out ${ICONSET}/icon_16x16@2x.png
sips -z 32 32     ${PNG_FILE} --out ${ICONSET}/icon_32x32.png
sips -z 64 64     ${PNG_FILE} --out ${ICONSET}/icon_32x32@2x.png
sips -z 128 128   ${PNG_FILE} --out ${ICONSET}/icon_128x128.png
sips -z 256 256   ${PNG_FILE} --out ${ICONSET}/icon_128x128@2x.png
sips -z 256 256   ${PNG_FILE} --out ${ICONSET}/icon_256x256.png
sips -z 512 512   ${PNG_FILE} --out ${ICONSET}/icon_256x256@2x.png
sips -z 512 512   ${PNG_FILE} --out ${ICONSET}/icon_512x512.png

iconutil -c icns ${ICONSET}

rm -r ${ICONSET}

echo "$PWD/${NAME}.icns"
