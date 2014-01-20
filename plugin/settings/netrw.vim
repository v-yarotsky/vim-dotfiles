let g:netrw_localrmdir="rm -r"
map <Leader>e :e <C-R>=expand("%:p:h") . "/"<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . "/"<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . "/"<CR>
