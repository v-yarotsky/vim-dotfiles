nmap <leader>ft :CommandTFlush<CR>
nmap <Leader>t :CommandT<CR>
let g:CommandTCancelMap=['<ESC>','<C-c>']
let g:CommandTAcceptSelectionSplitMap=['<C-g>']
if !has("gui_macvim")
  let g:CommandTSelectPrevMap=['<ESC>OA']
  let g:CommandTSelectNextMap=['<ESC>OB']
endif
