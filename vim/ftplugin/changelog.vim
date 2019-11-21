" see :h ftplugin-special

if !exists("*s:append_todo_line")
  function! s:append_todo_line()
    let l:rand = sha256(reltimestr(reltime()))[:7]
    echo l:rand
    call s:new_item()
    execute 'normal aTODO:' . l:rand . ':'
    startinsert!
  endfunction
endif

if !exists("*s:new_item")
  function! s:new_item()
    NewChangelogEntry
    execute "normal a" . strftime("%H:%M") . " "
    " without ! : i
    " with !    : A
    startinsert!
  endfunction
endif

"command! -buffer -nargs=0 AppendTodoLine call s:append_todo_line()

" <C-i> 時刻付きの行を追加する。
nnoremap <buffer> <C-i> :<C-u>call <SID>new_item()<cr>

" <C-o> 識別子付きのTODO:行を挿入する。時刻も付く。
nnoremap <buffer> <C-o> :<C-u>call <SID>append_todo_line()<cr>
