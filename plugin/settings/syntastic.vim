if ! has("gui_running")
  hi clear SpellBad
  hi SpellBad cterm=underline,bold ctermfg=red
endif

let g:syntastic_go_checkers = ["golint", "govet", "errcheck"]
let g:syntastic_javascript_checkers = ['eslint']
