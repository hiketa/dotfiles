"
" Sample .gvimrc
" source $VIMROOT/_gvimrc
"
" Params {{{
"----------------------------------------
let s:presentation_enable = 0
let s:fullscreen_enable = 0
" }}}

" Functions {{{
"----------------------------------------
function! s:default()
    " reset
    set guifont=
    set renderoptions=

    " いろはにほへとちりぬるを
    " わかよたれそつねならむ
    " 0123456789
    " "'`+-;:<>()&$/\
    " 0Oo 9q

    if has('win32') || has('win64')
        " フォント設定
        " 使用できるフォントの一覧は次のコマンドで確認可能。
        "   :set guifont=*

        " アンチエイリアスが無くても見やすい 低dpi環境用
        " 一部文字の判別がしづらい
        "set guifont=SHG30M:h10:cSHIFTJIS

        " プログラミング用ビットマップフォント
        " https://www.donationcoder.com/Software/Jibz/Dina/
        " ASCIIは文字間隔が適度に取られておりとても読みやすいが、
        " 欧文フォントなのでマルチバイト文字の表示はいまいち
        " ビットマップフォントなのでFontLinkを使っても補助フォント側の
        " 縦横比がぴったりにならず、汚くなる
        " コメントを英語で書きたくなるフォント
        "set guifont=Dina:h9

        " ださいが安定感ある バックスラッシュが円記号になる
        "set guifont=ＭＳ\ ゴシック:h10:cSHIFTJIS

        " 日本語文章を作成するときは行間が有って良い
        "set guifont=MigMix\ 2M:h12:cSHIFTJIS

        " MigMixより行間が狭く、プログラミング向けか
        "set guifont=Migu\ 2M:h10:cSHIFTJIS

        " Rictyベースのプログラマ向けフォントという触れ込み
        " ASCIIは見やすい 日本語の形がどうも気に入らない
        "set guifont=Myrica\ M:h12:cSHIFTJIS

        " Cica, CicaE
        " Eは絵文字(Noto Emoji)合成済み版
        " => Cica v2からE版は廃止され、無印版に統合された。
        " https://github.com/miiton/Cica
        set guifont=Cica:h12

        " for kaoriya
        " remode:0  = デフォルト
        " remode:1  = アンチエイリアス無し
        " remode:5  = DWRITE_RENDERING_MODE_NATURAL_SYMMETRIC
        " taamode:1 = D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE
        " gamma:1.0-2.2 = 数値が大きいほど文字が太くなる 要調整
        "set renderoptions=type:directx,renmode:1,taamode:0,gamma:1.2
        set renderoptions=type:directx,renmode:5
    endif

    colorscheme wombat256mod
    "colorscheme molokai

endfunction

function! s:presentation_toggle()
    if s:presentation_enable
        call s:default()
        let s:presentation_enable = 0
    else
        colorscheme default
        let s:presentation_enable = 1
    endif
endfunction

"function! s:fullscreen_toggle()
"    if s:fullscreen_enable
"        simalt ~r<cr>
"        let s:fullscreen_enable = 0
"    else
"        simalt ~x<cr>
"        let s:fullscreen_enable = 1
"    endif
"endfunction
" }}}

" Ex-Commands {{{
"----------------------------------------
command! -nargs=0 PresentationToggle call s:presentation_toggle()
" Fullpath Exコマンドがすぐに補完できないのでいったん消した。
"command! -nargs=0 FullScreenToggle call s:fullscreen_toggle()
" }}}

" Mappings {{{
"----------------------------------------
" FullScreen
nnoremap <f11> :<C-u>FullScreenToggle<cr>
nnoremap <c-f11> :<C-u>PresentationToggle<cr>
" }}}

" Editor Settings {{{
"----------------------------------------
if has('multi_byte_ime')
    highlight CursorIM guifg=NONE guibg=#ff3333
endif

" disable default menuber
set guioptions+=M
" hide menu bar
set guioptions-=m
" disable tearing
set guioptions-=t
" hide tool bar
set guioptions-=T
" hide scroll bar
set guioptions-=r
set guioptions-=l
set guioptions-=L
" yanked string to unnamed register(clipboard)
set clipboard+=unnamed

set linespace=1

" Disable sound and enable visualbell.
set visualbell t_vb=

"winpos 1000 0
"set lines=700
"set lines=60
"set columns=100
"}}}

" Finalize {{{
"----------------------------------------
if has('win32') || has('win64')
  cd $USERPROFILE
endif
call s:default()
" }}}

" vim: foldmethod=marker
