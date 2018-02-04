" vim:fdm=marker
" .vimrc maintained by Matthias Pickem

" summary of current leader shortcuts
" s -- easymotion single key
" d -- easymotion double keys
" hl - easymotion inline movement

" j -- GitGutter next Hunk
" J -- GitGutter last Hunk
" k -- GitGutter prev Hunk
" K -- GitGutter first Hunk
" < -- GitGutter stage Hunk
" > -- GitGutter undo Hunk

" a -- fzf Ag
" b -- fzf buffers
" f -- fzf files
" g -- fzf git files
" m -- fzf marks
" t -- fzf tags
" space -- fzf lines in the current buffer

" w -- toggle whitespace highlighting

" summary of current control shortcuts
" n -- nerdtree
" l -- remove highlighting after search


" Plugins {{{

" vim-plug
" github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged') " directory for plugins

Plug 'vim-scripts/BufOnly.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " full fzf -- unix + vim wrapper
Plug 'junegunn/fzf.vim' " bundle of fzf-based commands in vim like :Tags, :Marks, : Windows etc
Plug 'vim-scripts/gnuplot.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdtree' ", { 'on': 'NERDTreeToggle' }
Plug 'joshdick/onedark.vim'
Plug 'luochen1990/rainbow'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Experimental Plugins
Plug 'bronson/vim-trailing-whitespace'

" Initialize plugin system
call plug#end()

" }}}

" Mapleader {{{

" for personal commands use <leader>
let mapleader = "ö"

" }}}

" NERDTree configuration {{{

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" automatically close tab if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-N> :NERDTreeToggle<CR>

" }}}

" fzf configuration {{{

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
" nnoremap <leader>w :Windows<CR>
nnoremap <leader><space> :BLines<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-k> <plug>(fzf-complete-buffer-line)

" }}}

" gitgutter configuration {{{

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

" Rainbow parenthesis configuration {{{

let g:rainbow_active = 1
let g:rainbow_conf = {
  \ 'ctermfgs': ['red', 'cyan', 'yellow'],
  \ 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
  \}

" }}}

" Light-line configuration {{{

" collapes ff,ft,fe,mode if horizontal window size is too small
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'mode': 'LightlineMode',
  \   'gitbranch': 'LightlineGit',
  \ },
  \ }

      " \ 'colorscheme': 'onedark',
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

" EasyMotion configuration {{{

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'asdfghjklqwertzuiopyxcvbnm,'
let g:EasyMotion_startofline = 1 " keep cursor column when JK motion

map <Leader>s <Plug>(easymotion-f)
map <Leader>d <Plug>(easymotion-f2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

" }}}

" Targets.vim configuration {{{

let g:targets_aiAI = 'aiAI' " around inner
let g:targets_nlNL = 'nN  ' " next last -- e.g. cinB
let g:targets_pairs = '()b {}c []B <>' " bracket, curly, Bracket
let g:targets_quotes = '" '' `' " allowed quotes
let g:targets_seperator = ', . ; : + - = ~ * # / | \ & $' " allowed seperators
let g:targets_tagTrigger = 't' " tag = t
let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'
let g:targets_argTrigger = 'a' " argument = a
let g:targets_argSeparator = ',' " arguments are only those which are seperated by ,
let g:targets_seekRanges = 'cr cb cB lc ac Ac lr rr ll' " only considers targets fully contained in current line

" }}}

" Fugitive configuration {{{

autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}

" EasyAlign configuration {{{

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ 'd': {
\     'pattern':      '::',
\     'left_margin':  1,
\     'right_margin': 1,
\			'stick_to_left': 0
\   }
\ }

" }}}

" Colorscheme {{{

" colorscheme molokai
" let g:molokai_original=1
" autocmd ColorScheme * highlight Visual ctermbg=245

let s:black = { "gui": "#282c34", "cterm": "239", "cterm16": "8" }
let s:yellow = { "gui": "#61afef", "cterm": "226", "cterm16" : "011" }
let g:onedark_color_overrides = {
  \ "white":{"gui": "#000000", "cterm": "255", "cterm16": "15"},
  \}
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 0

colorscheme onedark
set t_Co=256 " 256 colors terminal
set t_ut=    " necessary for tmux (disabling Background Clear Erase BCE)

" }}}

" Vi IMproved settings {{{

set nocompatible " compatible mode deactivates all enhancements and improvements of VIM
filetype plugin on
filetype indent off
syntax enable " Enable syntax highlighting
set encoding=utf-8

set number relativenumber " Display line numbers on the left (relative)
set cursorline " Highlight current line you are on
set ruler " Display the cursor position

set laststatus=2 " Always display the status line, even if only one window is displayed
set noshowmode " Disable showing mode since its already displayed in lightline
set notimeout ttimeout ttimeoutlen=200 " Quickly time out on keycodes, but never time out on mappings
set showcmd " Show partial commands in the last line of the screen
set confirm " Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set hidden " Possibility to have more than one unsaved buffer

set wildmenu " Better command-line completion
set wildmode=longest,list,full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.png,*.jpg,*.o,*.mod,*.tar,*.eps,*.pyc

set hlsearch " highlight search results
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase
set incsearch " start the search while typing the first character

set ttyfast " fast scrolling (usually already enabled on most terminals)
set scrolloff=5 " start scrolling at 5 lines left on the screen

set visualbell " No Flashing or beeping
set t_vb=

set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert
set autoindent " When opening a new line and no filetype-specific indenting is enabled, keep the same indent as the line you're currently on.
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set nrformats-=octal " do not increment octal numbers (start with 0 - eg. 0647)
set tags=./tags,./TAGS,tags,TAGS,tags;$HOME,TAGS;$HOME
set lazyredraw " only rerender at the end of the macro
set matchpairs+=<:> " include <:> to matchpairs

if isdirectory(expand("~/.vim/swapfiles/"))
  set directory^=~/.vim/swapfiles/ " if that folder exists, add this string in front of the directory variable == swap file directory
endif

" Color changes overwriting the colorscheme basically
let &colorcolumn="80" " mark 80th column ... apparently has to be after the settings
hi colorcolumn ctermbg=235
hi MatchParen ctermbg=000 cterm=bold ctermfg=015
hi SignifySignAdd cterm=bold
hi SignifySignDelete cterm=bold ctermfg=196
hi SignifySignChange cterm=bold ctermfg=3
hi GitGutterChange cterm=bold ctermfg=3
hi GitGutterChangeDefault cterm=bold ctermfg=3
hi PreProc ctermfg=39
hi PreCondit ctermfg=39
hi CursorLineNr ctermfg=226 cterm=bold

" autocommands
autocmd VimResized * wincmd = " automatically resize splits if window size is changed

" disable automatic comment insertion, intelligent comment line joining
autocmd BufNewFile,BufRead * setlocal formatoptions=jql

augroup numbertoggle
  autocmd!
  autocmd WinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd WinLeave,BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let g:whitespace = "1" " default: we show whitespaces
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

noremap <Leader>w :call ToggleWhiteSpace()<CR>

" }}}

" Non-plugin key mappings {{{

" Use <F2> to toggle between 'paste' and 'nopaste' in INSERT MODE
" F1 -- help
" F2 -- pastetoggle
set pastetoggle=<F2>
" F3 -- turn off/on linenumbers
nnoremap <F3> :set relativenumber!<CR> :set number!<CR>
" Y to be consistent with D and C
map Y y$
" Disable Q, since I accidently press it too often
map Q <Nop>
" fold open / close with space
set foldlevelstart=-
nnoremap <Space> za
vnoremap <Space> za
" Ctrl L deactivates highlighting after a search
nnoremap <C-L> :nohl<CR><C-L>
" Allow saving of files as sudo when I forgot to start vim using sudo
cnoremap w!! w !sudo /usr/bin/tee > /dev/null %
" LineScrolling makes this way more sense (to me)
nnoremap <C-J> <C-E>
nnoremap <C-K> <C-Y>
inoremap <leader><leader>t <C-R>=strftime('%d %b %Y %X %Z')<CR>

" }}}

" Language specific settings {{{

" Language specific commands in the according .vim/ftplugin/***.vim file
" Language detection in .vim/ftdetect/mine.vim
