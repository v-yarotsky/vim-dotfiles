function! SelectaBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')
  call SelectaCommand('echo "' . join(buffers, "\n") . '"', "", ":b")
endfunction

" Fuzzy select a buffer. Open the selected buffer with :b.
nnoremap <C-g> :call SelectaBuffer()<cr>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

let g:selecta_list_files_command = "git ls-files --other --cached --exclude-standard"

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <C-p> :call SelectaCommand(g:selecta_list_files_command, "", ":e")<cr>

" open gem dir in selecta
function! SelectaGem(gem_name)
  call SelectaCommand("bundle list '" . a:gem_name . "' | tr -d \"\n\"", "", ":e")
endfunction

command! -bang -nargs=* -complete=file Gem call SelectaGem(<q-args>)
