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
if [ -e ~/.vim ]; then
    rm -rf ~/.vim.bak
    mv ~/.vim ~/.vim.bak
fi
cp -r .vim ~/.vim

# Setup Vundle
mkdir ~/.vim/bundle
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Setup Eclipse
mkdir -p ~/Documents/eclipse-workspaces/main/.metadata/.plugins
cp -r org.eclipse.core.runtime ~/Documents/eclipse-workspaces/main/.metadata/.plugins/

# Setup snap2
if [ ! -e ~/repos/snap2 ]; then
    cd ~/repos
    git clone git@github.com:kevinychen/snap2.git
    cd snap2
    ./gradlew downloadFiles
fi

# Setup fzf (Fuzzy Search in terminal)
brew install fzf
yes | $(brew --prefix)/opt/fzf/install

