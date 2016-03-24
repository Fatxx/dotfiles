#!/bin/bash
sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install stow
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install stow

stow linters
stow vim
