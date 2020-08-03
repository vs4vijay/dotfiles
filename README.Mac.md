


## Brew installation

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

`brew bundle`


### Commands

- `brew outdated`
- `brew pin <formula>`


- `brew uninstall --force <formula>`
- `brew cleanup`

### Development Notes

```

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

```
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