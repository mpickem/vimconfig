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

function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    :e %:t:r.h
  else
    :e %:t:r.cpp
  endif
endfunction

function! VsplitSourceHeader()
  if (expand ("%:e") == "cpp")
    set splitright
    :vsplit %:t:r.h
    set nosplitright
  else
    :vsplit %:t:r.cpp
  endif
endfunction

function! SplitSourceHeader()
  if (expand ("%:e") == "cpp")
    :split %:t:r.h
  else
    :split %:t:r.cpp
  endif
endfunction
