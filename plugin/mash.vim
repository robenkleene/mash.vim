" Args
command! -nargs=+ -bang -complete=shellcmd Pshargs call partshell#EditSh(<bang>0, <q-args>, 'args')

" Grep
command! -nargs=+ -bang -complete=shellcmd Pshgrep call partshell#GrepSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Pshlgrep call partshell#GrepSh(<bang>0, <q-args>, 1)

" Make
command! -nargs=+ -bang -complete=shellcmd Pshmake call partshell#MakeSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Pshlmake call partshell#MakeSh(<bang>0, <q-args>, 1)

" Splits
command! -nargs=+ -bang -complete=shellcmd Pshenew call partshell#Sh(<bang>0, <q-args>, 'enew')
command! -nargs=+ -bang -complete=shellcmd Pshnew call partshell#Sh(<bang>0, <q-args>, 'new')
command! -nargs=+ -bang -complete=shellcmd Pshtabnew call partshell#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Pshtabedit call partshell#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Pshvnew call partshell#Sh(<bang>0, <q-args>, 'vnew')
