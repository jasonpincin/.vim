set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256       " Explicitly tell Vim that the terminal supports 256 colors

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set autoindent

execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on
colorscheme smyck
set cursorline
" set cursorcolumn
set number
set pastetoggle=<F12>
syntax on
highlight clear SignColumn

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" xnoremap <space>c :!octave --silent \| cut -c8-<cr>


" CommandT (P in my case) Power!
" ------------------------------------------------------------
set wildignore=.git,node_modules/**,*/node_modules/**,**/node_modules/**
noremap <Leader>p :CommandT<CR>
" ------------------------------------------------------------

" Gists
" ------------------------------------------------------------
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:github_api_url = 'http://git.www.euro-pro.local/api/v3'
" ------------------------------------------------------------

" Syntastic of more awesome
" ------------------------------------------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checker = "jshint"
let g:syntastic_javascript_jshint_conf = "~/.jshintrc"
nmap <Leader>e :Errors<CR>
" ------------------------------------------------------------

" Tagbar of awesome
" ------------------------------------------------------------
nmap <Leader>r :TagbarToggle<CR>
" ------------------------------------------------------------

" Multi Cursor
" ------------------------------------------------------------
" Manually place cursors
noremap <F2> :<c-u>call MultiCursorPlaceCursor()<cr>
" Use Manually places cursors
nnoremap <Leader>] :<c-u>call MultiCursorManual()<cr>
" Cancel un-used manually placed cursors
nnoremap <Leader>c :<c-u>call MultiCursorRemoveCursors()<cr>
" Place one cursor per visually selected line
"  - Prepend number (X)  before key combo to place 
"    cursor every X lines
xnoremap <F2> :<c-u>call MultiCursorVisual()<cr>
" Place cursors via regular expressions
nnoremap <Leader><F2> :<c-u>call MultiCursorSearch('')<cr>
" Place a cursor at every word matching the word under 
" the cursor
nnoremap <Leader>w :<c-u>call MultiCursorSearch('<c-r><c-w>')<cr>
" Go back to single cursor
let g:multicursor_quit = "<Leader>C"
" ------------------------------------------------------------

" GIT Gutter
" ------------------------------------------------------------
"  Toggle gutter symbols
" nnoremap <f12> :call ToggleGitGutter()<cr>
" ------------------------------------------------------------

" Restore last position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
