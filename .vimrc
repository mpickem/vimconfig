" vim:fdm=marker
" .vimrc maintained by Matthias Pickem

let mapleader = "ö"

" vim-plug + configurations
source ~/.vim/plugins.vim

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

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile
  else
    set undodir^=~/.vim/tmp/undo/
    set undofile
  endif
endif

if exists('$SUDO_USER')
  set nobackup
  set nowritebackup
  set noswapfile
else
  set backupdir^=~/.vim/tmp/backup/
  set directory^=~/.vim/tmp/swap/
endif

if exists('&belloff')
  set belloff=all
endif

" autocommands
autocmd VimResized * wincmd = " automatically resize splits if window size is changed

" disable automatic comment insertion, intelligent comment line joining
if v:version > 703 || v:version == 703 && has('patch541')
  autocmd BufNewFile,BufRead * setlocal formatoptions=jql
else
  autocmd BufNewFile,BufRead * setlocal formatoptions=ql
endif

" augroup numbertoggle
"   autocmd!
"   autocmd WinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd WinLeave,BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

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

" Spelling
hi clear SpellBad
set spellfile^=~/.vim/spell/en.utf-8.add

" so we only need one latex flavor
let g:tex_flavor='latex'

" }}}

" Colorscheme {{{

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
hi SpellBad cterm=underline,bold ctermfg=9
hi SpellRare cterm=underline,bold
hi SpellCap cterm=underline,bold

" }}}

" non-plugin mappings
source ~/.vim/mappings.vim
