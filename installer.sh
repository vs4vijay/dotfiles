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

## Installing Softwares
sudo apt-get install firefox firefox-dev-edition chromium vlc

## Installing Editors (Sublime, VSCode)
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text


wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code



# [ "${SHELL##/*/}" != "zsh" ] && echo "You might need to change default shell to zsh: `chsh -s /bin/zsh`"

## Bootstrapping

# git clone git@github.com:vs4vijay/dotfiles.git
# cd dotfiles
# ./bootstrap