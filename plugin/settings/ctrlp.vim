nmap <C-g> :CtrlPBuffer<CR>
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\.git$'
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" open gem dir in ctrlp
function! GemCtrlP(gem_name)
  let path = system('bundle list ' . a:gem_name . ' | tr -d "\n"')
  execute 'CtrlP ' . path
endfunction
command! -bang -nargs=* -complete=file Gem call GemCtrlP(<q-args>)
