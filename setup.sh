#!/bin/bash

# fail on errors
set -e

# Link configuration files
if [ -e ~/.bashrc ]; then
    rm -f ~/.bashrc.bak
    mv ~/.bashrc ~/.bashrc.bak
fi
ln .bashrc ~/.bashrc
source ~/.bashrc
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
if [ -e ~/.vrapperrc ]; then
    rm -f ~/.vrapperrc.bak
    mv ~/.vrapperrc ~/.vrapperrc.bak
fi
ln .vrapperrc ~/.vrapperrc
if [ -e ~/.vim ]; then
    rm -rf ~/.vim.bak
    mv ~/.vim ~/.vim.bak
fi
cp -r .vim ~/.vim

# Setup Vundle
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

if [ "$1" == "simple" ]; then
    echo "Simple setup enabled; aborting early."
    exit 0
fi

# Install Vim with +clipboard
if ! vim --version | grep "+clipboard" > /dev/null; then
    brew install vim
    # refresh Bash cache
    hash -r
fi

# Setup Eclipse
if [ ! -e ~/Documents/eclipse-workspaces/main ]; then
    mkdir -p ~/Documents/eclipse-workspaces/main/.metadata/.plugins
    cp -r org.eclipse.core.runtime ~/Documents/eclipse-workspaces/main/.metadata/.plugins/
fi

# Setup snap2
if [ ! -e ~/repos/snap2 ]; then
    cd ~/repos
    git clone git@github.com:kevinychen/snap2.git
    cd snap2
    ./gradlew downloadFiles
fi

# Setup ctags
if ! command -v ctags > /dev/null; then
    brew install ctags
fi

# Setup fzf (Fuzzy Search in terminal)
if ! command -v fzf > /dev/null; then
    brew install fzf
    yes | $(brew --prefix)/opt/fzf/install
fi

# Install ag, the silver searcher
if ! command -v ag > /dev/null; then
    brew install the_silver_searcher
fi

# Set desktop background
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$HOME/repos/toolkit/oranges.jpg\""

