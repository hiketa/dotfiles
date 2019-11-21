" see. :h ft-changelog-plugin

" ----------------------------------------------------------
" variables
" ----------------------------------------------------------

let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = g:hiket_myname

" ----------------------------------------------------------
" functions
" ----------------------------------------------------------

function! s:NewItem()
    NewChangelogEntry
    execute "normal a" . strftime("%H:%M") . " "
    " startinsert  : i
    " startinsert! : A
    startinsert!
endfunction

" ----------------------------------------------------------
" mappings
" ----------------------------------------------------------

nnoremap <buffer> <C-i> :<C-u>call <SID>NewItem()<cr>
