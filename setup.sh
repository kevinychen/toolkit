#!/bin/bash

# fail on errors
set -e

# Setup Vundle
mkdir -p ~/.vim/bundle
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Link configuration files
if [ -e ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi
ln .bashrc ~/.bashrc
if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi
ln .vimrc ~/.vimrc
if [ ! -e ~/.vim/comments.vim ]; then
    ln ~/repos/toolkit/.vim/comments.vim ~/.vim/comments.vim
fi

