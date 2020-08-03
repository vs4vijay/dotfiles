# dotfiles

## Installation

- Install Terminator: `sudo apt-get install terminator`
- Open Terminator and Run following commands:
```shell
git clone git@github.com:vs4vijay/dotfiles.git
cd dotfiles
./bootstrap
```


## Another Way to Manage

```shell
git init --bare ~/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

---

### In-progress Work

```

https://github.com/sorin-ionescu/prezto

ln -sv “~/.dotfiles/git/.gitconfig” ~

set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching



# Source a local zshrc if it exists
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"

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

```