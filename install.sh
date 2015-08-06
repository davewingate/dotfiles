#!/bin/bash

DOTFILES_HOME=$(cd "$(dirname "$0")" && pwd)

_install_bash_source () {
	ln -sf $DOTFILES_HOME/bash/$1.bash ~/.$1.bash
	if ! grep -q "source ~/.$1.bash" ~/.bash_profile; then
		echo "" >> ~/.bash_profile
		echo "# $2" >> ~/.bash_profile
		echo "source ~/.$1.bash" >> ~/.bash_profile
	fi
} 

_install_bash_source "colors" "alias some terminal colors"
_install_bash_source "gitconfig" "config for git autocomplete and prompt"
_install_bash_source "prompt" "tune bash prompt"
_install_bash_source "aws-ec2" "alias some aws commands"
_install_bash_source "terminal" "alias some convenient termial commands"
