#!/bin/env bash
# msys2からの実行を想定。
# :PlugInstallするためにgitにPATHが通った状態にしておくこと。
# (例えばC:\msys64\usr\bin)

set -xe

d=$(cd $(dirname $0) && pwd)

cd $USERPROFILE

if [ -d vimfiles ]; then
    echo 'vimfiles directory already exists.'
else
    mkdir vimfiles
fi

cat << _EOT_ > _vimrc
let \$MYNAME="hiket"
let \$MYBELONG="work"
let \$DROPBOX="~/Dropbox"
let \$PROJECT="~/Projects"
se rtp+=\$PROJECT/dotfiles/vim
so \$PROJECT/dotfiles/vimrc
_EOT_

cat << _EOT_ > _gvimrc
so \$PROJECT/dotfiles/gvimrc
_EOT_

curl -fLo vimfiles/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
