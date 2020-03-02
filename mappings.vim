" F1 -- FZF help
" F2 -- pastetoggle
set pastetoggle=<F2>
" F3 -- turn off/on linenumbers
nnoremap <F3> :set relativenumber!<CR> :set number!<CR> :GitGutterToggle<CR>
" F5/F6 -- spell checking for english/german
nnoremap <F5> :setlocal spell<CR> :setlocal spelllang=en_us<CR> :setlocal spellfile=~/.vim/spell/en.utf-8.add<CR>
nnoremap <F6> :setlocal spell<CR> :setlocal spelllang=de<CR> :setlocal spellfile=~/.vim/spell/de.utf-8.add<CR>
nnoremap <F7> :setlocal nospell<CR>
" F10 -- undotree
" Y to be consistent with D and C
map Y y$
" Disable Q, since I accidentally press it too often
map Q <Nop>
" fold open / close with space
nnoremap <Space> za
vnoremap <Space> za
" Ctrl L deactivates highlighting after a search -- obsolete
" nnoremap <C-L> :nohl<CR><C-L>
" Allow saving of files as sudo when I forgot to start vim using sudo
cnoremap w!! w !sudo /usr/bin/tee > /dev/null %
" LineScrolling makes this way more sense (to me)
nnoremap <C-J> <C-E>
nnoremap <C-K> <C-Y>
inoremap <leader><leader>t <C-R>=strftime('%d %b %Y %X %Z')<CR>
" RegEx search -- obsolete
" nnoremap / /\v
" xnoremap / /\v
" easier window movement
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
" whitespace
nnoremap <Leader>w :call ToggleWhiteSpace()<CR>
" last buffer
nnoremap <Leader><Leader> <C-^>
" submit calculation
nnoremap <Leader>s :!sbatch %<CR>
" open header file
nnoremap <Leader>e :call SwitchSourceHeader()<CR>
" vsplit open header file
nnoremap <Leader>v :call VsplitSourceHeader()<CR>
