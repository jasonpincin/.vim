execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

" Multi Cursor
" ------------------------------------------------------------
" Manually place cursors
noremap <d-'> :<c-u>call MultiCursorPlaceCursor()<cr>
" Use Manually places cursors
nnoremap <d-a-'> :<c-u>call MultiCursorManual()<cr>
" Cancel un-used manually placed cursors
nnoremap <d-s-'> :<c-u>call MultiCursorRemoveCursors()<cr>
" Place one cursor per visually selected line
"  - Prepend number (X)  before key combo to place 
"    cursor every X lines
xnoremap <c-ui> :<c-u>call MultiCursorVisual()<cr>
" Place cursors via regular expressions
nnoremap <c-a> :<c-u>call MultiCursorSearch('')<cr>
" Place a cursor at every word matching the word under 
" the cursor
nnoremap <c-w> :<c-u>call MultiCursorSearch('<c-r><c-w>')<cr>
" Place a cursor at every set of characters like those 
" visually selected
xnoremap <c-f2> "*y<Esc>:call MultiCursorSearch('<c-r>=substitute(escape(@*, '\/.*$^~[]'), "\n", '\\n', "g")<cr>')<cr>
" Go back to single cursor
let g:multicursor_quit = "<d-c-\/>"
" ------------------------------------------------------------
