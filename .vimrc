" Vim-plug setup
" Info at https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/gnuplot.vim'
Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'joshdick/onedark.vim'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'


" Initialize plugin system
call plug#end()


" for personal commands use <leader>
let mapleader = "-"


" NERDTree
" looks
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" automatically close tab if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open NERDTree with Ctrl n
nnoremap <C-N> :NERDTreeToggle<CR>


" CtrlP
" start in regexp and filename search rd>
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1
" show hidden files in searches
let g:ctrlp_show_hidden = 1
" working directory = where vim was started
"__ let g:ctrlp_working_path_mode = 0
" working directory = until .ctrlp is found
" otherwise until predefined folder are found (e.g. .git)
let g:ctrlp_root_markers = ['.ctrlp']
" jump to file instead of opening a new instance
let g:ctrlp_switch_buffer = 'Et'
" ignore .git
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" The Silver Searcher
" sudo apt-get install silversearcher-ag
if executable("ag")
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup  -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" rainbow parenthesis
let g:rainbow_active = 1
let g:rainbow_conf = {
\ 'ctermfgs': ['red', 'cyan', 'yellow'],
\ 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
\}


" vim-notes
" instructions with :Note
" open note with ':edit note:xxxx' where xxxx is a re in the title
let g:notes_suffix='.txt'
" let g:notes_directories = ['~/Dropbox/shared Notes']
let g:notes_conceal_url=0


" light-line configuration
" collapes ff,ft,fe,mode if horizontal window size is too small
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'filencoding', 'filetype' ] ]
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


" EasyMotion configuration
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
map <Leader>s <Plug>(easymotion-overwin-f)
map <Leader>t <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>w <Plug>(easymotion-overwin-w)


" colorscheme
" colorscheme molokai
" let g:molokai_original=1
" autocmd ColorScheme * highlight Visual ctermbg=245

let g:onedark_color_overrides = {
  \ "white":{"gui": "#000000", "cterm": "255", "cterm16": "15"},
  \}
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 0
colorscheme onedark



" Vi IMproved - standard settings
" compatible mode deactivates all enhancements and improvements of VIM
set nocompatible
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin on
filetype indent off
" Enable syntax highlighting
syntax enable
" Disable showing mode since its already displayed in lightline
set noshowmode
" Better command-line completion
set wildmenu
set wildmode=longest,list,full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.png,*.jpg
" Show partial commands in the last line of the screen
set showcmd
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below
set hlsearch
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" start the search while typing the first character
set incsearch
" Allow backspacing over autoindent, line breaks and start of insert
set backspace=indent,eol,start
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
" Always display the status line, even if only one window is displayed
set laststatus=2
" standard encoding
set encoding=utf-8
" start scrolling at 5 lines left on the screen
set scrolloff=5
" terminal 256 colors
set t_Co=256
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
" Enable use of the mouse for all modes (disabled because it gets in the way)
"__ set mouse=a
" Display line numbers on the left (absolute)
set number
" highlight current line you are on
set cursorline
" fast scrolling (usually already enabled on most terminals)
set ttyfast
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" Indentation settings for using tabs
" HARD TABS (Tabs as characters)
"__  set shiftwidth=2
"__  set tabstop=2
" SOFT TABS (Tabs will be expanded as spaces)
" if this is used and a file is opened with tab characters - :retab to convert
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
" for disabling Background Clear Erase (BCE)
" this is necessary to get the proper background in tmux
set t_ut=
" Use <F2> to toggle between 'paste' and 'nopaste' in INSERT MODE
set pastetoggle=<F2>
" Disable these stupid matching parenthesis which only clutter the screen
" au VimEnter * NoMatchParen
" do not increment octal numbers (start with 0 - eg. 0647)
set nrformats-=octal
hi MatchParen ctermbg=000 cterm=bold ctermfg=015


" key mappings
" Y to be consistent with D and C
map Y y$
" fold open / close with space
set foldlevelstart=-
nnoremap <Space> za
vnoremap <Space> za
" to prevent typos
cnoremap WQ wq
cnoremap Wq wq
cnoremap W w
cnoremap Q q
" Ctrl L deactivates highlighting after a search
nnoremap <C-L> :nohl<CR><C-L>
" <CR> ... Carriage Return ... same as <Return> and <Enter>
" stty -ixon  is required in the bashrc file to disable flow control

" Allow saving of files as sudo when I forgot to start vim using sudo
" :w!! ... opens tee as sudo ... throws away standard output and writes to
" current file (%)
" use explicit paths to prevent PATH-modification attacks
cnoremap w!! w !sudo /usr/bin/tee > /dev/null %
cnoremap W!! w !sudo /usr/bin/tee > /dev/null %

" mapping for vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" language specific
let fortran_free_source=1
" automatically set gnuplot filetype for *.gnu files
autocmd BufNewFile,BufRead *.gnu   setlocal filetype=gnuplot
autocmd BufNewFile,BufRead *.gp   setlocal filetype=gnuplot
" redefines comment string for gnuplot files to #
autocmd FileType gnuplot setlocal commentstring=#\ %s
" redefines comment string for c,cpp,c#,java to //
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
" highlight columns above 80 ... Error is colorscheme specific already
"__match Error /\%81v.\+/
