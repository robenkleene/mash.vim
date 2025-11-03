" Args
command! -nargs=+ -bang -complete=shellcmd Shargs call mash#EditSh(<bang>0, <q-args>, 'args')

" Grep
command! -nargs=+ -bang -complete=shellcmd Shgrep call mash#GrepSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Shlgrep call mash#GrepSh(<bang>0, <q-args>, 1)

" Make
command! -nargs=+ -bang -complete=shellcmd Shmake call mash#MakeSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Shlmake call mash#MakeSh(<bang>0, <q-args>, 1)

" Splits
command! -nargs=+ -bang -complete=shellcmd Shenew call mash#Sh(<bang>0, <q-args>, 'enew')
command! -nargs=+ -bang -complete=shellcmd Shnew call mash#Sh(<bang>0, <q-args>, 'new')
command! -nargs=+ -bang -complete=shellcmd Shtabnew call mash#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Shtabedit call mash#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Shvnew call mash#Sh(<bang>0, <q-args>, 'vnew')
