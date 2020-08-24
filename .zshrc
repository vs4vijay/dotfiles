# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  sudo
  man
  osx
  extract

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


source $ZSH/oh-my-zsh.sh


autoload -U compinit && compinit
autoload bashcompinit && bashcompinit


## Sourcing
[[ -f ~/.fzf.zsh  ]] && source ~/.fzf.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
command -v thefuck 2>&1 > /dev/null && eval $(thefuck --alias)
command -v awless 2>&1 > /dev/null && source <(awless completion zsh)
# source <(minikube completion zsh)
# source <(python3 -m poetry completions zsh)

# eval "$(pyenv init -)"
# eval "$(register-python-argcomplete pmbootstrap)"


## Environment Variables
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

export EDITOR=vim
export PAGER=less
export PATH="/usr/local/sbin:~/bin:~/.local/bin:$PATH"
export PATH="$HOME/tools:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:/usr/local/opt/openssl/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export HISTCONTROL=ignoreboth

export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export GO111MODULE=on
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
export KUBECONFIG="~/.kube/config:~/.kube/eks_config:~/.kube/kubesail_config"

export JAVA_HOME="/usr/lib/jvm/java-14-openjdk-amd64"
export PATH="$JAVA_HOME/bin:$PATH"


## Aliases
alias erc="$EDITOR ~/.zshrc"
alias src="source ~/.zshrc"
alias ls="lsd"
alias ln="ln -v"

# vim
alias vi="vim"
# alias vim="nvim"

alias grep="grep --color=auto"

alias todo="$EDITOR ~/todo.txt"
alias cip="curl https://wtfismyip.com/json"
alias tip="torify curl https://wtfismyip.com/json"
alias qw="ssh azpixel python3 qw --target"
alias zz_bettercap="sudo bettercap -iface en0 -caplet http-ui -eval 'wifi.recon on'; open http://0.0.0.0:9900/"

# fzf options
export FZF_DEFAULT_OPTS="--color bw --reverse --border"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Python Related Alias
alias create_venv="python3 -m venv .venv"
alias activate_venv="source .venv/bin/activate"


## Functions
function change_tor_node() {
  echo -e 'AUTHENTICATE ""\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
  tip
}

function zz_extract_handshake() {
	captured_pcap="$1"
	filter_bssid="$2"
	target_pcap="$3"
	[[ "${target_pcap}" == "" ]] && target_pcap="${filter_bssid}" || target_pcap="$3"
	
	echo "[+] Extracting Handshake: ${filter_bssid} > ${target_pcap}.cap"
	tshark -r "${captured_pcap}" -R "(wlan.fc.type_subtype == 0x08 || wlan.fc.type_subtype == 0x05 || eapol) && wlan.addr == ${filter_bssid}" -2 -F pcap -w "${target_pcap}.cap" 
}


# Mac related configuration
if [[ "$OSTYPE" != darwin* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# xrdb -merge .Xresources


# neofetch
# . "/Users/viz/.acme.sh/acme.sh.env"
