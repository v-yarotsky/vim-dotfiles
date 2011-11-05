set nocompatible
filetype off
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

set hidden
set showmode
set showcmd
set number          "show line numbers
set ruler           "show current position in status
set showmatch       "show matching braces
set laststatus=2    "always show statusbar
set showtabline=2   "always show tabs bar
set t_Co=256        "set 256 colors mode
set cursorline
hi CursorLine NONE ctermbg=236

set hlsearch        "highlight search matches
set backspace=indent,eol,start
set scrolloff=3
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set wildmenu
set wildmode=list:longest

set background=dark
colorscheme 256-grayvim
"highlight NonText guibg=black

set nobackup
set nowritebackup
set directory=$HOME/.vim/tmp/

set softtabstop=2
set shiftwidth=2
set expandtab

if exists(":CommandT")
  let g:CommandTCancelMap=['<ESC>','<C-c>']
  let g:CommandTAcceptSelectionSplitMap=['<C-g>']
  let g:CommandTSelectPrevMap=['<ESC>OA']
  let g:CommandTSelectNextMap=['<ESC>OB']
endif

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

map <C-h> <C-w>h "left window focus
map <C-j> <C-w>j "bottom window focus
map <C-k> <C-w>k "top window focus
map <C-l> <C-w>l "right window focus
nmap <leader>ve :tabedit $MYVIMRC<CR>
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

