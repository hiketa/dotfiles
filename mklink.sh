#!/usr/bin/env bash

d=$(cd $(dirname $0) && pwd)

cd $HOME

if [ -d .vim ]; then
    echo '.vim directory already exists.'
else
    ln -sv $d/vim .vim
fi

ln -sfv $d/vimrc .vimrc
curl -fLo .vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

test -f .screenrc && mv .screenrc .screenrc.orig
test -f .bashrc && mv .bashrc .bashrc.orig
test -f .bash_profile && mv .bash_profile .bash_profile.orig

ln -sfv $d/screenrc .screenrc
ln -sfv $d/bashrc .bashrc
ln -sfv $d/bash_profile .bash_profile
