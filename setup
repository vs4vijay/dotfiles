#!/usr/bin/env bash

function get_ssh_key() {
  pub="$HOME/.ssh/id_ed25519.pub"
  echo "[+] Checking for SSH key, generating one if it does not exist..."
  [[ -f $pub ]] || ssh-keygen -t ed25519
}