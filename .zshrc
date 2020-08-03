export ZSH="/Users/viz/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

plugins=(
  sudo
  man
  osx

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
)


source $ZSH/oh-my-zsh.sh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


autoload bashcompinit
bashcompinit


POWERLEVEL9K_MODE='nerdfont-complete'


export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

export EDITOR=vim
export PAGER=less

export HOMEBREW_NO_AUTO_UPDATE=1
export HISTCONTROL=ignoreboth
export GO111MODULE=on

eval "$(pyenv init -)"
eval $(thefuck --alias)
# eval "$(register-python-argcomplete pmbootstrap)"


source /usr/local/etc/bash_completion.d
source <(kubectl completion zsh)
source <(awless completion zsh)
# source <(minikube completion zsh)
# source <(python3 -m poetry completions zsh)

change_tor_node() {
  echo -e 'AUTHENTICATE ""\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
  tip
}


alias erc="$EDITOR $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias ls="lsd"
alias todo="$EDITOR ~/todo.txt"
alias cip="curl https://wtfismyip.com/json"
alias tip="torify curl https://wtfismyip.com/json"
alias qw="ssh pixel.as python3 /home/ubuntu/tools/pwndb/pwndb.py --target"
alias zz_bettercap="sudo bettercap -iface en0 -caplet http-ui -eval 'wifi.recon on'; open http://0.0.0.0:9900/"


# Python Related Alias
alias create_venv="python3 -m venv .venv"
alias activate_venv="source .venv/bin/activate"

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$PATH:/Users/viz/tools:/Users/viz/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export KUBECONFIG="/Users/viz/.kube/config:/Users/viz/.kube/eks_config:/Users/viz/.kube/kubesail_config"

function zz_extract_handshake() {
	captured_pcap="$1"
	filter_bssid="$2"
	target_pcap="$3"
	[[ "${target_pcap}" == "" ]] && target_pcap="${filter_bssid}" || target_pcap="$3"
	
	echo "[+] Extracting Handshake: ${filter_bssid} > ${target_pcap}.cap"
	tshark -r "${captured_pcap}" -R "(wlan.fc.type_subtype == 0x08 || wlan.fc.type_subtype == 0x05 || eapol) && wlan.addr == ${filter_bssid}" -2 -F pcap -w "${target_pcap}.cap" 
}


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# neofetch
. "/Users/viz/.acme.sh/acme.sh.env"
export PATH="/usr/local/opt/curl/bin:$PATH"