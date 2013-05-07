let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 40
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
