" Args
command! -nargs=+ -bang -complete=shellcmd Pshargs call mash#EditSh(<bang>0, <q-args>, 'args')

" Grep
command! -nargs=+ -bang -complete=shellcmd Pshgrep call mash#GrepSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Pshlgrep call mash#GrepSh(<bang>0, <q-args>, 1)

" Make
command! -nargs=+ -bang -complete=shellcmd Pshmake call mash#MakeSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Pshlmake call mash#MakeSh(<bang>0, <q-args>, 1)

" Splits
command! -nargs=+ -bang -complete=shellcmd Pshenew call mash#Sh(<bang>0, <q-args>, 'enew')
command! -nargs=+ -bang -complete=shellcmd Pshnew call mash#Sh(<bang>0, <q-args>, 'new')
command! -nargs=+ -bang -complete=shellcmd Pshtabnew call mash#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Pshtabedit call mash#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Pshvnew call mash#Sh(<bang>0, <q-args>, 'vnew')
