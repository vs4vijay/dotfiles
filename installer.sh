#!/usr/bin/env bash


## Update the system dep. and clean-up
sudo apt-get update && sudo apt-get upgrade
sudo apt-get clean && sudo apt-get autoremove --purge && sudo apt-get remove


## Install Essentials
sudo apt-get install build-essential ruby-dev libssl-dev libpcap-dev net-tools screen tmux zsh curl wget git vim


## Generate SSH Keys
function generate_ssh_key() {
  echo "[+] Checking for SSH key, generating one if it does not exist..."
  local pub="$HOME/.ssh/id_ed25519.pub"
  [[ -f $pub ]] || ssh-keygen -t ed25519
}

generate_ssh_key


## Install mosh
sudo apt-get install mosh


## Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install


## Install Oh-my-zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install-ohmyzsh.sh
bash install-ohmyzsh.sh
rm -rf install-ohmyzsh.sh

## Zsh Plugins
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git		     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git 			       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k


## tmux Plugins
git clone --depth 1 https://github.com/gpakosz/.tmux.git ~/.tmux
# ln -sv ~/.tmux/.tmux.conf


## Install Fonts
# Install manually from "fonts" directory

# git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
# cd nerd-fonts

# sudo apt-get install fonts-powerline

# git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts
# bash ~/fonts/install.sh
# rm -rf ~/fonts


## Install Vim Plugin Manager
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


## Install Utilities
sudo apt-get install silversearcher-ag htop ranger tree ncdu mtr jq
# sudo apt-get install youtube-dl


## Install Softwares
sudo apt-get install firefox chromium-browser vlc

# sudo apt-get install timewarrior taskwarrior
# sudo apt-get install wine
sudo snap install standard-notes


## Install IDEs (Sublime, VSCode, Codium)
sudo apt-get install apt-transport-https

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg 
echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 
sudo apt-get update
sudo apt-get install codium 



## Install Programming & Development Tools

# Python3
sudo apt-get install python3 python3-pip


# NodeJS and npm
sudo curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n
sudo chmod 755 /usr/local/bin/n
sudo bash n lts

# Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install --no-install-recommends yarn

# Go
wget -c https://golang.org/dl/go1.17.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

# AWS related tool
# curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | bash

# Docker
sudo apt-get install docker.io
sudo apt-get install docker-compose
sudo usermod -aG docker $USER

# Kubernetes
wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update
sudo apt-get install kubectl
# sudo apt-get install kubeadm kubelet
# sudo curl --output /usr/local/sbin/kubectl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"


# Kubernetes Cluster: Kind
# GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.1 
# sudo snap install microk8s --classic

# Other tools: k9s, lazydocker
curl -sS https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
wget -c https://github.com/derailed/k9s/releases/download/v0.24.15/k9s_Linux_x86_64.tar.gz -O - | sudo tar -xz -C /usr/local/bin


# Virtual Box
# sudo apt-get install virtualbox
# sudo apt-get install virtualbox-ext-pack

# GoLand
# sudo snap install goland --classic


## Misc
sudo pip3 install thefuck

wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb -O lsd.deb
sudo dpkg -i lsd.deb
rm -rf lsd.deb


# sudo apt-get install wallch

# sudo add-apt-repository ppa:unit193/encryption
# sudo apt update
# sudo apt install veracrypt

# sudo apt-get install libgconf2-dev
# sudo apt-get install xclip
# go get github.com/ericchiang/pup

# [ "${SHELL##/*/}" != "zsh" ] && echo "You might need to change default shell to zsh: `chsh -s /bin/zsh`"

## Manual tools
# Dropbox from Software Packages
# Cryptomator
# Obsidian
# getsession
# keepassxc - sudo snap install keepassxc


## Bootstrap my config files
git clone git@github.com:vs4vijay/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap.sh