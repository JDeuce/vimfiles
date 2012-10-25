## Intro ##

This is my VIM setup. It is mostly tuned for editing python

## Basic Install ##

 1. Clone the repo.

        * git clone https://github.com/JDeuce/vimfiles.git ~/.vim
        * cd ~/.vim
        * git submodule init
        * git submodule update

        Note: Regardless of where you clone it, you should install the repo to ~/.vim [1].
        You can symlink it, or install it directly as the above command will do.

        * *[1] - technically the location just has to be in $VIMRUNTIME

 2. Symlink ~/.vim/.vimrc to ~/.vimrc

        * ln -s ~/.vim/.vimrc ~/.vimrc

## Extra functionality with these plugins ##

### Command-T ###
The Command-T plugin allows you to type \t to do a
recursive filename search.

If you want to use Command-T you must install it as follows:

    1.      cd ~/.vim/bundle/Command-T/ruby/
    2.      ruby extconf.rb
    3.      make

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
