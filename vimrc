"==================================================vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'commentary.vim'
Plugin 'ctrlp.vim'
Plugin 'fugitive.vim'
Plugin 'gitignore'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'matchit.zip'
Plugin 'rails.vim'
Plugin 'repeat.vim'
Plugin 'ack.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'Simple-Javascript-Indenter'
Plugin 'splitjoin.vim'
Plugin 'ervandew/SuperTab'
Plugin 'surround.vim'
Plugin 'Tabular'
Plugin 'textobj-rubyblock'
Plugin 'textobj-user'
Plugin 'tlib'
Plugin 'SirVer/UltiSnips'
Plugin 'unimpaired.vim'
Plugin 'vim-coffee-script'
Plugin 'VimClojure'
Plugin 'Blackrush/vim-gocode'
Plugin 'v-yarotsky/askack.vim'

call vundle#end()

"==================================================general settings
filetype plugin indent on
syntax on
set hidden
set bufhidden=delete
set exrc
set secure
set nowrap
set nobackup
set nowritebackup
set noswapfile
set dir=$HOME/.vim/tmp/

set softtabstop=2
set shiftwidth=2
set shiftround "use multiple of shiftwidth when indenting with '<' and '>'
set expandtab

set shell=/bin/sh
set grepprg=ack

set clipboard=unnamed

"==================================================ruby specifig settings
compiler ruby
let ruby_fold=1
set foldlevel=99



"==================================================look & feel
set background=dark
colorscheme Tomorrow-Night

set laststatus=2    "always show statusbar
set showtabline=1   "always show tabs bar
set number          "show line numbers
set relativenumber  "show line numbers relative to current
set showmatch       "show matching braces
set ttyfast
set t_Co=256        "set 256 colors mode
set incsearch       "turn on incremental search
set backspace=indent,eol,start
set scrolloff=3
set lazyredraw
au InsertEnter * hi StatusLine term=reverse ctermbg=234
au InsertLeave * hi StatusLine term=reverse ctermbg=237

set wildmenu
set wildmode=longest,list
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.DS_Store,doc/**,tmp/**,log/**

set completeopt=longest,menuone

"==================================================mappings
nmap <leader>ve :tabedit $MYVIMRC<CR>

"search and replace selected
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"==================================================plugins settings
for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor

set tags += "tmp/tags"
map <C-r><C-t> :!bundle list --paths=true \| xargs ctags -f tmp/tags -R --exclude=.git --exclude=tmp --exclude=log --langmap="ruby:+.rake.builder.rjs" `pwd`/*<CR><CR>

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Kill escape delay
set timeoutlen=300 ttimeoutlen=0

"emacs-style line begin and end
imap <c-a> <c-o>^
imap <c-e> <c-o>$
nmap <S-Z><S-X> :q!<CR>

nmap ,, :RelatedOpenFile<CR>
nmap , :RelatedRunTest<CR>

nmap  :ACK<CR>
vnoremap  "hy:Ack <C-r>h<CR>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        exec ':e ' . new_name
        exec ':bd #'
        redraw!
    endif
endfunction
command! RenameFile :call RenameFile()

" Close buffer without closing window
function! BufClose()
  exec ':bp | bd #'
endfunction
command! BC :call BufClose()
cabbrev bc <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BC' : 'bc')<CR>
