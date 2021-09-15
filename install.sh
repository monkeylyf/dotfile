#!/bin/bash

set -e

INSTALL_FILENAME=$0
# Relative dir to dotfile repo.
DOT_FILE_RELATIVE_DIR=$(dirname ${INSTALL_FILENAME})
CURRENT_DIR=`pwd`


for i in "$@"; do
    case $i in
        cygwin)
            DEV_ENV="cygwin"
            ;;
        mac|macintosh)
            DEV_ENV="macintosh"
            ;;
        ubuntu)
            DEV_ENV="ubuntu"
            ;;
        debian)
            DEV_ENV="debian"
            ;;
        *)
            ;;
    esac
done

create_soft_link () {
    relative_filename=$1
    dir="DOT_FILE_RELATIVE_DIR $relative_filename"
    filename=$(basename $relative_filename)
    if [ "$filename" == "sshconfig" ]; then
        # Special case for ssh config
        symlink_filename="${HOME}/.ssh/config"
    else
        symlink_filename="${HOME}/.${filename}"
        # Removes existing destination files, if any, before creating a new one.
    fi
    echo "ln -sf $CURRENT_DIR/$relative_filename $symlink_filename"
    ln -sf $CURRENT_DIR/$relative_filename $symlink_filename
}

link_dotfiles () {
    ENV_DOTIFLE_DIR=${DOT_FILE_RELATIVE_DIR}/${DEV_ENV}
    for relative_filename in $ENV_DOTIFLE_DIR/*; do
        if [[ ! -x $relative_filename ]]; then
            create_soft_link $relative_filename
        fi
    done
}

install_dotfiles () {
    if [ -z "$DEV_ENV" ]; then
        echo "Unknown environment..."
        echo "usage: install {cygwin|macintosh|ubuntu|debian}"
        exit 1
    else
        link_dotfiles
        exit 0
    fi
}

install_config () {
    if [ "$DEV_ENV" == "macintosh" ]; then
        config_dir=${CURRENT_DIR}/${DOT_FILE_RELATIVE_DIR}/${DEV_ENV}/config
        symlink_dir="${HOME}/.config"
        echo "ln -s ${config_dir} $symlink_dir"
        ln -s ${config_dir} $symlink_dir
    fi
}

#install_dotfiles
install_config
