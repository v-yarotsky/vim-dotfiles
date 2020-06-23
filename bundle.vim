"==================================================vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'commentary.vim'
Plugin 'fugitive.vim'
Plugin 'gitignore'
Plugin 'repeat.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'splitjoin.vim'
Plugin 'surround.vim'
Plugin 'Tabular'
Plugin 'vim-coffee-script'
Plugin 'fatih/vim-go'
Plugin 'jamessan/vim-gnupg'
Plugin 'ejholmes/vim-forcedotcom'
Plugin 'w0rp/ale'
Plugin 'ElmCast/elm-vim'
Plugin 'benmills/vimux'
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-scripts/DrawIt'
Plugin 'hashivim/vim-terraform'
Plugin 'pedrohdz/vim-yaml-folds'
Plugin 'lmeijvogel/vim-yaml-helper'

call vundle#end()
filetype plugin indent on

