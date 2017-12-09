if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=#\ %s
nnoremap <buffer> <Leader>r :vnew<CR>Ioutput of <C-R>#<Esc>:r!python #<CR><C-W><C-W>
nnoremap <buffer> <Leader>c <C-W><C-h>ZQ
nnoremap <buffer> <leader>q gg0I#! /usr/bin/env python<CR><CR>
  \from __future__ import print_function, division, absolute_import<CR>
  \import numpy as np<CR>
  \import matplotlib.pyplot as plt<CR>
  \import h5py<CR>
  \import sys<CR><CR>
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
" setlocal textwidth=79
setlocal foldmethod=indent
setlocal foldlevel=99
