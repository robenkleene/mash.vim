" Args
command! -nargs=+ -bang -complete=shellcmd Bargs call mash#EditSh(<bang>0, <q-args>, 'args')

" Grep
command! -nargs=+ -bang -complete=shellcmd Bgrep call mash#GrepSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Blgrep call mash#GrepSh(<bang>0, <q-args>, 1)

" Make
command! -nargs=+ -bang -complete=shellcmd Bmake call mash#MakeSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Blmake call mash#MakeSh(<bang>0, <q-args>, 1)

" Splits
command! -nargs=+ -bang -complete=shellcmd Benew call mash#Sh(<bang>0, <q-args>, 'enew')
command! -nargs=+ -bang -complete=shellcmd Bnew call mash#Sh(<bang>0, <q-args>, 'new')
command! -nargs=+ -bang -complete=shellcmd Btabnew call mash#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Btabedit call mash#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Bvnew call mash#Sh(<bang>0, <q-args>, 'vnew')
