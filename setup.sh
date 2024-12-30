#!/bin/bash

set -e

function _toolkit_link_file(s) {
    if [[ -e ~/$s ]]; then
        if [ "$(stat -f %i $s)" = "$(stat -f %i ~/$s)" ]; then
            return
        else
            mv ~/$s ~/$s.bak
        fi
    fi
    ln $s ~/$s
}
function _toolkit_copy_dir(s) {
    if [[ ! -e ~/$s.bak ]]; then
        mv ~/$s ~/$s.bak
    fi
    cp -r $s ~/$s
}
_toolkit_link_file(".bashrc")
_toolkit_link_file(".gitconfig")
_toolkit_link_file(".gitignore")
_toolkit_link_file(".ideavimrc")
_toolkit_link_file(".tmux.conf")
_toolkit_link_file(".vimrc")
_toolkit_copy_dir(".vim")

function _toolkit_setup_vundle() {
    mkdir ~/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}
_toolkit_setup_vundle()

function _toolkit_install_macos() {
    # Install useful things
    brew install binutils
    brew install exiftool
    brew install fswatch
    brew install hashcat
    brew install imagemagick
    brew install node
    brew install rectangle
    brew install the_silver_searcher
    brew install tmux
    brew install tree
    brew install ukelele
    brew install --cask audacity
    brew install --cask docker
    brew install --cask ghidra
    brew install --cask jdk-mission-control
    brew install --cask jumpcut
    brew install --cask paintbrush
    brew install --cask sage
    brew install --cask wireshark

    # Setup fzf (Fuzzy Search in terminal)
    brew install fzf
    yes | $(brew --prefix)/opt/fzf/install

    # Needed for pwntools
    brew install cmake
    brew install pkg-config

    # Install vscode
    brew install --cask visual-studio-code
    ln vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

    # Set desktop background
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$HOME/repos/toolkit/oranges.jpg\""

    # Holding down a vowel key doesn't bring up a Unicode vowel popup menu
    defaults write -g ApplePressAndHoldEnabled -bool false
}

if [ $1 == "macos" ]; then
    _toolkit_install_macos()
fi

source ~/.bashrc

