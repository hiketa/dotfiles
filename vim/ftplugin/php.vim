" ----------------------------------------------------------
" variables
" ----------------------------------------------------------

" php.vim
let g:php_sql_query = 1
let g:php_html_in_strings = 1
let g:php_parent_error_close = 0
let g:php_parent_error_open = 0
let g:php_no_shorttags = 0
let g:php_sync_method = 0

" phpfolding.vim
let g:php_folding = 0

" ----------------------------------------------------------
" functions
" ----------------------------------------------------------

function! s:AddComment()
  execute
    \ "normal O// "
    \ . strftime("%Y-%m-%d")
    \ . " comment "
    \ . g:hiket_comment_label
endfunction

" ----------------------------------------------------------
" mappings
" ----------------------------------------------------------

nnoremap <buffer> ,ca :<C-u>call <SID>AddComment()<cr>

" ----------------------------------------------------------
"  another settings
" ----------------------------------------------------------

" PSR-2
setlocal colorcolumn=80
setlocal foldmethod=manual

" StanAngleoff/php.vim
" see. https://github.com/StanAngeloff/php.vim
highlight! def link phpDocTags  phpDefine
highlight! def link phpDocParam phpType

" phpfolding.vim
EnableFastPHPFolds

" NOTE:
" php-cs-fixer
" http://fivestar.hatenablog.com/entry/2014/12/08/033345

" vim: et ts=2 sw=2 sts=2
