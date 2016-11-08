#!/bin/bash

set -e

copy_file_to_home_dir () {
    if [ "$#" -ne 1 ]; then
        echo "copy_file_to_home_dir takes one argument"
        return 1
    elif [ ! -f $1 ]; then
        echo "$1 does not exist"
        return 1
    else
        echo "Copying $(basename $1) to home directory"
        cp $1 ~/
        return 0
    fi
}


set_bash () {
    echo "Setting bash..."
    copy_file_to_home_dir './.bashrc'
    copy_file_to_home_dir './.bash_profile'
    copy_file_to_home_dir './.vimrc'
}


install_homebrew () {
    if test ! $(which brew); then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "homebrew already installed. Skip"
    fi
    brew update
}


brew_install () {
    if [ "$#" -ne 1 ]; then
        echo "brew_install takes one argument"
        return 1
    else
        echo "Installing $1"
        eval "brew install $1"
        return 0
    fi
}

brew_cask_install () {
    if [ "$#" -ne 1 ]; then
        echo "brew_cask_install takes one argument"
        return 1
    else
        echo "Installing $1"
        eval "brew cask install $1"
        return 0
    fi
}


install_software () {
    brew_install vim
    brew_install go
    brew_cask_install google-chrome
    brew_cask_install java
}


install () {
    set_bash
    install_homebrew
    install_software
}

install
