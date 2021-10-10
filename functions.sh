#!/usr/bin/env bash

function generate_ssh_key() {
  echo "[+] Checking for SSH key, generating one if it does not exist..."
  local pub="$HOME/.ssh/id_ed25519.pub"
  [[ -f $pub ]] || ssh-keygen -t ed25519
}