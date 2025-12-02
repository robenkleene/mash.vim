function! mash#EditSh(bang, cmd, edit) abort
  let l:tmpfile = tempname()
  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  execute '!' . l:cmd . ' | tee ' . l:tmpfile
  if !filereadable(l:tmpfile)
    return
  endif
  let l:result = readfile(l:tmpfile)
  call delete(l:tmpfile)
  if empty(l:result)
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  let l:args_list = join(l:escaped_files, ' ')
  execute a:edit.(a:bang ? '!':'').' '.l:args_list
endfunction

function! mash#GrepSh(bang, cmd, location) abort
  if exists('*getcmdwintype') && !empty(getcmdwintype())
    echohl ErrorMsg | echomsg "Not valid in command-line window" | echohl None
    return
  endif

  let l:original_grepprg = &grepprg
  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  let &grepprg=l:cmd
  if a:location
    execute 'lgrep'.(a:bang ? '!':'')
  else
    execute 'grep'.(a:bang ? '!':'')
  endif
  let &grepprg = l:original_grepprg
endfunction

function! mash#MakeSh(bang, cmd, location) abort
  if exists('*getcmdwintype') && !empty(getcmdwintype())
    echohl ErrorMsg | echomsg "Not valid in command-line window" | echohl None
    return
  endif
  let l:original_makeprg = &makeprg
  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  let &makeprg = l:cmd
  if a:location
    execute "lmake".(a:bang ? '!':'')
  else
    execute "make".(a:bang ? '!':'')
  endif
  let &makeprg = l:original_makeprg
endfunction

function! mash#Sh(bang, cmd, split, wipe = v:false) abort
  if exists('*getcmdwintype') && !empty(getcmdwintype())
    echohl ErrorMsg | echomsg "Not valid in command-line window" | echohl None
    return
  endif

  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  let l:basename = fnameescape(a:cmd)

  if !a:bang || bufwinnr(l:basename) < 0
    execute 'noautocmd keepjumps '.a:split
  endif
  " Reset undo for this buffer
  let l:oldundolevels=&undolevels
  setlocal undolevels=-1
  let l:bufnr = bufnr(l:basename)

  " If there's an existing buffer with this name and bang is true, delete it
  if a:bang && l:bufnr > 0
    execute 'buffer '.l:bufnr
    noautocmd keepjumps enew
    bd#
  endif
  execute 'silent! 0r !'.l:cmd
  norm Gddgg

  filetype detect
  " Do naming after file type detect, this allows `ftplugin` to check
  " `eval('@%')` to see if this buffer is backed by a file before adding a
  " name
  for l:i in range(1, 9)
    " Wrap `file` in a try-catch to suppress errors if the name already exists
    " (The buffer will continue to show up as `[No Name]`)
    try
      execute 'silent file '.l:basename.(i > 1 ? ' '.l:i : '')
      break
    catch
    endtry
  endfor
  if a:bang
    setlocal buftype=nofile readonly nomodifiable
  endif
  if a:wipe
    setlocal bufhidden=wipe buftype=nofile
  endif
  let &l:undolevels=l:oldundolevels
endfunction

function! mash#Make(cmd, label) abort
  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  let l:result = system(l:cmd)
  if v:shell_error != 0
    echohl ErrorMsg | echomsg "Non-zero exit status for ".a:label." command: ".l:cmd | echohl None
    return
  endif
  cexpr l:result
  if getqflist()->empty()
    echohl WarningMsg | echomsg "No matches for ".a:label." command: ".l:cmd | echohl None
    return
  endif
  cwindow
  wincmd k
endfunction

function! mash#Lmake(cmd, label) abort
  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  let l:result = system(l:cmd)
  if v:shell_error != 0
    echohl ErrorMsg | echomsg "Non-zero exit status for ".a:label." command: ".l:cmd | echohl None
    return
  endif
  lexpr l:result
  if getloclist(0)->empty()
    echohl WarningMsg | echomsg "No matches for ".a:label." command: ".l:cmd | echohl None
    return
  endif
  lwindow
  wincmd k
endfunction

function! mash#Args(bang, cmd) abort
  let l:cmd = substitute(a:cmd, '\\', "\x01", 'g')
  let l:cmd = expandcmd(l:cmd)
  let l:cmd = substitute(l:cmd, "\x01", '\\', 'g')
  let l:result = systemlist(l:cmd)
  if v:shell_error != 0
    echohl ErrorMsg | echomsg "Non-zero exit status for Find command: ".l:cmd | echohl None
    return
  endif
  let l:escaped_files = map(l:result, {_, v -> fnameescape(v)})
  if l:escaped_files->empty()
    echohl WarningMsg | echomsg "No files found for Find command: ".l:cmd | echohl None
    return
  endif
  let l:args_list = join(l:escaped_files, ' ')
  execute "args".(a:bang ? '!':'').' '.l:args_list
endfunction
