autocmd VimEnter * if &filetype == '' | setfiletype default | end
autocmd BufNewfile,BufRead * if &filetype == '' | setfiletype default | end
