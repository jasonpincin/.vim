set backupdir=~/.vim/tmp
set dir=~/.vim/tmp

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256       " Explicitly tell Vim that the terminal supports 256 colors
set hidden

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set nofoldenable

execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on
colorscheme smyck
set cursorline
" set cursorcolumn
set number
set relativenumber
set pastetoggle=<F12>
syntax on
highlight clear SignColumn

if has('balloon_eval') 
    set ballooneval
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" xnoremap <space>c :!octave --silent \| cut -c8-<cr>

" Strip trailing white space
" ------------------------------------------------------------
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,javascript autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
" ------------------------------------------------------------

" Paste to target indent
" ------------------------------------------------------------
nnoremap <Space>p p`[v`]=
" ------------------------------------------------------------

" Basic buffer maps
" ------------------------------------------------------------
nnoremap bn :bn<CR>
nnoremap bp :bp<CR>
nnoremap bg :e#<CR>
" ------------------------------------------------------------


" Powerline fonts
" ------------------------------------------------------------
let g:airline_powerline_fonts = 1
" ------------------------------------------------------------


" Javascript comlpetion
" ------------------------------------------------------------
let g:nodejs_complete_config = {
\  'js_compl_fn': 'jscomplete#CompleteJS',
\  'max_node_compl_len': 15
\}
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif"
" ------------------------------------------------------------

" CommandT (P in my case) Power!
" ------------------------------------------------------------
set wildignore=.git,coverage/**,node_modules/**,*/node_modules/**,**/node_modules/**
noremap <Leader>p :CommandT<CR>
" ------------------------------------------------------------

" Tabluar rocks
" ------------------------------------------------------------
"if exists(":Tabularize")
  nnoremap <Space>= :Tabularize /=<CR>
  vnoremap <Space>= :Tabularize /=<CR>
  nnoremap <Space>: :Tabularize /:<CR>
  vnoremap <Space>: :Tabularize /:<CR>
"endif
" ------------------------------------------------------------

" Conq goodness
" ------------------------------------------------------------
let g:ConqueTerm_Color = 1
let g:ConqueTerm_SessionSupport = 1
let g:ConqueTerm_ToggleKey = '<Space>i'
let g:ConqueTerm_ExecFileKey = '<Space>x'
" ------------------------------------------------------------

" Gists
" ------------------------------------------------------------
let g:fugitive_github_domains = ['https://gecgithub01.walmart.com']
" ------------------------------------------------------------


" Gists
" ------------------------------------------------------------
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_post_private = 0
let g:github_api_url = 'https://gecgithub01.walmart.com/api/v3/'
let g:gist_api_url = 'https://gecgithub01.walmart.com/api/v3/'
" ------------------------------------------------------------

" Syntastic of more awesome
" ------------------------------------------------------------
function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_conf = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_javascript_checker = "jshint"
" let g:syntastic_javascript_jshint_conf = "~/.jshintrc"
nmap <Leader>e :Errors<CR>
" ------------------------------------------------------------

" Tagbar, does't like #!/usr/bin/env node, so I yanked it
" ------------------------------------------------------------
" nmap <Leader>r :TagbarToggle<CR>
" ------------------------------------------------------------

" NerdTree
" ------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
" ------------------------------------------------------------

" Long bookmarks
" ------------------------------------------------------------
nnoremap <Leader>L :Bookmark 
nnoremap <Leader>l :GotoBookmark 
nnoremap <Leader>; :CopenBookmark<CR> 
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

" Indent guide
" ------------------------------------------------------------
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup=1
" ------------------------------------------------------------

" GIT Gutter
" ------------------------------------------------------------
"  Toggle gutter symbols
" nnoremap <f12> :call ToggleGitGutter()<cr>
" ------------------------------------------------------------

" Restore last position
" ------------------------------------------------------------
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
" ------------------------------------------------------------

" Sessions
" ------------------------------------------------------------
let g:session_autoload = 'no'
" ------------------------------------------------------------

" Visual search & replace
" ------------------------------------------------------------
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <Space>r <Esc>:%s/<c-r>=GetVisual()<cr>/

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
" ------------------------------------------------------------

" Do math on visual selections
" ------------------------------------------------------------
function MyCalc(str)
  if exists("g:MyCalcRounding")
    return system("echo 'x=" . a:str . ";d=.5/10^" . g:MyCalcPresition
          \. ";if (x<0) d=-d; x+=d; scale=" . g:MyCalcPresition . ";print x/1' | bc -l")
  else
    return system("echo 'scale=" . g:MyCalcPresition . " ; print " . a:str . "' | bc -l")
  endif
endfunction

" Control the precision with this variable
let g:MyCalcPresition = 2
" Comment this if you don't want rounding
let g:MyCalcRounding = 1
" Use \C to replace the current line of math expression(s) by the value of the computation:
map <silent> <Space>c :s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Space>c :B s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
" With \C= don't replace, but add the result at the end of the current line
map <silent> <Space>c= :s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Space>c= :B s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Try: :B s/.*/\=MyCalc("1000 - " . submatch(0))/
" The concatenation is important, since otherwise it will try
" to evaluate things like in ":echo 1000 - ' 1748.24'"
vmap <Space>c+ :B s/.*/\=MyCalc(' +' . submatch(0))/<C-Left><C-Left><C-Left><Left>
vmap <Space>c- :B s/.*/\=MyCalc(' -' . submatch(0))/<C-Left><C-Left><C-Left><Left>
" With \Cs you add a block of expressions, whose result appears in the command line
vmap <silent> <Space>ct y:echo MyCalc(substitute(@0," *\n","+","g"))<CR>:silent :noh<CR>
" Try: :MyCalc 12.7 + sqrt(98)
command! -nargs=+ MyCalc :echo MyCalc("<args>")
" ------------------------------------------------------------

" so /Users/jason/tern/vim/tern.vim
