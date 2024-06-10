#!/usr/bin/env bash
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  sudo
  man
  macos
  extract
  command-not-found

  git
  github
  
  pip
  python
  golang
  aws
  docker
  docker-compose
  kubectl
  jsontools

  screen
  tmux

  adb
  colorize
  fzf

  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)


autoload -U compinit && compinit
autoload bashcompinit && bashcompinit


## Sourcing for zsh
source ~/.bashrc
source $ZSH/oh-my-zsh.sh
[[ -f ~/.fzf.zsh  ]] && source ~/.fzf.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh 
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


## Functions
function mkcd() { 
  mkdir -vp "$1" && cd "$1"; 
} 

function change_tor_node() {
  echo -e 'AUTHENTICATE ""\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
  tip
}

function zzxtract_handshake() {
	local captured_pcap="$1"
	local filter_bssid="$2"
	local target_pcap="$3"
	[[ "${target_pcap}" == "" ]] && target_pcap="${filter_bssid}" || target_pcap="$3"
	
	echo "[+] Extracting Handshake: ${filter_bssid} > ${target_pcap}.cap"
	tshark -r "${captured_pcap}" -R "(wlan.fc.type_subtype == 0x08 || wlan.fc.type_subtype == 0x05 || eapol) && wlan.addr == ${filter_bssid}" -2 -F pcap -w "${target_pcap}.cap" 
}

function zzkali() {
  if [[ -z $(vmrun.exe list | grep -i kali) ]]; then
    echo "Starting Kali"

    vmrun.exe -T player start "M:/VM/kali-linux-2021.3-vmware-amd64.vmwarevm/Kali-Linux-2021.3-vmware-amd64.vmx"
  fi

  echo "Connecting to Kali"
  until ssh -o ConnectTimeout=2 viz@kali
    do sleep 1
  done
}


# Mac configuration
if [[ "$OSTYPE" != darwin* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Windows WSL configuration
if [[ -n "$(uname -r | grep -i microsoft)" ]]; then
  alias code=code.exe
  # alias docker=docker.exe
  # alias docker-compose=docker-compose.exe
  alias npp="/mnt/c/Program\ Files/Notepad++/notepad++.exe"
  alias gomain="cd /mnt/c/Main"
  alias gowork="cd /mnt/c/Main/Reporting"
fi


# neofetch
# . "/Users/viz/.acme.sh/acme.sh.env"
if [ -e /home/viz/.nix-profile/etc/profile.d/nix.sh ]; then . /home/viz/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
