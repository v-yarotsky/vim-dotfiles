" Extract assignment to 'let' block
function! PromoteToLet()
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>l :PromoteToLet<cr>

" Quick hashrocket
imap <c-l> <space>=><space>

