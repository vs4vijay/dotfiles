#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin master;

function bootstrap() {
	ln -sv ~/dotfiles/.zshrc ~/.zshrc
	ln -sv ~/dotfiles/.vimrc ~/.vimrc
	ln -sv ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local
	ln -sv ~/dotfiles/git/.gitconfig ~/.gitconfig
	ln -sv ~/dotfiles/.conkyrc ~/.conkyrc

	mkdir -p ~/.config/i3
	ln -sv ~/dotfiles/.config/i3/config ~/.config/i3/config
}


if [ "$1" == "--force" -o "$1" == "-f" ]; then
	bootstrap;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		bootstrap;
	fi;
fi;

unset bootstrap;