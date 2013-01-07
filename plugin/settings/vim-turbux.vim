function! ScopeFileToRepoRoot()
ruby << EOF
  require 'pathname'
  file = VIM::evaluate('expand("%")')
  paths = ["."]
  Pathname.new(file.to_s).dirname.ascend { |p| paths.unshift(p.to_s) && break if p.entries.map(&:to_s).include?(".git") }
  file = paths.first.gsub(paths.first, '').gsub(/^\//, '')
  VIM::command("return #{file.inspect}")
EOF
endfunction

function! ClosestRepo()
ruby << EOF
  require 'pathname'
  file = VIM::evaluate('expand("%")')
  paths = ["."]
  Pathname.new(file.to_s).dirname.ascend { |p| paths.unshift(p.to_s) && break if p.entries.map(&:to_s).include?(".git") }
  VIM::command("return #{paths.first.inspect}")
EOF
endfunction

"let g:turbux_command_prefix = "bundle exec"
let g:no_turbux_mappings=1
nmap <leader>s <Plug>SendTestToTmux
nmap <leader>S <Plug>SendFocusedTestToTmux

