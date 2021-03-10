# vim: ft=sh

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias s='screen -r'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias plantuml="java -jar $HOME/.local/libexec/plantuml.jar -txt"
alias proj='cd $(find {~/Projects,~/Projects/server,~/genesiss/src,~/ansible} -maxdepth 1 -type d -print | peco --layout=bottom-up) && vim'
alias pecodiff='vimdiff "$(find . -type f | peco)" "$(find . -type f | peco)"'
alias d='docker'
alias dc='docker container'
alias di='docker image'
alias dv='docker volume'

screen_help() {
cat << _EOT_
screenチートシート
-------------------------------

c-t トリガ

c   ウィンドウ生成
p/n 前/次のウィンドウ
0-9 番のウィンドウ
A   ウィンドウタイトル変更
k   ウィンドウ破棄

|   縦分割
S   横分割
Tab 分割間移動
Q   現在の分割以外を破棄
X   現在の分割を破棄

r   サイズ変更モード(j,kでサイズ変更)

z   サスペンド(復帰はfg)
d   デタッチ
DD  デタッチしてログアウト

F   ウィンドウサイズをフィット
{   ヒストリ

[   コピーモード
_EOT_
}

svnlog_help() {
cat << _EOT_
svn log チートシート
-------------------------------
svn log -r 1:HEAD リビジョン範囲の指定
svn log -l 10     最新N件
svn log -v        変更のあったファイルをリストアップ
svn log --diff    diffを表示
_EOT_
}

bash_shortcut_help() {
cat << _EOT_
Bashショートカット
-------------------------------
C-i    Tab
C-j    Enter
C-_    Undo
C-f    ->
C-b    <-
C-a    Home
C-e    End
Alt-f  -> (Word)
Alt-b  <- (Word)

C-u    d^
C-k    d$
C-w    Delete back (Word)
Alt-d  Delete forward (Word)

C-y    Yank
_EOT_
}

escape_slash() {
    echo "$1" | sed -e 's/\//\\\//g'
}

emptyfiles() {
    find . -type f -size 0c -print
}

# Load git-prompt.sh
# sudo cp $(rpm -ql git | grep git-prompt.sh) ~/.git-prompt.sh
#if [ -f $HOME/.git-prompt.sh ]; then
#	source $HOME/.git-prompt.sh
#fi

if [ -f ~/.local/bash-completion.d/git-prompt.sh ]; then
    source ~/.local/bash-completion.d/git-prompt.sh
    export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi

if [ -f ~/.local/bash-completion.d/git-completion.bash ]; then
    source ~/.local/bash-completion.d/git-completion.bash
fi

if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
