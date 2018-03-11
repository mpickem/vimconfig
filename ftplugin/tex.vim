if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=%\ %s
setlocal shellcmdflag=-ic
nnoremap <buffer> <Leader>r :vnew<CR>!!texmk #<CR>G<C-W><C-W>
nnoremap <buffer> <Leader>c <C-W><C-h>ZQ
setlocal spell
setlocal spelllang=en_us
