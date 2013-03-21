if exists("loaded_askack")
  finish
endif

let g:loaded_askack = 1

let g:askack_latest_search = ""

function! s:AskAck()
  let ack_args = input("Search in project: ", g:askack_latest_search)

  if empty(ack_args)
    echo "Nothing to search for."
    return
  endif

  let g:askack_latest_search = ack_args

  echo "Searching for ".ack_args
  :exe "Ack! ".ack_args
endfunction

command! ACK :call <SID>AskAck()

finish

