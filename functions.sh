#!/usr/bin/env bash

echo "Loading functions..."

function generate_ssh_key() {
  ssh-keygen -o -a 100 -t ed25519
}

function ggg_config() {
  git config --local user.name "$1"
  git config --local user.email "$2"
}