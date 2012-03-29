let g:pathogen_disabled = []

call add(g:pathogen_disabled, 'vim-ruby-debugger')

call pathogen#infect()
call pathogen#helptags()

set clipboard=unnamed

"==================================================general settings
filetype plugin indent on
syntax on
syntax sync minlines=256
" set synmaxcol=250
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

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
set shell=/bin/zsh



"==================================================ruby specifig settings
compiler ruby
let ruby_fold=1



"==================================================look & feel
" colorscheme wombat256

" set background=light
" let g:soliarized_termcolors=256
" colorscheme solarized

colorscheme molokai

set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P
set laststatus=2    "always show statusbar
set showtabline=2   "always show tabs bar
set showmode
set showcmd
set number          "show line numbers
" " set nocursorline nocursorcolumn
" set cursorline
" hi CursorLine NONE ctermbg=237
set showmatch       "show matching braces
set ttyfast
set t_Co=256        "set 256 colors mode
set hlsearch        "highlight search matches
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



"==================================================plugins
" if exists(":Rdebugger")
  let g:ruby_debugger_progname = 'mvim'
  " let g:ruby_debugger_builtin_sender = 0
  " map <Leader>b  :call g:RubyDebugger.toggle_breakpoint()<CR>
  " map <Leader>ow  :call g:RubyDebugger.open_variables()<CR>
  " map <Leader>ob  :call g:RubyDebugger.open_breakpoints()<CR>
  " map <Leader>of  :call g:RubyDebugger.open_frames()<CR>
  " map <Leader>s  :call g:RubyDebugger.step()<CR>
  " map <Leader>f  :call g:RubyDebugger.finish()<CR>
  " map <Leader>o  :call g:RubyDebugger.next()<CR>
  " map <Leader>c  :call g:RubyDebugger.continue()<CR>
  " map <Leader>e  :call g:RubyDebugger.exit()<CR>
  " map <Leader>d  :call g:RubyDebugger.remove_breakpoints()<CR>
  let g:ruby_debugger_debug_mode=1
  " " let g:ruby_debugger_fast_sender = 1
  " let g:ruby_debugger_default_script = 'rails s -u'
" endif

" if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a> :Tabularize /=><CR>
  vmap <Leader>a> :Tabularize /=><CR>
  nmap <leader>a, :Tabularize /,/l0r1<CR>
" endif

" if exists(":CommandT")
  nmap <leader>ft :CommandTFlush<CR>
  nmap <Leader>t :CommandT<CR>
  let g:CommandTCancelMap=['<ESC>','<C-c>']
  let g:CommandTAcceptSelectionSplitMap=['<C-g>']
  if !has("gui_macvim")
    let g:CommandTSelectPrevMap=['<ESC>OA']
    let g:CommandTSelectNextMap=['<ESC>OB']
  endif
" endif

" if exists(":NERDTree")
  let g:NERDTreeWinSize = 40
  map <Leader>n :NERDTreeToggle<CR>
" endif

let g:no_turbux_mappings=1
nmap <leader>s <Plug>SendTestToTmux
nmap <leader>S <Plug>SendFocusedTestToTmux


"==================================================mappings
nmap <leader>ve :tabedit $MYVIMRC<CR>
nmap <leader>vge :tabedit ~/.gvimrc<CR>

"opt-shift-8
nnoremap ° :nohlsearch<CR>

if has("gui_macvim")
  inoremap <S-CR> <C-O>o
endif

inoremap ;; <C-O>A;
inoremap ,, <C-O>A,

if has("gui_macvim")
  nmap <C-Up> [e
  nmap <C-Down> ]e
  vmap <C-Up> [e`[V`]
  vmap <C-Down> ]e`[V`]
else
  nmap [A [e
  nmap [B ]e
  vmap [A [e`[V`]
  vmap [B ]e`[V`]
endif

nnoremap <Leader>ccc :s#_\(\l\)#\u\1#g

nnoremap <C-W>nt :call MoveToNextTab()<CR>
nnoremap <C-W>pr :call MoveToPrevTab()<CR>

"extract to 'before' block
vmap <Leader>bed "td?describe<CR>obefore(:each) do<CR>end<CR><ESC>kk"tp

"search and replace selected
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"find among ruby files
nnoremap <C-F>r :LAck! %s --type=ruby<CR>
nnoremap <C-F>j :LAck! %s --type=javascript<CR>

nmap \ls i<CR><ESC>

"==================================================other filetypes support
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

