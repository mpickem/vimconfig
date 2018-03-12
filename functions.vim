" function so toggle trailing whitespace highlighting
let g:whitespace = "1"
hi ExtraWhiteSpace ctermbg=9
function! ToggleWhiteSpace()
  if g:whitespace == "1"
    hi ExtraWhiteSpace ctermbg=235
    redraw
    let g:whitespace = "0"
  else
    hi ExtraWhiteSpace ctermbg=9
    redraw
    let g:whitespace = "1"
  endif
endfunction
