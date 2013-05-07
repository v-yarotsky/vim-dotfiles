if exists("loaded_askag")
  finish
endif

let g:loaded_askag = 1

let g:askag_latest_search = ""

function! s:AskAg()
  let ag_args = input("Search in project: ", g:askag_latest_search)

  if empty(ag_args)
    echo "Nothing to search for."
    return
  endif

  let g:askag_latest_search = ag_args

  echo "Searching for ".ag_args
  :exe "Ag! ".ag_args
endfunction

command! AG :call <SID>AskAg()

finish

