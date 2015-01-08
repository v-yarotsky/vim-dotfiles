function! ToggleGutter()
  set invrelativenumber
  set invnumber
  :GitGutterToggle
endfunction

command ToggleGutter :call ToggleGutter()
