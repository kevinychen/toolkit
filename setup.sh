#!/bin/bash

# fail on errors
set -e

# Link configuration files
if [ -e ~/.bashrc ]; then
    rm -f ~/.bashrc.bak
    mv ~/.bashrc ~/.bashrc.bak
fi
ln .bashrc ~/.bashrc
if [ -e ~/.vimrc ]; then
    rm -f ~/.vimrc.bak
    mv ~/.vimrc ~/.vimrc.bak
fi
ln .vimrc ~/.vimrc
if [ -e ~/.gitconfig ]; then
    rm -f ~/.gitconfig.bak
    mv ~/.gitconfig ~/.gitconfig.bak
fi
ln .gitconfig ~/.gitconfig
if [ -e ~/.gitignore ]; then
    rm -f ~/.gitignore.bak
    mv ~/.gitignore ~/.gitignore.bak
fi
ln .gitignore ~/.gitignore
if [ -e ~/.ideavimrc ]; then
    rm -f ~/.ideavimrc.bak
    mv ~/.ideavimrc ~/.ideavimrc.bak
fi
ln .ideavimrc ~/.ideavimrc
if [ -e ~/.vim ]; then
    rm -rf ~/.vim.bak
    mv ~/.vim ~/.vim.bak
fi
cp -r .vim ~/.vim

# Setup Vundle
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

if [ "$1" == "osx" ]; then
    # Install useful things
    brew install rectangle
    brew install the_silver_searcher
    brew install ukelele
    brew install --cask jdk-mission-control
    brew install --cask jumpcut
    brew install --cask paintbrush

    # Setup fzf (Fuzzy Search in terminal)
    brew install fzf
    yes | $(brew --prefix)/opt/fzf/install

    # Install vscode
    if [ -e "~/Library/Application Support/Code/User" ]; then
        brew install --cask visual-studio-code
        ln vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
        ln vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
    fi

    # Set desktop background
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$HOME/repos/toolkit/oranges.jpg\""

    # Holding down a vowel key doesn't bring up a Unicode vowel popup menu
    defaults write -g ApplePressAndHoldEnabled -bool false

elif [ "$1" == "windows" ]; then
    choco install jdk8
    choco install python3
    choco install conemu
    ln ConEmu.xml ~/AppData/Roaming/ConEmu.xml
fi

source ~/.bashrc

