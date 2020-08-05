#!/usr/bin/env bash

echo "
[Unit]
Description=XScreenSaver

[Service]
ExecStart=/usr/bin/xscreensaver -nosplash

[Install]
WantedBy=default.target
"

systemctl --user enable xscreensaver