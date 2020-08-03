#!/usr/bin/env bash


echo "[+] Installing XScreenSaver"
sudo apt-get install xscreensaver

sudo apt-get remove gnome-screensaver

echo "[+] Add Startup Entry: xscreensaver -nosplash"