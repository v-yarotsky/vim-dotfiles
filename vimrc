"==================================================vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'bufkill.vim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rake'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'commentary.vim'
Bundle 'ctrlp.vim'
Bundle 'fugitive.vim'
Bundle 'gitignore'
Bundle 'go.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'matchit.zip'
Bundle 'noprompt/vim-yardoc'
Bundle 'rails.vim'
Bundle 'repeat.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'rizzatti/funcoo.vim'
Bundle 'ack.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'Simple-Javascript-Indenter'
Bundle 'slim-template/vim-slim.git'
Bundle 'splitjoin.vim'
Bundle 'SuperTab'
Bundle 'surround.vim'
Bundle 'Tabular'
Bundle 'textobj-rubyblock'
Bundle 'textobj-user'
Bundle 'tinykeymap'
Bundle 'tlib'
Bundle 'UltiSnips'
Bundle 'unimpaired.vim'
Bundle 'vim-coffee-script'

Bundle 'file:///Users/v-yarotsky/Projects/askag.vim'
Bundle 'file:///Users/v-yarotsky/Projects/related.vim'
Bundle 'file:///Users/v-yarotsky/Projects/simple-rake.vim'

"==================================================general settings
filetype plugin indent on
syntax on
syntax sync minlines=256
set nocompatible
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
set expandtab

set shell=/bin/sh
set grepprg=ack

set clipboard=unnamed

"==================================================ruby specifig settings
compiler ruby
let ruby_fold=1



"==================================================look & feel
set background=dark
let g:solarzed_termcolors=16
colorscheme Tomorrow-Night

set laststatus=2    "always show statusbar
set showtabline=0   "always show tabs bar
set number          "show line numbers
set relativenumber  "show line numbers relative to current
set showmatch       "show matching braces
set ttyfast
set t_Co=256        "set 256 colors mode
set incsearch       "turn on incremental search
set foldlevel=100
set backspace=indent,eol,start
set scrolloff=3
au InsertEnter * hi StatusLine term=reverse ctermbg=234
au InsertLeave * hi StatusLine term=reverse ctermbg=237

set wildmenu
set wildmode=longest,list
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.DS_Store,doc/**,tmp/**,log/**

" set completeopt=longest,menuone

set lazyredraw
set shiftround

"==================================================mappings
command! WQ wq
command! Wq wq
command! W w
command! Q q

nmap <leader>ve :tabedit $MYVIMRC<CR>
nmap <leader>vr :source $MYVIMRC<CR>

nnoremap t* :set hlsearch! hlsearch?<CR>

if has("gui_running")
  nmap <C-Up> [e
  nmap <C-Down> ]e
  vmap <C-Up> [e`[V`]
  vmap <C-Down> ]e`[V`]
else
  map <Esc>[B <Down>
  nmap [A [e
  nmap [B ]e
  vmap [A [e`[V`]
  vmap [B ]e`[V`]
end


"search and replace selected
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"write file as sudo
cmap w!! w !sudo tee % >&-<CR>



"==================================================gui settings
if has("gui_running")
  colorscheme Tomorrow-Night

  set guicursor=a:blinkon0
  set guifont=Menlo\ Regular\ for\ Powerline:h12
  set guioptions-=r
  set guioptions-=T
  set guioptions-=L

  inoremap <S-CR> <C-O>o
endif

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

nnoremap <cr> :nohlsearch<cr>

"emacs-style line begin and end
imap <c-a> <c-o>^
imap <c-e> <c-o>$
nmap <S-Z><S-X> :q!<CR>

nmap ,, :RelatedOpenFile<CR>
nmap , :RelatedRunTest<CR>

let g:agprg="ag --nogroup --column --skip-vcs-ignores"
nmap  :AG<CR>
vnoremap  "hy:Ag! <C-r>h<CR>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        exec ':Bclose'
        exec ':e ' . new_name
        redraw!
    endif
endfunction
command! RenameFile :call RenameFile()

"Paste nicely
map <leader>p :set paste<CR>o<ESC>"*]p:set nopaste<CR>

"Auto-resize focused/unfocused splits

set winwidth=84
set winminwidth=24
set winheight=5
set winminheight=5
set winheight=999
