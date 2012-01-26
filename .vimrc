" turn off vi compatible mode
set nocp

" enable pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" allow opening new buffers without saving old buffer
set hidden

" remove toolbar from gui
set guioptions-=T
set noerrorbells

" put filename and other goodies in status line
set laststatus=2
set statusline=%F%m%r%h%w

" fix backspace
set backspace=indent,eol,start

" code navigation
set number
set cursorline
set linespace=0 
set scrolloff=10

" file based loading "
filetype on
filetype plugin indent on

" turn on auto-indenting
set cindent
set smarttab

" and syntax highlighting
syntax on

" automatically place vim in working directory
set autochdir 

" ignore case in searches unless upper case is used
set ignorecase
set smartcase  

" allow highlight search mode to be togglable
function! ToggleHLSearch() 
       if &hls
            set nohls
       else
            set hls
       endif
endfunction
set nohls

set incsearch

" Ctrl+H Toggles Highlight Search.
map <silent> <C-h> <Esc>:call ToggleHLSearch()<CR>

" Ctrl+A - Normal mode: Select all
nmap <C-a> ggVG

" Ctrl+A - Insert Mode: Select inside of a { block } of code
imap <C-a> <esc>vi{
imap <C-u> <esc>ui<CR>
" Easier searching....
"
" Ctrl+F Searches text under cursor (visual or normal)
nmap <C-f> * 
imap <C-f> <esc> *
vmap <C-f> *


" Alt-Up/Down to move lines up / down
nmap <M-Up> :m-2<CR>==
nmap <M-Down> :m+<CR>==

imap <M-Up> <Esc>:m-2<CR>==gi
imap <M-Down> <Esc>:m+<CR>==gi
    
vmap <M-Up> :m-2<CR>gv=gv
vmap <M-Down> :m'>+<CR>gv=gv

" Alt-Left/Right to unindent/indent
nmap <M-Left> <<
nmap <M-Right> >>

imap <M-Left> ^D
imap <M-Right> ^T

vmap <M-Left> <gv
vmap <M-Right> >g

" allow ; instead of :, so if you're holding shift in normal mode...
nore ; :

" 4-space tabs  "
set shiftwidth=4
set expandtab
set tabstop=4
set shiftround " round to nearest tab when shifting
"au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
"au BufRead,BufNewFile *.py,*.pyw set expandtab


" ctrl+h runs python code "
python << EOL
import vim
def EvaluateCurrentRange():
	eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
au BufRead,BufNewFile *.py map <C-M-r> :py EvaluateCurrentRange() 

" ctrl-s saves file "
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>i

"show at least 2 lines of cmd history"
set cmdheight=2

" font stuff "
" use set guifont=* to bring up GUI "
"set guifont=Courier_New:h9:cANSI
set guifont=Inconsolata\ Medium\ 10

" zoom font in / out 
nmap <C-MouseDown> :silent! let &guifont = substitute(&guifont, ' \zs\d\+', '\=eval(submatch(0)+1)', '')<CR>
nmap <C-MouseUp> :silent! let &guifont = substitute(&guifont, ' \zs\d\+', '\=eval(submatch(0)-1)', '')<CR>
nmap <C-MiddleMouse> :silent! set guifont=Inconsolata\ Medium\ 10<CR>


" pick a decent color scheme
colorscheme koehler 
set background=dark

" enable the mouse
set mouse=a
