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
set noswapfile
set dir=$HOME/.vim/tmp/

set softtabstop=2
set shiftwidth=2
set expandtab

set shell=/bin/zsh
set grepprg=ack

set clipboard=unnamed

"==================================================ruby specifig settings
compiler ruby
let ruby_fold=1



"==================================================look & feel
if $ITERM_PROFILE ==? "Solarized"
  set background=light
  let g:soliarized_termcolors=256
  colorscheme solarized
elseif $ITERM_PROFILE ==? "Darkspectrum"
  colorscheme darkspectrum
else
  colorscheme molokai
endif

" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P
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
set wildmode=longest,list
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.DS_Store?                      " OSX bullshit
set wildignore+=tmp/**
set wildignore+=log/**

" set completeopt=longest,menuone

set lazyredraw
set shiftround

"==================================================mappings
command WQ wq
command Wq wq
command W w
command Q q

cnoreabbrev tx tabclose
cnoreabbrev tc tabnew

nmap <leader>ve :tabedit $MYVIMRC<CR>
nmap <leader>vr :source $MYVIMRC<CR>

nnoremap t* :set hlsearch! hlsearch?<CR>

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


"search and replace selected
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"split line
nmap \ls i<CR><ESC>

"write file as sudo
cmap w!! w !sudo tee % > /dev/null



"==================================================gui settings
if has("gui_running")
  set background=light
  let g:soliarized_termcolors=256
  colorscheme solarized

  set guicursor=a:blinkon0
  set guifont=Consolas\ for\ Powerline:h12
  set guioptions-=r
  set guioptions-=T
  set guioptions-=L

  " set cursorline

  map <C-j> :tabprevious<CR>
  map <C-k> :tabnext<CR>

  inoremap <S-CR> <C-O>o
endif

"==================================================plugins settings
for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor

set tags += "tmp/tags"
map <C-r><C-t> :!bundle list --paths=true \| xargs ctags -f tmp/tags -R --exclude=.git --exclude=.tmp --exclude=log --langmap="ruby:+.rake.builder.rjs" `pwd`/*<CR><CR>

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

" Indent-Autocomplete on Tab
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

nnoremap <cr> :nohlsearch

"emacs-style line begin and end
imap <c-a> <c-o>^
imap <c-e> <c-o>$

" Russian keymap FTW; switch with C-^
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

nmap <S-Z><S-X> :q!
