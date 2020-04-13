# vim: ft=sh

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export LANG=ja_JP.UTF-8

export HISTSIZE=50000
export HISTTIMEFORMAT='[%Y-%m-%d %H:%M:%S] '
export HISTIGNORE=ls

export PATH=$HOME/bin:$HOME/.local/bin:$PATH

export DROPBOX=$HOME/Dropbox
export PROJECT=$HOME/Projects

export SVN_EDITOR=vim
# これを指定しておくと、sudoeditコマンドが上手くユーザーが
# 見ているvimを起動してくれる。セキュリティ的に微妙なところはある。
export SUDO_EDITOR=vim

export PGUSER=postgres
export PGPORT=5432
export PGHOST=127.0.0.1
export PGDATA=/var/lib/pgsql/9.6/data

# /usr/local/go以外に配置した場合はGOROOTの設定が必要。
export GOROOT=$HOME/.local/go
export GOPATH=$PROJECT/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# npmのグローバルモジュールの位置を変更。
if [ ! -d ~/.npm-global ];then
    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
fi
export PATH="$HOME/.npm-global/bin:$PATH"

# postgres toolkit
# http://pgsqldeepdive.blogspot.jp/2015/05/postgres-toolkit.html
#export PATH=$PATH:/opt/uptime/postgres-toolkit-0.2.2/bin

# http://vim.wikia.com/wiki/256_colors_in_vim
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
fi

# http://mokokko.hatenablog.com/entry/2013/03/14/133850
agent="$HOME/.ssh-auth-sock"
if [ -S "$agent" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
    ln -vsnf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
fi

#git config --global user.name ""
#git config --global user.email ""
git config --global core.editor vim
git config --global core.autoCRLF false
git config --global alias.st "status"
git config --global alias.br "branch"
git config --global alias.ch "checkout"
git config --global alias.pull-rebase "pull --rebase"
# from Web+DB Press
git config --global alias.graph "log --graph --date-order --all --pretty=format:'%h%Cred%d %Cgreen%ad %Cblue%cn %Creset%s' --date=short"
# from http://postd.cc/human-git-aliases/
git config --global alias.unstage "reset -q HEAD --"
git config --global alias.amend "commit --amend"
git config --global alias.precommit "diff --cached --diff-algorithm=minimal -w"
git config --global alias.lastchanges "diff HEAD^"
git config --global alias.clone-shallow "clone --depth 1"

#dropbox.py start

if [ -f ~/.bash_profile_local ]; then
    . ~/.bash_profile_local
fi
