#!/bin/bash

set -e

INSTALL_FILENAME=$0
DIRNAME=$(dirname ${INSTALL_FILENAME})
CURRENT_DIR=`pwd`


for i in "$@"; do
    case $i in
        cygwin)
            DOTFILE_ENV="cygwin"
            ;;
        mac|macintosh)
            DOTFILE_ENV="macintosh"
            ;;
        ubuntu)
            DOTFILE_ENV="ubuntu"
            ;;
        *)
            ;;
    esac
done

create_soft_link () {
    relative_filename=$1
    dir="dirname $relative_filename"
    filename=$(basename $relative_filename)
    symlink_filename="${HOME}/.${filename}"
    echo "ln -s $CURRENT_DIR/$relative_filename $symlink_filename"
    # Removes existing destination files, if any, before creating a new one.
    ln -sf $CURRENT_DIR/$relative_filename $symlink_filename
}

link_dotfiles () {
    ENV_DOTIFLE_DIR=${DIRNAME}/${DOTFILE_ENV}
    for relative_filename in $ENV_DOTIFLE_DIR/*; do
        create_soft_link $relative_filename
    done

}

install_dotfiles () {
    if [ -z "$DOTFILE_ENV" ]; then
        echo "Unknown environment..."
        echo "usage: install {cygwin|macintosh|ubuntu}"
        exit 1
    else
        link_dotfiles
        exit 0
    fi
}

install_dotfiles
