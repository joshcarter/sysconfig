#!/bin/sh

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

cd $HOME
ln -s $SCRIPT_DIR/ctags/dotctags .ctags
ln -s $SCRIPT_DIR/emacs/dotemacs .emacs
ln -s $SCRIPT_DIR/bash/dotbashrc .bashrc
ln -s $SCRIPT_DIR/bash/dotbash_profile .bash_profile
ln -s $SCRIPT_DIR/vim/dotvimrc .vimrc
ln -s $SCRIPT_DIR/vim/dotvim .vim
ln -s $SCRIPT_DIR/zsh/dotzprofile .zprofile
ln -s $SCRIPT_DIR/zsh/dotzshrc .zshrc
ln -s $SCRIPT_DIR/starship/starship.toml .starship.toml
