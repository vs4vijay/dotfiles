# dotfiles

## Installation via Installer

- Install Terminator: `sudo apt-get install terminator wget`
- Open Terminator and Run following commands:
```shell
wget https://raw.githubusercontent.com/vs4vijay/dotfiles/master/installer.sh -O - | bash
```

## Installation via Git
- Install Terminator: `sudo apt-get install terminator git`
- Open Terminator and Run following commands:
```shell
git clone git@github.com:vs4vijay/dotfiles.git
cd dotfiles
bash bootstrap.sh
```

## Another Way to Manage dotfiles

```shell
git init --bare ~/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

---

## Pre-requisites
- `$TERM` must be `xterm-256color`
- `$SHELL` must be `zsh`

---

## Tools used

- Tools:
  - zsh
  - lsd
  - fzf
  - thefuck
  - tmux
- Zsh:
  - Plugin: Oh-my-zsh
  - Theme: 
    - Powerlevel10k: https://github.com/romkatv/powerlevel10k
- Vim:
  - Theme: https://github.com/vim-airline/vim-airline
  - Plugin Manager: Vundle
- Tmux:
  - .tmux - https://github.com/gpakosz/.tmux
- Fonts: 
  - NerdFont: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono
- Other Font:
  - https://github.com/powerline/fonts.git
  - https://github.com/ryanoasis/nerd-fonts.git
  - https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
  - https://github.com/tonsky/FiraCode
  - https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack
  - https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono/Regular
  - https://github.com/JetBrains/JetBrainsMono
  - https://github.com/adobe-fonts/source-code-pro
- Other Vim Themes:
  - https://github.com/joshdick/onedark.vim
  - 

---

## Misc Tasks

- Generate SSH Keys:
```shell
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "viz@soni"
```

- Use patched fonts on terminal:
```shell
sudo apt-get install fonts-powerline

OR

git clone --depth 1 https://github.com/powerline/fonts.git ~/fonts
bash ~/fonts/install.sh
rm -rf ~/fonts
```

- Change current shell to zsh
```shell
chsh -s $(which zsh)
```

---

## Misc Softwares and Tools

- Yakuake Terminal

---

### In-progress Work

```

https://github.com/sorin-ionescu/prezto


PyENV


set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


# Source a local zshrc if it exists
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"


ln -sv “~/.dotfiles/git/.gitconfig” ~
ln -v


if [[ "$OSTYPE" != darwin* ]]; then
  echo "Mac"
fi


test -e "${HOME}/file" && source "${HOME}/file"
[[ -f $pub ]] || ssh-keygen -t ed25519


[ "${SHELL##/*/}" != "zsh" ] && echo 'You might need to change default shell to zsh: `chsh -s /bin/zsh`'


# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups:erasedups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
#         The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:clear'

# Export hostory to a different file
export HISTFILE="${HOME}/.history/${CURRENT_SHELL}.history.txt"


alias change_tor_ip="printf 'AUTHENTICATE "password"\r\nSIGNAL NEWNYM\r\n' | nc 127.0.0.1 9051"
alias change_tor_ip="sudo killall -HUP tor"


bold=$(tput bold)
norm=$(tput sgr0)


Icons:
https://avatars3.githubusercontent.com/u/11850518?s=200&v=4
https://avatars3.githubusercontent.com/u/65011256?s=200&v=4

```