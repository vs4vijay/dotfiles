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
# command -v awless 2>&1 > /dev/null && source <(awless completion zsh)
# command -v kubectl 2>&1 > /dev/null && source <(kubectl completion zsh)
# command -v minikube 2>&1 > /dev/null && source <(minikube completion zsh)
# command -v poetry 2>&1 > /dev/null && source <(poetry completions zsh)
# command -v starship 2>&1 > /dev/null && eval "$(starship init zsh)"
[[ -f ~/.fzf.zsh  ]] && source ~/.fzf.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh 
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


# Mac configuration
if [[ "$OSTYPE" != darwin* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi