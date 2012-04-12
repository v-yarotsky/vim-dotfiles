"==================================================pathogen
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'vim-ruby-debugger')
call pathogen#infect()
call pathogen#helptags()

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
set directory=$HOME/.vim/tmp/

set softtabstop=2
set shiftwidth=2
set expandtab

set shell=/bin/zsh

set clipboard=unnamed

"==================================================ruby specifig settings
compiler ruby
let ruby_fold=1



"==================================================look & feel
colorscheme molokai

set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P
set laststatus=2    "always show statusbar
set showtabline=2   "always show tabs bar
set number          "show line numbers
set showmatch       "show matching braces
set ttyfast
set t_Co=256        "set 256 colors mode
set incsearch
set foldlevel=100
set backspace=indent,eol,start
set scrolloff=3
au InsertEnter * hi StatusLine term=reverse ctermbg=234
au InsertLeave * hi StatusLine term=reverse ctermbg=237

set wildmenu
set wildmode=list:longest
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.DS_Store?                      " OSX bullshit
set wildignore+=tmp/**
set wildignore+=log/**

"==================================================mappings
nmap <leader>ve :tabedit $MYVIMRC<CR>
nmap <leader>vge :tabedit ~/.gvimrc<CR>
nmap <leader>vr :source $MYVIMRC<CR>
nmap <leader>vgr :source ~/.gvimrc<CR>

nnoremap * :set hlsearch! hlsearch?<CR>

inoremap ;; <C-O>A;
inoremap ,, <C-O>A,

if has("gui_running")
  nmap <C-Up> [e
  nmap <C-Down> ]e
  vmap <C-Up> [e`[V`]
  vmap <C-Down> ]e`[V`]
else
  nmap [A [e
  nmap [B ]e
  vmap [A [e`[V`]
  vmap [B ]e`[V`]
end

"extract to 'before' block
vmap <Leader>bed "td?describe<CR>obefore(:each) do<CR>end<CR><ESC>kk"tp

"search and replace selected
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

nmap \ls i<CR><ESC>

"write file as sudo
cmap w!! w !sudo tee % >/dev/null



"==================================================plugins settings
for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor

