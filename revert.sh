#!/bin/bash

# fail on errors
set -e

if [ -e ~/.bashrc.bak ]; then
    rm -f ~/.bashrc
    mv ~/.bashrc.bak ~/.bashrc
fi
if [ -e ~/.vimrc.bak ]; then
    rm -f ~/.vimrc
    mv ~/.vimrc.bak ~/.vimrc
fi
if [ -e ~/.gitconfig.bak ]; then
    rm -f ~/.gitconfig
    mv ~/.gitconfig.bak ~/.gitconfig
fi
if [ -e ~/.gitignore.bak ]; then
    rm -f ~/.gitignore
    mv ~/.gitignore.bak ~/.gitignore
fi
if [ -e ~/.vrapperrc.bak ]; then
    rm -f ~/.vrapperrc
    mv ~/.vrapperrc.bak ~/.vrapperrc
fi
if [ -e ~/.vim.bak ]; then
    rm -rf ~/.vim
    mv ~/.vim.bak ~/.vim
fi

