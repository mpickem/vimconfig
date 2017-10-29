autocmd VimEnter * if &filetype == '' | setfiletype default | end
autocmd BufNewfile,BufRead * if &filetype == '' | setfiletype default | end
autocmd BufNewFile,BufRead *.gnu  setlocal filetype=gnuplot
autocmd BufNewFile,BufRead *.gp   setlocal filetype=gnuplot
