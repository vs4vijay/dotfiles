# Setup Mac


## Brew installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


brew bundle


# other commands
brew outdated
brew pin name


brew uninstall --force name
brew cleanup`

```

## Apps

```bash
brew install mas

brew install btop
brew install wget tree
brew install gh


brew install ripgrep the_silver_searcher fd fzf
brew install ranger bat eza
brew install ncdu duf
brew install jq yq
# brew install midnight-commander nnn
# brew install imagemagick ffmpeg


# Productivity
brew install --cask cmux iterm2
brew install --cask stats
brew install maccy
# brew install --cask caffeine

# Coding
brew install --cask visual-studio-code
brew install --cask orbstack
brew install colima

# Browsers
brew install --cask firefox firefox@developer-edition 
brew install --cask chromium zen

brew install --cask keka little-snitch


brew install xo/xo/usql

brew install font-hack-nerd-font

brew install neovim
brew install --cask neovide

# Security
brew install nmap

# AI LLM
brew install rtk
brew install hf
brew install llama.cpp
brew install --cask llamabarn
brew install --cask lm-studio
brew install --cask cursor
brew install --cask cmux
brew install superset

```

---

## Shortcuts

- Cmd+Ctrl+Q - Log off
- Cmd+Q - Quit app
- Fn - Emoji browser

---

## Tools

```bash
curl -sS https://starship.rs/install.sh | sh

```


### Development Notes

```bash

https://sourabhbajaj.com/mac-setup/SublimeText/Preferences.html



brew 'neovim'

cask 'java'


cask 'alfred'

cask 'dash'

lazydocker
lazygit

pv 

offlineimap





Try:
little-snitch
popclip
clipmenu
duplicity
cheatsheet - https://www.cheatsheetapp.com/CheatSheet/

https://github.com/bluedaniel/Kakapo-app

https://canarymail.io/

mas  JPEGmini Lite 
mas pixelmator
mas pixelmator

```


git config --global user.name "vs4vijay"
git config --global user.email "vs4vijay@gmail.com"

git config --global credential.helper osxkeychain


## zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# chsh -s $(which zsh)

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


https://github.com/sorin-ionescu/prezto


## Later

eval "$(ssh-agent -s)"

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa



## Vim

https://github.com/square/maximum-awesome


# brew install mas



# Caches

~/Library/Caches

~/Library/Caches/pip

---

## In-progress work

```bash
brew install diff-so-fancy

sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
```

---