" vim:fdm=marker
" vim-plug
" github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged') " directory for plugins

Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim' " status line
Plug 'joshdick/onedark.vim' " colorscheme
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " full fzf -- unix + vim wrapper
Plug 'junegunn/fzf.vim' " bundle of fzf-based commands in vim like :Tags, :Marks, : Windows etc
Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow' " rainbow brackets
Plug 'michaeljsmith/vim-indent-object'
Plug 'tomasr/molokai' " colorscheme
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/BufOnly.vim' " close all buffers except current one :BufOnly
Plug 'vim-scripts/gnuplot.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'wellle/targets.vim' " improved target selection
Plug 'wincent/loupe' " improved search highlighting

" Experimental Plugins
Plug 'mbbill/undotree'

" Initialize plugin system
call plug#end()

" fzf {{{

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'

nnoremap <leader>a :Ag<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GitFiles<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader><space> :BLines<CR>
nnoremap <F1> :Helptags<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-k> <plug>(fzf-complete-buffer-line)

" }}}

" gitgutter {{{

nnoremap <Leader>j :GitGutterNextHunk<CR>zz
nnoremap <Leader>k :GitGutterPrevHunk<CR>zz
nmap <Leader>J G<Leader>kzz
nmap <Leader>K gg<Leader>jzz
nnoremap <Leader>< :GitGutterStageHunk<CR>
nnoremap <Leader>> :GitGutterUndoHunk<CR>

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '>-'

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_map_keys = 0 " just use it for the display of changed things

" }}}

" Rainbow parenthesis {{{

let g:rainbow_active = 1
let g:rainbow_conf = {
  \ 'ctermfgs': ['red', 'cyan', 'yellow'],
  \ 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
  \}

" }}}

" Light-line {{{

" collapses ff,ft,fe,mode if horizontal window size is too small
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'mode': 'LightlineMode',
  \   'gitbranch': 'LightlineGit',
  \ },
  \ 'colorscheme': 'one'
  \ }

function! LightlineFilename()
  return expand('%')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineGit()
  return winwidth(0) > 60 ? fugitive#head() : ''
endfunction

" }}}

" EasyMotion {{{

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'asdfghjklqwertzuiopyxcvbnm,'
let g:EasyMotion_startofline = 1 " keep cursor column when JK motion

" map <Leader>s <Plug>(easymotion-overwin-f)
" map <Leader>d <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>d <Plug>(easymotion-sn)
" map n <Plug>(easymotion-next)
" map N <Plug>(easymotion-prev)

" }}}

" Targets.vim {{{

let g:targets_aiAI = 'aiAI' " around inner
let g:targets_nlNL = 'nN  ' " next last -- e.g. cinB
let g:targets_pairs = '()b {}c []B <>' " bracket, curly, Bracket
let g:targets_quotes = '" '' `' " allowed quotes
let g:targets_seperator = ', . ; : + - = ~ * # / | \ & $' " allowed separators
let g:targets_tagTrigger = 't' " tag = t
let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'
let g:targets_argTrigger = 'a' " argument = a
let g:targets_argSeparator = ',' " arguments are only those which are separated by ,
let g:targets_seekRanges = 'cr cb cB lc ac Ac lr rr ll' " only considers targets fully contained in current line

" }}}

" Fugitive {{{

autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}

" EasyAlign {{{

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ 'd': {
\     'pattern':      '::',
\     'left_margin':  1,
\     'right_margin': 1,
\			'stick_to_left': 0
\   },
\ '#': {
\     'pattern': '#'
\   },
\ '!': {
\     'pattern': '!'
\   },
\ '"': {
\     'pattern': '"'
\   }
\ }

" }}}

" {{{ Undotree

nnoremap <F10> :UndotreeToggle<CR>

"}}}

" {{{ Whitespace

nnoremap <Leader>zz :FixWhitespace<CR>

" }}}
