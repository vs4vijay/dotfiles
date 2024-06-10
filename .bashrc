

# Sourcing
command -v starship &> /dev/null && eval "$(starship init bash)" || echo "[+] Starship prompt couldn't be loaded. Please make sure 'starship' is installed."
command -v thefuck 2>&1 > /dev/null && eval $(thefuck --alias)
command -v awless 2>&1 > /dev/null && source <(awless completion zsh)
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

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
export PATH="/usr/local/sbin:$HOME/.local/bin:/home/viz/.local/bin:$PATH"
export PATH="$HOME/tools:$PATH"
# export PATH="$HOME/.yarn/bin:$PATH"
# export PATH="/usr/local/opt/curl/bin:/usr/local/opt/openssl/bin:$PATH"

# Brew configuration
export HOMEBREW_NO_AUTO_UPDATE=1

# History configuration
export HISTCONTROL=ignoreboth
# export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTIGNORE="pwd:cd:ls:ls -all:"
export HISTTIMEFORMAT="| %d/%m/%y %T | "
unset HISTFILESIZE                # infinite History
unset HISTSIZE                    # infinite History

# export GOROOT="/usr/local/go"
# export GOPATH="$HOME/go"
# export GO111MODULE=on
# export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/beon-dev_config.yml:$HOME/.kube/kubesail_config:$HOME/.kube/aks_non-prod.yml"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


# NodeJS ecosystem related
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"


# export JAVA_HOME="/usr/lib/jvm/java-14-openjdk-amd64"
export PATH="$JAVA_HOME/bin:$PATH"
export SDKMAN_DIR="$HOME/.sdkman"

# fzf configuration options
export FZF_DEFAULT_OPTS="--color bw --reverse --border"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# WSL and X-Server (vcxsrv)
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0.0
# export DISPLAY=$(ip route | awk '/^default/{print $3; exit}'):0.0
export LIBGL_ALWAYS_INDIRECT=1



## Aliases
alias erc="$EDITOR ~/.zshrc"
alias src="source ~/.zshrc"
alias ls="lsd"
alias ln="ln -v"
alias tx="tmuxinator"

# vim
alias vi="vim"
# alias vim="nvim"

# Git aliases
alias gst="git status"
alias ggl="git pull origin HEAD"
alias ggp="git push origin @"

alias www="python -m http.server"
alias grep="grep --color=auto"

alias todo="$EDITOR ~/notes/todo.md"
alias notes="$EDITOR ~/notes"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias cip="curl https://wtfismyip.com/json"
alias tip="torify curl https://wtfismyip.com/json"
alias qw="ssh kali python3 qw --target"
alias zzbettercap="sudo bettercap -iface en0 -caplet http-ui -eval 'wifi.recon on'; open http://0.0.0.0:9900/"

# Python related aliases
# alias python=python3
alias create_venv="python3 -m venv .venv"
alias activate_venv="source .venv/bin/activate"

# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# xrdb -merge .Xresources
