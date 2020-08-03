#!/usr/bin/env bash

# sudo xcodebuild -license

# xcode-select --install


if hash brew; then
    echo "[+] brew Already Installed"
else
    echo "[-] brew Not Installed, Installing brew" >&2

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# brew bundle

echo "[+] Updating formulas"
brew update 

echo "[+] Installing packages: essentials"
brew install git curl wget watch tree
brew install bash bash-completion
brew install zsh zsh-completions
brew install vim
brew install mas

echo "[+] Installing packages: libraries"
brew install openssl coreutils

echo "[+] Installing packages: tools"
brew install the_silver_searcher fzf ncdu htop
brew install mosh ranger
brew install youtube-dl
brew install thefuck tldr

echo "[+] Installing packages: security tools"
brew install tor torsocks nmap john-jumbo aircrack-ng

echo "[+] Installing packages: coding tools"
brew install vimr neovim
brew install docker lazydocker docker-compose docker-completion
brew install kubectl derailed/k9s/k9s
brew install k3d kind 


# echo "[+] Installing packages: optional"
# brew install ntfs-3g

echo "[+] Installing packages: casks"
brew cask install qlstephen qlcolorcode qlmarkdown quicklook-json qlvideo qlimagesize betterzip
brew cask install iterm2
brew cask install vlc
brew cask install android-platform-tools
brew cask install android-file-transfer
brew cask install textmate
brew cask install firefox
brew cask install google-chrome
brew cask install dropbox
brew cask install ccleaner
brew cask install openemu
brew cask install standard-notes
brew cask install zoomus
brew cask install postman
brew cask install virtualbox
brew cask install transmission
brew cask install visual-studio-code
brew cask install sublime-text 
# EAP: webstorm

brew cask install dbeaver-community

# echo "[+] Installing from Mac App Store"
mas install 490461369 # Bandwidth+
# mas lucky evernote
# mas lucky wunderlist

# echo "[+] Installing packages: misc"
brew install cointop

# Proxyman


echo "[+] Cleaning up"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*
rm -f -r ~/Library/Caches/Homebrew/*

exit 0
