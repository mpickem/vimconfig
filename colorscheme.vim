let s:black = { "gui": "#282c34", "cterm": "239", "cterm16": "8" }
let s:yellow = { "gui": "#61afef", "cterm": "226", "cterm16" : "011" }
let g:onedark_color_overrides = {
  \ "white":{"gui": "#000000", "cterm": "255", "cterm16": "15"},
  \}
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 0

colorscheme onedark

" Color changes overwriting the colorscheme basically
" let &colorcolumn="80" " mark 80th column ... apparently has to be after the settings
" hi colorcolumn ctermbg=235
hi MatchParen ctermbg=000 cterm=bold ctermfg=015
hi SignifySignAdd cterm=bold
hi SignifySignDelete cterm=bold ctermfg=196
hi SignifySignChange cterm=bold ctermfg=3
hi GitGutterChange cterm=bold ctermfg=3
hi GitGutterChangeDefault cterm=bold ctermfg=3
hi PreProc ctermfg=39
hi PreCondit ctermfg=39
hi CursorLineNr ctermfg=226 cterm=bold
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=46
hi SpellRare cterm=underline,bold ctermfg=46
hi SpellCap cterm=underline,bold ctermfg=46
hi Search cterm=underline,bold ctermfg=9 ctermbg=none
hi IncSearch cterm=bold ctermfg=82 ctermbg=16
hi LineNr ctermfg=240
