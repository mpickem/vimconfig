if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=#\ %s
nnoremap <buffer> <Leader>r :vnew<CR>Ioutput of <C-R>#<Esc>:r!python #<CR><C-W><C-W>
nnoremap <buffer> <Leader>c <C-W><C-h>ZQ
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
" setlocal textwidth=79
setlocal foldmethod=indent
setlocal foldlevel=99
