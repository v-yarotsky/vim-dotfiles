let g:tinykeymaps_default = []
" let g:tinykeymap#show_message = 'statusline'
let g:tinykeymap#timeout = 500

if !exists('g:tinykeymap#map#windows#map')
    " Map leader for the "windows" tinykeymap.
    let g:tinykeymap#map#windows#map = "<C-W>"   "{{{2
endif


" Based on Andy Wokulas's windows mode for tinymode.
call tinykeymap#EnterMap("windows", g:tinykeymap#map#windows#map, {
            \ 'name': 'windows mode',
            \ 'message': 'winnr() .": ". bufname("%")'
            \ })
call tinykeymap#Map('windows', '<Right>', '5wincmd >', {'desc': 'Increase width'})
call tinykeymap#Map('windows', '<Left>', '5wincmd <', {'desc': 'Decrease width'})
call tinykeymap#Map('windows', '<Up>', 'resize +2', {'desc': 'Increase height'})
call tinykeymap#Map('windows', '<Down>', 'resize -2', {'desc': 'Decrease height'})
call tinykeymap#Map('windows', '=', 'wincmd =', {'desc': 'Make equally high and wide'})
