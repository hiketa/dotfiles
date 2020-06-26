" ----------------------------------------------------------
" 初期化
" ----------------------------------------------------------

" see. http://rbtnn.hateblo.jp/entry/2014/11/30/174749
set encoding=utf-8
scriptencoding utf-8

syntax off
filetype off
autocmd!

" ----------------------------------------------------------
" エンコーディング
" ----------------------------------------------------------

set termencoding=utf-8
set fileencodings=utf-8,eucjp-ms,euc-jp,cp932
set fileencoding=utf-8
set fileformats=unix,dos,mac
set fileformat=unix
set ambiwidth=double

" ----------------------------------------------------------
" 以下の設定で使用するグローバル変数
" ----------------------------------------------------------

let g:my_dotfiles_dir = '~/Projects/dotfiles'
let g:my_vimrc = g:my_dotfiles_dir . '/vimrc'
let g:my_gvimrc = g:my_dotfiles_dir . '/gvimrc'

let g:my_undo_dir = '~/.vim-undo'
let g:my_plugins_dir = '~/.vim-plugins'
let g:my_template_dir = '~/.vim-template'
let g:my_pgsql_dbhost = '127.0.0.1'
let g:my_pgsql_dbname = 'postgres'
let g:my_pgsql_dbport = '5432'
let g:my_name = 'hiket'
if $MY_NAME != ""
  let g:my_name = $MY_NAME
endif
let g:my_dropbox_dir = '~/Dropbox'
if $MY_DROPBOX_DIR != ""
  let g:my_dropbox_dir = $MY_DROPBOX_DIR
endif

" ----------------------------------------------------------
" プラグイン
" ----------------------------------------------------------

" [Installation]
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" [Usage]
" PlugInstall  : Install plugins
" PlugUpdate   : Install or update plugins
" PlugClean[!] : Remove unused directories (!: no prompt)
" PlugUpgrade  : Upgrade vim-plug itself
" see also: https://github.com/junegunn/vim-plug#commands
call plug#begin(g:my_plugins_dir)

" common
Plug 'vim-jp/vimdoc-ja'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'thinca/vim-ref'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-visualstar'
Plug 'mattn/sonictemplate-vim'
" powerlineのシンプル版
Plug 'itchyny/lightline.vim'
" lightlineやCtrlPをデコレーション
" PuTTYなど一部マルチバイト対応が不完全な環境でズレる。
"Plug 'ryanoasis/vim-devicons'
" 様々なfiletypeのシンタックスチェックをしてくれる
" LSPで代替できないかしばらく様子を見る
"Plug 'scrooloose/syntastic'
" 日付のイン/デクリメント
Plug 'tpope/vim-speeddating'
" モダンな感じのAlign.vim
" 操作方法は癖がある。とりあえずVisualモードで
" ,ga*<delimiter> で全列を<delimiter>基準で揃えることができる。
" <delimiter>に指定できるのは、<space> = . , | : & #である。
" see also: https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Language Server Protocol & Autocomplete
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" VCS
Plug 'vim-scripts/vcscommand.vim'

" HTML/CSS
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'

" PHP
Plug 'vim-scripts/phpfolding.vim'
Plug 'StanAngeloff/php.vim' "syntax for >=php5.3
Plug 'stephpy/vim-php-cs-fixer'

" Memo
Plug 'glidenote/memolist.vim'

" colorscheme
Plug 'hiketa/wombat256.vim'

call plug#end()

" ----------------------------------------------------------
" プラグイン設定
" ----------------------------------------------------------

" Disable MatchParen
" http://takesita.seesaa.net/article/49087144.html
let g:loaded_matchparen = 1

" asyncomplete.vim
" 挿入モード時に自動的にポップアップを表示させる。
let g:asyncomplete_auto_popup = 1
" あいまい検索を行うものらしいが、clangdでうまく動作しなかった
" (単に対応していないのかもしれない)。
" 調査メモ:
" autoload/asyncomplete.vimのs:core_complete()で
" vim組込のcomplete()を呼び出している。
" その直前の候補の配列を取得している処理で
" smart_completionが有効であるときはcustom_filter_completion_items()
" から配列を得ようとするのだが、これが空配列しか返さないため
" ポップアップが表示されなくなってしまう。
"let g:asyncomplete_smart_completion = 0
" 動作ログを残すことができる。
" また、call asyncomplete#log()を自分で書き加えることで
" printデバッグもできる。
"let g:asyncomplete_log_file = $HOME . '/.asyncomplete.log'
"let g:asyncomplete_popup_delay = 100

" changelog.vim
" see :h ft-changelog-plugin
let g:changelog_username = g:my_name

" CtrlP
" 1にするとディレクトリが検索対象にならなくなる
let g:ctrlp_by_filename = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_highlight_match = [1, 'Search']
let g:ctrlp_working_path_mode = 'ra'
" https://github.com/kien/ctrlp.vim/pull/276
let g:ctrlp_key_loop = 1

" phpfolding.vim
let g:DisableAutoPHPFolding = 1

" memolist
let g:memolist_path = g:my_dropbox_dir . '/Memo/data'
let g:memolist_template_dir_path = g:my_dropbox_dir . '/Memo/tpl'
let g:memolist_memo_suffix = 'md'
let g:memolist_qfixgrep = 0
let g:memolist_vimfiler = 0
let g:memolist_prompt_tags = 1
let g:memolist_prompt_categories = 0

" php.vim
let g:php_sql_query = 1
let g:php_html_in_strings = 1
let g:php_parent_error_close = 0
let g:php_parent_error_open = 0
let g:php_no_shorttags = 0
let g:php_sync_method = 0
let g:php_folding = 1

" vim-ref
" PHP Manual http://www.php.net/download-docs.php
if has('win32') || has('win64')
  let g:ref_phpmanual_path = $HOME . '/.phpmanual'
else
  let g:ref_phpmanual_path = $HOME . '/share/php-chunked-xhtml'
endif

" emmet-vim
let g:user_emmet_leader_key = '<c-e>'
let g:user_emmet_complete_tag = 1
let g:user_emmet_settings = {
\  'lang' : 'ja',
\  'html' : {
\    'indentation' : '  '
\  },
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'html,c',
\    'indentation' : '    '
\  },
\}

" quickrun
let g:quickrun_config = {
\  '*': {
\    'split': '',
\    'hook/time/enable': '1',
\  }
\}
let g:quickrun_config.sql = {
\  'command': 'psql',
\  'args': "-h '%{g:my_pgsql_dbhost}' -d '%{g:my_pgsql_dbname}' -p '%{g:my_pgsql_dbport}'",
\  'exec': "%c %a -f '%s'",
\}

" sonictemplate-vim
let g:sonictemplate_vim_template_dir = g:my_template_dir

" speeddating
" 日付として認識される書式を追加する。
" アンドキュメントだがplugin/speeddating.vimを見る限り
" この変数で設定できるようだ。
" :SpeedDatingFormatという書式追加用Exコマンドもあるが
" .vimrc読み込み時点ではRuntimePathの処理がされていないので
" Exコマンドが見つからないというエラーになってしまう。
let g:speeddating_formats = [
\  ['%Y/%m/%d', 0, 0],
\  ['%Y-%m-%d', 0, 0],
\  ['%Y.%m.%d', 0, 0],
\]

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ----------------------------------------------------------
" 各種動作設定
" ----------------------------------------------------------

" 保存時にファイル末尾の改行コードを変更しない
" see. https://github.com/vim-jp/issues/issues/152
set nofixendofline
" 日本語ヘルプを優先する
set helplang=ja,en
" ベルを無効にする
set belloff=all
" ビジュアルベルを無効にする
set novisualbell
" 文字数での自動改行 0で無効化
set textwidth=0
" タブの代わりにスペースを
set expandtab
" スペースインデントの挙動を賢くする
set smarttab
" インデントで挿入されるスペース数
set shiftwidth=4
" タブの代わりに入力されるスペースの数
set softtabstop=4
" 表示上のタブ文字幅
set tabstop=4
" 自動的にインデント
set autoindent
" C系に有効な高度な自動インデント
set smartindent
" 検索時、大文字小文字を区別しない
set ignorecase
" 検索時、大文字が含まれる時のみignorecaseを無効にする
set smartcase
" 補完用ポップアップに掲載する情報の調整
" このあたりはasyncompleteの挙動にまかせる。
"set completeopt-=preview
"set completeopt+=menuone
" 閉じ括弧を入力した時、一瞬対応する括弧にジャンプする
set showmatch
" 行番号を表示
set number
" 折り返さない
set nowrap
" バックアップファイルを作らない
set nobackup
" ファイル書き込みの前にバックアップを作り、書き込みが成功したら削除する
set writebackup
" undo履歴の復元を有効化
" see. http://www.kaoriya.net/blog/2014/03/30/
set undofile
" undo履歴を保存するディレクトリ
let &undodir=g:my_undo_dir
" Vim以外でファイルが変更されたことを検知して開きなおす
set autoread
" 256色対応
" see. http://vim-jp.org/vim-users-jp/2009/08/29/Hack-64.html
set t_Co=256
" 2=ステータス行を常に表示
set laststatus=2
" サイン列(左端にでるマークを表示するスペース)を常に表示する
" auto=サインがある時だけ表示, no=表示しない
" yes=常に表示, number=numberカラムに表示する
" デフォルトのautoはガタガタ動いて見苦しいので他にする。
set signcolumn=number
" モードラインを有効化
" 環境によってはデフォルトで無効化されていることがあった(Ubuntu等)
set modeline
" 外部grep
" rg(ripgrep)はRust製のGrepツール(https://github.com/BurntSushi/ripgrep)。
" 上記URLからDLしてPATHを通しておくこと。
" -t<type>でファイルタイプ指定。--type-listで対応ファイルタイプを閲覧。
" -Fでfgrep相当の動作。
" --hiddenで隠しファイルも対象に含める。
" --no-ignoreで.gitignoreの考慮をしない。
set grepprg=rg\ --vimgrep

" ----------------------------------------------------------
" 独自関数
" ----------------------------------------------------------

if !exists('g:my_vimrc_reload_defined')
  function s:my_vimrc_reload()
    execute 'so ' . g:my_vimrc
    " Windows環境でたまにクラッシュするのでコメントアウト
    "if has('gui_running')
    "  execute 'so ' . g:my_gvimrc
    "endif
    echon 'vimrc reload completed.'
  endfunction
  let g:my_vimrc_reload_defined = 1
endif

function! s:my_vimrc_edit()
  execute 'tabedit ' . g:my_vimrc
  execute 'lcd ' . g:my_dotfiles_dir
endfunction

function! s:on_lsp_buffer_enabled()
  "setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> ;d <plug>(lsp-definition)
  nmap <buffer> ;r <plug>(lsp-references)
  nmap <buffer> ;i <plug>(lsp-implementation)
  nmap <buffer> ;t <plug>(lsp-type-definition)
  nmap <buffer> ;s <plug>(lsp-rename)
  nmap <buffer> ;p <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ;n <Plug>(lsp-next-diagnostic)
  nmap <buffer> ;k <plug>(lsp-hover)
endfunction

" ----------------------------------------------------------
" Exコマンド
" ----------------------------------------------------------

command! -nargs=0 Config call s:my_vimrc_edit()
command! -nargs=0 Reload call s:my_vimrc_reload()
command! -nargs=1 DbName let g:my_pgsql_dbname = "<args>"
command! -nargs=1 DbPort let g:my_pgsql_dbport = "<args>"
command! -nargs=0 Fullpath echo expand("%:p")
command! -nargs=0 WinHostsOpen edit C:\Windows\System32\drivers\etc\hosts
" changelog用。暗号化されたファイルは外部grepが使用できないのでvimgrepで代用する。
command! -nargs=0 Todogrep vimgrep "TODO:" %:p

" PHP
command! -nargs=0 PhpCsFixer :call PhpCsFixerFixFile()

" ----------------------------------------------------------
" マッピング
" ----------------------------------------------------------

nnoremap <silent> <f12>   :<C-u>Config<cr>
nnoremap <silent> <c-f12> :<C-u>Reload<cr>
nnoremap tt    :<C-u>tabe<cr>
nnoremap tc    :<C-u>tabc<cr>
nnoremap <C-h> :<C-u>tabp<cr>
nnoremap <C-l> :<C-u>tabn<cr>
nnoremap / :<C-u>set hlsearch<cr>/
nnoremap ? :<C-u>set hlsearch<cr>?
nnoremap * :<C-u>set hlsearch<cr>*
nnoremap # :<C-u>set hlsearch<cr>#
nnoremap <Esc><Esc> :<C-u>set nohlsearch<return>
nnoremap j gj
nnoremap k gk
nnoremap ( ci(
" <<等と衝突するので使用できない。
"nnoremap < ci<
" ``等と衝突するので使用できない。
"nnoremap ` ci`
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
nnoremap <silent> <Left>  2<C-w><
nnoremap <silent> <Right> 2<C-w>>
nnoremap <silent> <Up>    2<C-w>-
nnoremap <silent> <Down>  2<C-w>+

" [,] CtrlP
" fnameescapeでパスにスペースが入っているケースに対応する。
nnoremap <silent> ,, :<C-u>execute "CtrlP " . fnameescape(getcwd())<cr>
nnoremap <silent> ,mm :<C-u>execute "CtrlP " . g:memolist_path<cr>

" [m] memolist
nnoremap ,mn :<C-u>MemoNew<cr>

" [g] vimgrep
nnoremap ,gr :<C-u>vimgrep<space><space>%<left><left>

" vim-easy-align
" vim-scripts/Alignでよく使っていたマッピング。手癖になっている。
xnoremap <silent> <Leader>tsp :<C-u>'<,'>EasyAlign *\ <cr>
xnoremap <silent> <Leader>t= :<C-u>'<,'>EasyAlign *=<cr>

" [r] quickrun
nnoremap ,rr :<C-u>QuickRun<cr>
vnoremap ,rr :<C-u>'<,'>QuickRun<cr>
nnoremap ,rs :<C-u>QuickRun sql<cr>
vnoremap ,rs :<C-u>'<,'>QuickRun sql<cr>

" Markdown用の線を引く
nnoremap <silent> ,h1 $a<cr><esc>60i=<esc>a<cr><cr><esc>
nnoremap <silent> ,h2 $a<cr><esc>60i-<esc>a<cr><cr><esc>
nnoremap <silent> ,h3 3i#<esc>
nnoremap <silent> ,h4 4i#<esc>

" Changelogを開く
nnoremap <silent> ,ch :<C-u>execute 'edit ' . g:my_dropbox_dir . '/changelog'<cr>
" TODOを開く
nnoremap <silent> ,ct :<C-u>execute 'edit ' . g:my_dropbox_dir . '/todo'<cr>

" complete()のサンプル
"inoremap <F5> <C-R>=ListMonths()<CR>
"func! ListMonths()
"  call complete(col('.'), ['January', 'February', 'March',
"	\ 'April', 'May', 'June', 'July', 'August', 'September',
"	\ 'October', 'November', 'December'])
"  return ''
"endfunc

" ----------------------------------------------------------
" オートコマンド
" ----------------------------------------------------------

" grepやvimgrepしたあとQuickFixを開く
" see. http://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b
augroup my_GrepToCWindow
  autocmd!
  autocmd QuickFixCmdPost *grep cwindow
augroup END

" 行末の空白をハイライトする
" see. http://d.hatena.ne.jp/mickey24/20120808/vim_highlight_trailing_spaces
augroup my_HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme *
        \ highlight TrailingSpaces term=underline guibg=Black ctermbg=DarkGray
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" ----------------------------------------------------------
" Language Server Protocol
" ----------------------------------------------------------

let g:php_language_server_path_expanded =
  \ expand(g:my_plugins_dir . '/php-language-server/bin/php-language-server.php')

" vim-lsp用デバッグログ
"let g:lsp_log_file = $HOME . '/.vim-lsp.log'

augroup my_LSP
  autocmd!
  " C/C++
  " https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Clangd
  if executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'clangd',
      \ 'cmd': {server_info->['clangd']},
      \ 'whitelist': ['c', 'cpp'],
      \ })
    " オムニ補完とLSPの結果を紐づけることもできるが、
    " asyncomplete-lspがオムニ補完を経由せずに直接
    " complete()を使って候補を出してくれるようなので省略。
    "autocmd FileType c,cpp setlocal omnifunc=lsp#complete
  endif
  " PHP
  " intelephenseはあらかじめインストールしておく
  " sudo npm -g i intelephense
  if executable('intelephense')
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'intelephense',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
      \ 'whitelist': ['php'],
      \ 'initialization_options': {'storagePath': '/tmp/intelephense'},
      \ 'workspace_config': {
      \   'intelephense': {
      \     'files': {
      \       'maxSize': 1000000,
      \       'associations': ['*.php', '*.phtml'],
      \       'exclude': [],
      \     },
      \     'completion': {
      \       'insertUseDeclaration': v:true,
      \       'fullyQualifyGlobalConstantsAndFunctions': v:false,
      \       'triggerParameterHints': v:true,
      \       'maxItems': 100,
      \     },
      \     'format': {
      \       'enable': v:true
      \     },
      \   },
      \ }
      \})
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  endif
augroup END

" ----------------------------------------------------------
" Code formatter
" ----------------------------------------------------------

augroup my_CodeFormatter
  autocmd!
  if executable('php-cs-fixer')
    " php-cs-fixerの自動実行
    autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
  endif
augroup END

" ----------------------------------------------------------
" カラースキーム
" ----------------------------------------------------------

colorscheme wombat256mod

" ----------------------------------------------------------
" 終端
" ----------------------------------------------------------

syntax on
filetype plugin indent on

" 流れてしまったエラーメッセージを再表示するときは
" :mes[sages]というEXコマンドを使うこと。
" http://vim-users.jp/2009/10/hack90/
" また、どのプラグインでエラーが発生しているか分からないときは
" vim -Vとするとverbose状態でvimが起動して分かる事が有る。

" vim: et ts=2 sw=2 sts=2
