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
    Pathname.new(`cd #{current_file.dirname} && git rev-parse --show-toplevel`.chomp)
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

    def run_test(*)
      VIM.message("Don't know how to run related test")
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

    def run_test(test_file)
      VIM.command ":!clear && cd #{repo_root} && rspec #{test_file}"
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

    def run_test(test_file)
      VIM.command ":!clear && cd #{repo_root} && ruby -Itest #{test_file}"
    end
  end

  def open_related_file
    related_file = finder.is_test? ? finder.source_for_test : finder.test_for_source
    VIM.command "silent :e #{related_file}"
  end

  def run_test
    test_file = finder.is_test? ? current_file_relative_to_repo : finder.test_for_source
    finder.run_test(test_file)
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

function! s:RunRelatedTest()
  :ruby run_test
endfunction

command! RelatedOpenFile :call <SID>GetRelatedFile()
command! RelatedRunTest  :call <SID>RunRelatedTest()

finish

