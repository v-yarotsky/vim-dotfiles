" if executable('ag')
"   " Use ag over grep
"   set grepprg=ag\ --nogroup\ --nocolor
"
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"   let g:ctrlp_use_caching = 0
" endif
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
