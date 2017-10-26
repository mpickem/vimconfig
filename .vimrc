" vim:fdm=marker
" .vimrc maintained by Matthias Pickem

" summary of current leader shortcuts
" s -- easymotion single key
" d -- easymotion double keys
" hjkl - easymotion movement
" b -- fzf buffers
" t -- fzf tags
" w -- fzf windows
" space -- fzf lines in the current buffer

" summary of current control shortcuts
" n -- nerdtree
" p -- fzf
" l -- remove highlighting after search

" reminder: zR ... unfold everything; zm ... fold everything


" Plugins {{{

" vim-plug
" github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged') " directory for plugins

Plug 'vim-scripts/BufOnly.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " full fzf -- unix + vim wrapper
Plug 'junegunn/fzf.vim' " bundle of fzf-based commands in vim like :Tags, :Marks, : Windows etc
Plug 'vim-scripts/gnuplot.vim'
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
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Experimental Plugins
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentpython.vim'

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

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

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

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" TODO: find out prune command in order to completely avoid .git
" TODO: if ag is installed use that

if executable("ag")
  nnoremap <C-P> :call fzf#run(fzf#wrap({'source': 'ag -l --nocolor --hidden --nogroup
    \ --ignore-dir=.git
    \ --ignore="*.mod"
    \ --ignore="*.o"
    \ --ignore="*.tar"
    \ --ignore="*.zip"
    \ --ignore="*.jpg"
    \ --ignore="*.png"
    \ --ignore="*.so"
    \ --ignore="*.a"
    \ --ignore="*.swp"
    \ --ignore="*.eps"
    \ --ignore="*.pyc"
    \ '})) <CR>
else
  nnoremap <C-P> :call fzf#run(fzf#wrap({'source': 'find ./ -type f
    \ ! -name "*.mod"
    \ ! -name "*.o"
    \ ! -name "*.tar"
    \ ! -name "*.zip"
    \ ! -name "*.jpg"
    \ ! -name "*.png"
    \ ! -name "*.so"
    \ ! -name "*.a"
    \ ! -name "*.swp"
    \ ! -name "*.eps"
    \ ! -name "*.pyc"
    \ ! -path "./.git/*"
    \ '})) <CR>

endif


" nnoremap <C-P> :FZF<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader><space> :BLines<CR>
nnoremap <leader>w :Windows<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)

" }}}

" gitgutter configuration {{{

let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '••'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed = '•'

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

" Vim-notes configuration {{{

" instructions with :Note
" open note with ':edit note:xxxx' where xxxx is a re in the title
let g:notes_suffix='.txt'
" let g:notes_directories = ['~/Dropbox/shared Notes']
let g:notes_conceal_url=0

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
map <Leader>s <Plug>(easymotion-overwin-f)
map <Leader>d <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" }}}

" Targets.vim configuration {{{

let g:targets_aiAI = 'aiAI' " around inner
let g:targets_nlNL = 'nN  ' " next last -- e.g. cinB
let g:targets_pairs = '()b {}B [] <>' " allowed pairs
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
autocmd Colorscheme * call onedark#set_highlight("DiffChange", {"fg": s:yellow, "bg": s:black})
autocmd Colorscheme * call onedark#set_highlight("DiffText", {"bg": s:yellow, "fg": s:black})
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

set number " Display line numbers on the left (absolute)
set cursorline " Highlight current line you are on
set ruler " Display the cursor position

set laststatus=2 " Always display the status line, even if only one window is displayed
set noshowmode " Disable showing mode since its already displayed in lightline
set notimeout ttimeout ttimeoutlen=200 " Quickly time out on keycodes, but never time out on mappings
set showcmd " Show partial commands in the last line of the screen
set confirm " Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.

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

au VimResized * wincmd = " automatically resize splits if window size is changed

if isdirectory(expand("~/.vim/swapfiles/"))
  set directory^=~/.vim/swapfiles/ " if that folder exists, add this string in front of the directory variable == swap file directory
endif

let &colorcolumn="80" " mark 80th column ... apparently has to be after the settings
hi colorcolumn ctermbg=235
hi MatchParen ctermbg=000 cterm=bold ctermfg=015

" disable automatic comment insertion, intelligent comment line joining
autocmd BufNewFile,BufRead * setlocal formatoptions=jql

" }}}

" Personal key mappings {{{

" Use <F2> to toggle between 'paste' and 'nopaste' in INSERT MODE
set pastetoggle=<F2>
" Y to be consistent with D and C
map Y y$
" fold open / close with space
set foldlevelstart=-
nnoremap <Space> za
vnoremap <Space> za
" Ctrl L deactivates highlighting after a search
nnoremap <C-L> :nohl<CR><C-L>
" Allow saving of files as sudo when I forgot to start vim using sudo
cnoremap w!! w !sudo /usr/bin/tee > /dev/null %

" }}}

" Language specific settings {{{

" Language specific commands in the according .vim/ftplugin/***.vim file
" Language detection in .vim/ftdetect/mine.vim

" }}}
