autocmd BufNewfile,BufRead * if expand('<afile>:e') == '' | setfiletype default | end
autocmd BufNewFile,BufRead *.gnu  setlocal filetype=gnuplot
autocmd BufNewFile,BufRead *.gp   setlocal filetype=gnuplot
