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

