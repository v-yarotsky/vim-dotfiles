if exists("g:loaded_related")
  finish
endif

if !has("ruby")
  echohl ErrorMsg
  echon "Sorry, Related requires ruby support."
  finish
endif

let g:loaded_related = 1

ruby << EOF
  require 'pathname'

  def repo_root
    Pathname.new(`git rev-parse --show-toplevel`.chomp)
  end

  def current_file
    Pathname.new(VIM.evaluate("expand('%:p')"))
  end

  def current_file_relative_to_repo
    current_file.relative_path_from(repo_root)
  end

  class NoopFinder
    def source_for_test
      VIM.message("Don't know how to find source for test")
    end

    def test_for_source
      VIM.message("Don't know how to find test for source")
    end

    def is_test?
      VIM.message("Don't know whether it's test or source")
    end
  end

  class RspecFinder
    def source_for_test
      source_dir = current_file_relative_to_repo.sub(%r{^spec/}, "").dirname
      unless File.exists?(source_dir)
        source_dir = current_file_relative_to_repo.sub(%r{^spec/}, "app/").dirname
      end
      source_file = current_file_relative_to_repo.basename.sub(/_spec.rb$/, ".rb")
      File.join(repo_root, source_dir, source_file)
    end

    def test_for_source
      test_dir = current_file_relative_to_repo.sub(/^(app\/)?/, "spec/").dirname
      test_file = current_file_relative_to_repo.basename.sub(/\.rb$/, "_spec.rb")
      File.join(repo_root, test_dir, test_file)
    end

    def is_test?
      current_file.basename.to_s =~ %r{_spec\.rb$}
    end
  end

  class TestUnitFinder
    def source_for_test
      source_dir = current_file_relative_to_repo.sub(%r{^test/}, "").dirname
      source_file = current_file_relative_to_repo.basename.sub(/^test_/, "")
      File.join(repo_root, source_dir, source_file)
    end

    def test_for_source
      test_dir = current_file_relative_to_repo.sub(/^/, "test/").dirname
      test_file = current_file_relative_to_repo.basename.sub(/^/, "test_")
      File.join(repo_root, test_dir, test_file)
    end

    def is_test?
      current_file_relative_to_repo.basename.to_s =~ /^test_/
    end
  end

  def open_related_file
    related_file = finder.is_test? ? finder.source_for_test : finder.test_for_source
    VIM.command "silent :e #{related_file}"
  end

  def finder
    finder_class = if File.exists?(File.join(repo_root, "spec/"))
      RspecFinder
    elsif File.exists?(File.join(repo_root, "test/"))
      TestUnitFinder
    else
      NoopFinder
    end
    finder_class.new
  end
EOF

function! s:GetRelatedFile()
  :ruby open_related_file
endfunction

command! AC :call <SID>GetRelatedFile()

finish

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
