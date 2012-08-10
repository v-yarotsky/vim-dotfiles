nmap <Leader>ft :CtrlPClearCache<CR>
nmap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 2
" let g:ctrlp_user_command = 'find %s -type f -type d \( ! -name .git -prune \) -o \( ! -name tmp \)'  
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = '\.git$'
