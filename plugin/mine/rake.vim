if exists("loaded_vim_rake")
  finish
endif

let g:loaded_vim_rake = 1
let g:vim_rake_command = "rake"

function! s:VimRake(...)
  :exe ":!clear && ".g:vim_rake_command." ".join(a:000, " ")
endfunction

command! -nargs=? R :call <SID>VimRake(<f-args>)

finish


