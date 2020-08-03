#!/usr/bin/env bash


## Update the system dep. and clean-up
sudo apt-get update && sudo apt-get upgrade
sudo apt-get clean && sudo apt-get autoremove --purge && sudo apt-get remove


## Install Essentials
sudo apt-get install build-essential ruby-dev libssl-dev libpcap-dev net-tools screen tmux zsh curl wget git vim


## Install mosh
sudo apt-get install mosh


## Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash ~/.fzf/install


## Install Oh-my-zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install-fzf.sh
bash install-fzf.sh


## Zsh Plugins
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git 	 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git		 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git 			 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k


## tmux Plugins
git clone --depth 1 https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~


## Install Fonts
# sudo apt-get install fonts-powerline

# git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
# cd nerd-fonts

# git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts
# bash ~/fonts/install.sh
# rm -rf ~/fonts

## Install Vim Plugin Manager
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

## Install Utilities
sudo apt-get install silversearcher-ag htop ranger

sudo pip3 install thefuck

wget https://github.com/Peltoche/lsd/releases/download/0.17.0/lsd_0.17.0_amd64.deb -O lsd.deb
sudo dpkg -i lsd.deb
rm -rf lsd.deb

## Install Programming Tools
sudo apt-get install python3 python3-pip


## Install Softwares
sudo apt-get install firefox chromium-browser vlc

# sudo apt-get install timewarrior
# wine


sudo snap install standard-notes

## Install Editors (Sublime, VSCode)
sudo apt-get install apt-transport-https

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text


wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get update
sudo apt-get install code


## Install Development Tools
# curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | bash


# [ "${SHELL##/*/}" != "zsh" ] && echo "You might need to change default shell to zsh: `chsh -s /bin/zsh`"



## Bootstrapping
function get_ssh_key() {
  pub="$HOME/.ssh/id_ed25519.pub"
  echo "[+] Checking for SSH key, generating one if it does not exist..."
  [[ -f $pub ]] || ssh-keygen -t ed25519
}

get_ssh_key

git clone git@github.com:vs4vijay/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap