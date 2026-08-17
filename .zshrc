#!/usr/bin/env zsh

# Use $HOME in zsh

autoload -Uz compinit && compinit
# autoload bashcompinit && bashcompinit


# Only load this when bashrc is compatible
# [[ -f ~/.bashrc ]] && source ~/.bashrc

. "$HOME/.local/bin/env"
source <(fzf --zsh)
# source <(docker completion zsh)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(stern --completion=zsh)


alias gst="git status"
alias python="python3"
alias aichat="uvx --python 3.11 open-webui@latest serve"
alias vcodex="CODEX_HOME=~/.codex-vijay codex"
alias vclaude="CLAUDE_CONFIG_DIR=~/.claude-vijay claude"


export NVM_DIR="$HOME/.nvm"

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

export FZF_DEFAULT_OPTS='--height 40% --popup bottom,40% --layout reverse --border top'

export LLAMA_SERVER_URL="http://localhost:11111"
export LLAMA_CACHE="$HOME/models"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" 

# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel10k/powerlevel10k"


command -v starship 2>&1 > /dev/null && eval "$(starship init zsh)"
command -v awless 2>&1 > /dev/null && source <(awless completion zsh)
command -v kubectl 2>&1 > /dev/null && source <(kubectl completion zsh)
command -v minikube 2>&1 > /dev/null && source <(minikube completion zsh)
command -v poetry 2>&1 > /dev/null && source <(poetry completions zsh)
command -v omp 2>&1 > /dev/null && eval "$(omp completions zsh)"


# plugins=(
#   sudo
#   man
#   macos
#   extract
#   command-not-found

#   git
#   github
  
#   pip
#   python
#   golang
#   aws
#   docker
#   docker-compose
#   kubectl
#   jsontools

#   screen
#   tmux

#   colorize
#   fzf

#   zsh-syntax-highlighting
#   zsh-autosuggestions
#   zsh-completions
# )


## Sourcing for zsh plugins
# source $ZSH/oh-my-zsh.sh
# [[ -f ~/.fzf.zsh  ]] && source ~/.fzf.zsh
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh 
# [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

[[ -f "$HOME/.env.private" ]] && source "$HOME/.env.private"

# # Mac configuration
if [[ "$OSTYPE" != darwin* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" 
fi

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2|*.tbz2) tar xjf "$1"   ;;
      *.tar.gz|*.tgz)    tar xzf "$1"   ;;
      *.tar.xz)          tar xf "$1"    ;;
      *.bz2)             bunzip2 "$1"   ;;
      *.rar)             unrar x "$1"   ;;
      *.gz)              gunzip "$1"    ;;
      *.tar)             tar xf "$1"    ;;
      *.zip)             unzip "$1"     ;;
      *.7z)              7z x "$1"      ;;
      *)                 echo "Error: '$1' cannot be extracted." ;;
    esac
  else
    echo "'$1' is not a valid file."
  fi
}

lms-import-models() {
  local model_dir="${1:-$HOME/models}"
  local count=0
  while IFS= read -r -d '' f; do
    [[ "$(basename "$f")" == mmproj-* ]] && continue
    local rest="${f#*models--}"
    if [[ "$rest" != "$f" ]]; then
      local user="${rest%%--*}"
      local repo="${rest#*--}"
      repo="${repo%%/*}"
      echo "Importing: $f  (user/repo: $user/$repo)"
      lms import -l --user-repo "$user/$repo" "$f"
    else
      echo "WARNING: Cannot determine user/repo, skipping: $f" >&2
    fi
    ((count++))
  done < <(find "$model_dir" -name '*.gguf' -not -path '*/blobs/*' -print0)
  echo "Done. Imported $count model(s)."
}
