if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=#\ %s
nnoremap <buffer> <leader>q gg0I#! /bin/bash<CR><CR>
nnoremap <buffer> <Leader>r :vnew<CR>!!bash #<CR><C-W><C-W>
nnoremap <buffer> <Leader>c <C-W><C-h>ZQ
