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

brew install btop fastfetch
brew install wget tree
brew install gh


brew install ripgrep the_silver_searcher fd fzf
brew install ranger yazi television broot bat 
brew install zoxide eza 
brew install ncdu duf
brew install jq yq
# brew install midnight-commander nnn
brew install sevenzip
brew install ffmpeg-full imagemagick-full 
brew install poppler resvg font-symbols-only-nerd-font
brew install croc


# Productivity
brew install --cask cmux iterm2
brew install zsh-autosuggestions
brew install --cask stats
brew install maccy
# brew install --cask caffeine
brew install mole
brew install clop
brew install --cask libreoffice
brew install --cask TheBoredTeam/boring-notch/boring-notch
brew install --cask fluidvoice
brew install --cask Sloth

# Coding
brew install --cask visual-studio-code
brew install --cask orbstack
brew install colima

# Browsers
brew install --cask firefox firefox@developer-edition 
brew install --cask ungoogled-chromium chromium zen

brew install --cask keka


brew install xo/xo/usql

brew install font-hack-nerd-font

brew install neovim
brew install --cask neovide

# Security
brew install nmap
# brew install --cask little-snitch
brew install --cask lulu

# AI LLM
brew install hf
brew install rtk
brew install llama.cpp
brew install --cask llama-app
brew install --cask lm-studio
brew install --cask osaurus
brew install --cask cmux
# brew install --cask cursor
brew install superset
brew install --cask conductor
brew install --cask draw-things
brew install --cask claude-devtools
# brew tap ddalcu/mlx-serve https://github.com/ddalcu/mlx-serve
# brew install --cask mlx-core

# Android
brew install android-platform-tools
brew install jadx apktool dex2jar

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

---

## Menu bar

```bash
defaults -currentHost read -globalDomain NSStatusItemSpacing
defaults -currentHost read -globalDomain NSStatusItemSelectionPadding

# Note: These values are not set by default. This means you will get an error that the keys and values do not exist if you have not previously set them.

# Write the defaults by providing an integer value:
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 12
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 8
killall SystemUIServer
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