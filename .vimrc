" ----------------------------------------
" pathogen initialization {{{
" ----------------------------------------
" disable to initialize pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" re-enable after pathogen starts
filetype on

" ----------------------------------------
" end pathogen initialization }}}
" ----------------------------------------


" ----------------------------------------
" vim behavior {{{
" ----------------------------------------
set isfname-==                 " don't allow completion of filenames with the '=' character
                               " (this allows compl. of fname to var assignments in shell scripts)
set nocompatible               " vim behaves more usefully
set noautochdir                " don't automatically place vim in working directory of any opened files
set encoding=utf-8             " use unicode from within vim
set hidden                     " allow opening new buffers without saving old buffer
set noerrorbells               " quit with your beeping
set laststatus=1               " only show status line when there's at least two files
set backspace=indent,eol,start " let backspace work anywhere in insert mode
set nonumber                   " don't show line numbers
set cursorline                 " highlight the active editor line
set scrolloff=10               " ensure at least 10 lines are always visible below cursor when scrolling
set cmdheight=1                " show only a single line of command line history
syntax on                      " enable syntax highlighting
set linespace=0                " no extra whitespace between lines is required

" indent settings
set expandtab                  " expand tabs to spaces
set tabstop=4                  " use 4 spaces on tab
set smarttab                   " round to nearest tab on tab
set shiftwidth=4               " use 4 spaces on <<,>>
set shiftround                 " round to nearest tab on <<,>>
filetype plugin indent on      " enable per-filetype indent settings

" search settings
set incsearch                  " use incremental search mode
set nohls                      " disable highlight search mode
set ignorecase                 " ignore case by default on searches
set smartcase                  " unless i explicitly type uppercase, then match it

if version >= 703
    " new persistent undo in vim 7.3
    set undodir=~/.vim/tmp/undo/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" keep backups in /tmp
set backupdir=~/.vim/tmp/backup/
set backup
set directory=~/.vim/tmp/swap/

" enable folding based on marker
set foldenable
set foldmethod=marker
set foldmarker={{{,}}}

" set molokai color scheme
colors molokai
set background=dark
highlight ColorColumn ctermbg=red

" use the system clipboard (allows sharing between multiple vim instances)
set clipboard=unnamed

command Sw :w !sudo tee % > /dev/null

" ----------------------------------------
" end vim behavior }}}
" ----------------------------------------

" ----------------------------------------
" gui tweaks {{{
" ----------------------------------------
if has("gui_running")
    " gui tweaks:
    set guioptions-=T " disable toolbar
    set guioptions-=m " disable menu
    " miniBuffExpl options
    " always show miniBufExpl

    " font stuff "
    " use set guifont=* to bring up GUI "
    set guifont=Inconsolata\ Medium\ 10

    " zoom font in / out with mouse
    nmap <C-MouseDown> :silent! let &guifont = substitute(&guifont, ' \zs\d\+', '\=eval(submatch(0)+1)', '')<CR>
    nmap <C-MouseUp> :silent! let &guifont = substitute(&guifont, ' \zs\d\+', '\=eval(submatch(0)-1)', '')<CR>
    nmap <C-MiddleMouse> :silent! set guifont=Inconsolata\ Medium\ 10<CR>

    " change default directory when opening vim
    if hostname() == "jjaques-desktop"
        chdir /home/jjaques/dev
    endif

    " ensure filename and path are in the title bar
    set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
endif
" ----------------------------------------
" end gui tweaks }}}
" ----------------------------------------

" ----------------------------------------
" console tweaks {{{
" ----------------------------------------
function! MapKeycode(intermediate, key, keycode)
    " based on http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
    " vim doesn't allow you to say set <M-up>=Escaped code
    " you must first set another intermediate, then map the command to m-up
    exec 'set '.a:intermediate.'='.a:keycode
    exec 'map '.a:intermediate.' '.a:key
    exec 'imap '.a:intermediate.' '.a:key
endfunction

if !has("gui_running")
    " enable the mouse
    set mouse=a
    set ttymouse=xterm2
    set t_Co=256

    if &term == "screen-256color"
        " remap the alt+arrows to the ones we get from screen
        call MapKeycode('<F13>' , '<M-Up>'        , '[1;3A')
        call MapKeycode('<F14>' , '<M-Down>'      , '[1;3B')
        call MapKeycode('<F15>' , '<M-Left>'      , '[1;3D')
        call MapKeycode('<F16>' , '<M-Right>'     , '[1;3C')
        call MapKeycode('<F17>' , '<S-Up>'    , '[1;2A')
        call MapKeycode('<F18>' , '<S-Down>'  , '[1;2B')
        call MapKeycode('<F19>' , '<S-Left>'  , '[1;2D')
        call MapKeycode('<F20>' , '<S-Right>' , '[1;2C')
    endif
endif
" ----------------------------------------
" end console tweaks }}}
" ----------------------------------------

" ----------------------------------------
" highlights {{{
" ----------------------------------------
match SpellBad /\s\+$/ " highlight dangling whitespace
" ----------------------------------------
" end highlights }}}
" ----------------------------------------

" ----------------------------------------
" plugin settings {{{
" ----------------------------------------

" powerline settings {{{
    set noshowmode                   " disable default editor mode
    let g:Powerline_symbols='fancy'  " tell powerline to use patched font
" end powerline settings }}}

" NERDtree settings {{{
    " ignore ~ and pyc files in nerd tree
    let NERDTreeIgnore=['\~$', '.pyc$']
" end NERDtree settings }}}

" MiniBuffExpl settings {{{
    " ensure the MBE window displays even with only 1 tab to show
    " disable for now because it seems to mess with :q
    "let g:miniBufExplorerMoreThanOne=1
" end MiniBuffExpl setings }}}

" JEDI settings {{{
autocmd FileType python setlocal completeopt-=preview
" end JEDI settings }}}

" Syntastic {{{
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['pyflakes']
" end Syntastic settings }}}

" Unite settings {{{
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 5
" end Unite settings }}}

" multiple-cursors settings {{{
" only exit multiple cursors from normal mode
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
" end multiple-cursors settings }}}

"
" ----------------------------------------
" end plugin settings }}}
" ----------------------------------------

" ----------------------------------------
" key bindings {{{
" ----------------------------------------
" NATIVE bindings:

" Ctrl+f does recursive grep on current word
nmap <C-f> :vimgrep <cword> *.*<cr>:copen<cr>

" map ; to : so holding shift doesn't mess up command mode
nore ; :

"  Ctrl+H Toggles Highlight Search {{{
    function! ToggleHLSearch()
        " toggle the hls setting
        if &hls
            set nohls
        else
            set hls
        endif
    endfunction
    map <silent> <C-h> <Esc>:call ToggleHLSearch()<CR>
" End Ctrl+H }}}

" Ctrl+R Runs Visually Selected Python Code {{{
try
    python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
    au BufRead,BufNewFile *.py vmap <C-r> :py EvaluateCurrentRange()
catch
endtry
" End Ctrl+R }}}

" Alt+Up/Alt+Down move lines around {{{
    nmap <M-Up> :m-2<CR>==
    nmap <M-Down> :m+<CR>==

    imap <M-Up> <Esc>:m-2<CR>==gi
    imap <M-Down> <Esc>:m+<CR>==gi

    vmap <M-Up> :m-2<CR>gv=gv
    vmap <M-Down> :m'>+<CR>gv=gv
" end Alt+Up/Alt+down }}}

" Alt+Left/Alt+Right to unindent/indent {{{
    nmap <M-Left> <<
    nmap <M-Right> >>

    imap <M-Left> ^D
    imap <M-Right> ^T

    vmap <M-Left> <gv
    vmap <M-Right> >g
" end Alt+left/Alt+right }}}
"
" Shift+arrows visual{{{
    nmap <S-Up> v^<Up>
    vmap <S-Up> ^<Up>
    imap <S-Up> <Esc>v^<Up>
    nmap <S-Down> v$<Down>
    vmap <S-Down> $<Down>
    imap <S-Down> <Esc>v$<Down>
    nmap <S-Left> v<Left>
    vmap <S-Left> <Left>
    imap <S-Left> <Esc>v<Left>
    nmap <S-Right> v<Right>
    vmap <S-Right> <Right>
    imap <S-Right> <Esc>v<Right>
    vmap <S-End> $
    vmap <S-Home> 0
" end shift+arrows }}}

" Bind . and & in visual mode.
" Allows one to repeat commands and search replacements you made on one
" line to all lines in a visual selection
vnoremap . :normal .<CR>
vnoremap & :normal &<CR>

" \b to switch to last buffer
nmap <leader>b :b#<CR>

" PLUGIN bindings:
" Ctrl+N toggles nerd tree
nmap <C-T> :NERDTreeToggle<CR>

" Unite bindings
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>p :Unite history/yank<cr>

" ----------------------------------------
" end key bindings }}}
" ----------------------------------------
"

"--- rip arrows

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
