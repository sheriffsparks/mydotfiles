execute pathogen#infect()

syntax enable
filetype plugin indent on

" Quick exit from edit mode
imap jj <Esc>

" For auto save when lost focus on tmux tab
:au FocusLost * :wa

" Always display status bay
set laststatus=2

"tabs
set autoindent
set smarttab

set tabstop=4 	  " number of visual spaces per tab
set softtabstop=4 noexpandtab " number of spaces in tab when editing
set shiftwidth=4

" remap leader
let mapleader="," " remap , to leader

" allows cursor change in tmux mode
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" leader+o to display Open buffers
noremap <Leader>o :buffers<CR>

" searching
set incsearch " highlight chars as searching
set hlsearch  " highlight matches
" leader+enter to clear highlights
noremap <Leader><CR> :noh<CR>

" Better  menu for files
set wildmenu

" how many lines to keep below current
set scrolloff=1

" show file location
set ruler

" reload after file changes
set autoread

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

augroup fileSpell
	autocmd!
	autocmd FileType latex,text,md,markdown setlocal spell
	autocmd BufRead,BufNewFile *.tex,*.txt,*.md setlocal spell
augroup END
