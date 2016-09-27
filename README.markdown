## Intro ##

This is my VIM setup. It is mostly tuned for editing python

## Basic Install ##

 1. Clone the repo into ~/.vim.

        git clone https://github.com/JDeuce/vimfiles.git ~/.vim
        cd ~/.vim
        git submodule init
        git submodule update --recursive

 Note: If you really don't want to put it in ~/.vim, you just need to make
 sure the project is checked out and exposed to $VIMRUNTIME

 2. Symlink the vimrc into place

        ln -s ~/.vim/.vimrc ~/.vimrc

## Extra functionality with these plugins ##

### Pep8 ###
The pep8.vim script checks your python code against hte pep8 standard
by simply pressing F5.

You must install the pep8 command:

    1. pip install pep8

### vim-powerline ###
By default I use fancy fonts in vim-powerline, so you need to set your terminal emulator
to use the patched font in the patched fonts directory.
Or comment out this line from the vimrc:

    let g:Powerline_symbols='fancy'  " tell powerline to use patched font

### pyflakes ###
If you are going to let the syntastic plugin check your vim source, then you
should install the pyflakes package.

E.g.:

    apt-get install pyflakes
