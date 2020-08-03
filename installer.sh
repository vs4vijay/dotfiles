#!/usr/bin/env bash


## Update the system dep. and clean-up
sudo apt-get update && sudo apt-get upgrade
sudo apt-get clean && sudo apt-get autoremove --purge && sudo apt-get remove


## Install Essentials
sudo apt-get install build-essential ruby-dev libssl-dev libpcap-dev net-tools screen zsh curl wget git vim


## Install mosh
sudo apt-get install mosh


## Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


## Install Oh-my-zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install-fzf.sh
bash install-fzf.sh


## Install Utilities
sudo apt-get install silversearcher-ag htop ranger


## Install Programming Tools
sudo apt-get install python python-pip python3 python3-pip


# [ "${SHELL##/*/}" != "zsh" ] && echo "You might need to change default shell to zsh: `chsh -s /bin/zsh`"

## Bootstrapping

# git clone git@github.com:vs4vijay/dotfiles.git
# cd dotfiles
# ./bootstrap