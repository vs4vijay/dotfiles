#!/usr/bin/env bash
set -x

# will be using msys2 for windows


## Generate SSH Keys
function generate_ssh_key() {
  echo "[+] Checking for SSH key, generating one if it does not exist..."
  local pub="$HOME/.ssh/id_ed25519.pub"
  [[ -f $pub ]] || ssh-keygen -t ed25519
}

function install_tools() {
  echo "[+] Installing tools using winget"
  winget install Git.Git
  winget install Python.Python.3.11
  winget install OpenJS.NodeJS.LTS
  winget install CoreyButler.NVMforWindows
  winget install GoLang.Go.1.19
  winget install Rustlang.Rustup
  winget install Microsoft.WSL
  winget install Microsoft.OpenJDK.17
  winget install Notepad++.Notepad++
  winget install Microsoft.VisualStudioCode
  winget install Microsoft.VisualStudioCode.Insiders
  winget install Microsoft.VisualStudio.2022.Enterprise
  winget install Microsoft.VisualStudio.2022.BuildTools
}


function install_msys2() {
  echo "[+] Installing MSYS2 using winget"
  winget install MSYS2.MSYS2
}

function setup_msys2() {
  echo "[+] Setting up MSYS2"

  # setx PATH "%PATH%;C:\msys64\usr\bin;C:\msys64\ucrt64\bin"
  
  # C:/msys64/msys2_shell.cmd -defterm -here -no-start -ucrt64 -use-full-path -shell zsh

  # sed -i '/^\[mingw32\]/{ s|^|[git-for-windows]\nServer = https://wingit.blob.core.windows.net/x86-64\n\n[git-for-windows-mingw32]\nServer = https://wingit.blob.core.windows.net/i686\n\n|; }' /etc/pacman.conf

  # pacman -S mingw-w64-x86_64-{git,git-extra}
  
  pacman -S zsh vim tmux
  pacman -S net-utils
  pacman -S compression
  pacman -S ncdu tree
  pacman -S mingw-w64-ucrt-x86_64-fzf mingw-w64-ucrt-x86_64-lsd mingw-w64-ucrt-x86_64-ag mingw-w64-ucrt-x86_64-jq
  pacman -S mingw-w64-nerd-fonts
  # pacman -S mingw-w64-ucrt-x86_64-yarn
  pacman -S --needed base-devel mingw-w64-ucrt-x86_64-toolchain
}

function setup_zsh() {
  wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O install-ohmyzsh.sh
  bash install-ohmyzsh.sh
  rm -rf install-ohmyzsh.sh
  
  ## Zsh Plugins
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone --depth 1 https://github.com/zsh-users/zsh-completions.git		     ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  git clone --depth 1 https://github.com/romkatv/powerlevel10k.git 			       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}

function setup_tmux() {
  echo "[+] Setting up tmux"
  git clone --depth 1 https://github.com/gpakosz/.tmux.git ~/.tmux
  # ln -sv ~/.tmux/.tmux.conf
}

function main() {
  # install_msys2

  setup_msys2

  setup_zsh
}

main