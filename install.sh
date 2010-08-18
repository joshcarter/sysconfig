#!/bin/sh

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

cd $HOME
ln -s $SCRIPT_DIR/emacs/dotemacs .emacs
ln -s $SCRIPT_DIR/bash/dotbashrc .bashrc
