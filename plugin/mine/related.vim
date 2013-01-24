" Open/Create related spec/file
function! s:CreateRelated()
  let related = s:GetRelatedFile(expand('%'))
  call s:Open(related)
endfunction

" Return the related filename
function! s:GetRelatedFile(file)
  if s:IsSpec(a:file)
    return s:ClosestSource(a:file)
  else
    return s:ClosestSpec(a:file)
  endif
endfunction

function! s:IsSpec(file)
  return match(a:file, '_spec\.rb$') != -1
endfunction

function! s:ClosestSource(spec)
  let l:unsuffixed = substitute(substitute(a:spec, "_spec.rb$", ".rb", ""), '^spec/', '', '')
  let l:files = split(system('find . -type f | sed s/\.\\/// | grep -v "^spec/" | grep -F "' . l:unsuffixed . '"'), "\n")
  return s:Result(l:files)
endfunction

function! s:ClosestSpec(file)
  let l:spec_guess = substitute(substitute(a:file, ".rb$", "_spec.rb", ""), "^app/", "", "")
  let l:files = split(system('find . -type f | sed s/\.\\/// | grep "^spec/" | grep -F "' . l:spec_guess . '"'), "\n")
  return s:Result(l:files)
endfunction

function! s:Result(matches)
  if len(a:matches) > 0
    echom a:matches[0]
    return a:matches[0]
  else
   return ""
  endif
endfunction

" Open the related file in a vsplit
function! s:Open(file)
  exec('e ' . a:file)
endfunction

" Register a new command `AC` for open/create a related file
command! AC :call <SID>CreateRelated()
