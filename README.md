# JDeuce's vimfiles

This is my VIM setup. It is mostly tuned for editing python,
javascript, and HTML.

There are many features I have built up over many years of using
vim, and I always like looking at other people's setups.

So here is mine, if you want to make your own setup based on this,
or use this as a starting point for your own, feel free.

I have personally tested and used this setup on the following platforms:

* FreeBSD
* GNU/Linux
* OS X
* Windows (XP/7/8/10)

## Minimum setup

* vim8
* compiled with `+python` or `+python3` support (see :version)

### Recommended setup

* use through a terminal multiplexor
* make sure your full stack supports 256 colors
* use a dark background in your terminal
* compiled with `python` and `python3` support
  (various plugins use both)

### Compiling vim from source

  ```bash
  git clone https://github.com/vim/vim
  cd vim
  ./configure --enable-pythoninterp --enable-python3interp
  make
  sudo make install
  ```

## Features

* plugins tracked as git submodules, loaded with native vim8 bundle.
* asynchronous lint using [ale](https://github.com/w0rp/ale)
  * uses [flake8](http://flake8.pycqa.org/en/latest/) for Python
  * uses [eslint](http://eslint.org/) for JavaScript
  * has support for other languages as you need them
* asynchronous completion using [completor](https://github.com/maralla/completor.vim)
  * uses [jedi](http://jedi.readthedocs.io/en/latest/) for Python
  * uses [tern](https://github.com/ternjs/tern) for JavaScript
  * uses [mdl](https://github.com/markdownlint/markdownlint) for Markdown
  * has support for many other languages
* has [editorconfig](http://editorconfig.org/) support
* uses persistent undo history so you can re-open a file and still undo
* setup to use shared clipboard (i.e. yank/paste between multiple sessions)
* a few high quality plugins
  * NERDtree for file explorer
  * snipmate for tab completion of snippets
    (try super or pdb in python followed by a tab)
  * minibufexpl to show open buffers
  * vim-powerline for fancy status bar
    * needs a custom font
    * can disable this by commenting out this line in vimrc:

    ```
    let g:Powerline_symbols='fancy'  " tell powerline to use patched font
    ```

* highlights dangling whitespace

### Extra syntax highlighting

* [jinja2](http://editorconfig.org/) templates
* [puppet](https://puppet.com/) manifests
* jsx files
* [plantuml](http://plantuml.com/) files

### Extra key bindings

* `<space>p` to bring up a selection list of your previous N pastes,
  for you to select from
* `<ctrl>t` to open up NERDtree
* special alt arrows
  * you may need to enable these in your terminal emulator
  * checkout the MapKeycode function in vimrc
    for how you can manually map the escape codes for them
  * `<alt>k` and `<alt>j` arrows to move lines up/down
  * `<alt>h` and `<alt>l` arrows to unindent/indent
* `<ctrl>h` to toggle highlight search mode
* `<ctrl>f` to do recursive vimgrep on symbol under cursor
* arrow keys turned off (this is vim after all)
* `<ctrl>n` to start using
  [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
* `\b` to swap buffer to last open file
* a few other ones (checkout the config)

### Features you can use with commands

* `:GundoToggle` - hide / show an undo graph if you need more than one branch
* `:Align \<symbol\>` - Visual select a group of lines and then run that
  to align them all on some symbol, such as : or ,
* `:Sw` - run this if you need to :w the file as sudo without re-opening vim

## Installing

### Clone the repo

To start using this setup all you need to do is clone the repo into the right
place.

To completely clone the repo you also need to clone the submodules, which you
can do easier+faster with newer versions of git.

    * Git version ~2.8 or later (download submodules in parallel)

    ```bash
    git clone --recursive -j8 https://github.com/JDeuce/vimfiles.git ~/.vim
    ```

    * Git version ~1.8 or later (download submodules in one command)

    ```bash
    git clone --recursive https://github.com/JDeuce/vimfiles.git ~/.vim
    ```

    * Ancient version of git (download submodules in 4 commands)

    ```bash
    git clone https://github.com/JDeuce/vimfiles.git ~/.vim
    cd ~/.vim
    git submodule init
    git submodule update --recursive
    ```

#### More info

You can also install it on Windows, to C:\Users\x\vimfiles.

You also need to make sure you don't have any other vimfiles runtimes
laying around that could load before this one.

```
:help runtimepath
```

### The bells and whistles

You can do the extra steps to enable these features as you come across
a need for them.

#### Linters

##### Python linters

###### Flake8

Install flake8 onto your system so ale can check python:

    pip install flake8

You may want to install some flake8 plugins, such as this one which lets
you set your preferred quote style:

    pip install flake8-quotes

###### PEP8

The pep8.vim script checks your python code against the PEP8 standard.
This config will run pep8 on an open python file by pressing F5.

This might be useful for projects that you do not use flake8 with.

To use this feature you must install the pep8 command:

    pip install pep8

##### JavaScript linters

###### eslint

Install eslint into your system:

    npm install -g eslint

Or into your project

   yarn add eslint

##### Other linters

##### Markdown

    apt-get install mdl

#### Completor

You must compile completor.
You need node + yarn installed on your system since it is written in JS.

    cd bundle/completor
    make

##### Python completor (jedi)

You need to have jedi installed.
You can install it globally or in a virtualenv.

You need either the python 2 or python 3 version depending
on which code you are editing (or, both!)

Python 2:

    pip install jedi

Python 3:

    pip3 install jedi

##### JavaScript completor (tern)

You need to install tern into completor

    cd ~/.vim/bundle/completor/
    make js

## Modifying the setup

### Plugins

### Editing the vimrc

Note: the keystroke to unfold all code is zR

#### Adding a plugin

You just have to pass the repo URL and the bundle path you want to use to git:

```bash
git submodule add https://github.com/maralla/completor.vim bundle/completor
```

#### Removing plugin

* Delete section from .gitmodules
* Stage change to .gitmodules
* git rm bundle/x file
* git commit

#### Updating a plugin

    git submodule update
