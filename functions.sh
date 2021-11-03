#!/usr/bin/env bash

function generate_ssh_key() {
  ssh-keygen -o -a 100 -t ed25519
}