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
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4
set expandtab

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
" leader+enter to clear highlights
noremap <Leader><CR> :noh<CR>
" leader+n to toggle line numbers
noremap <Leader>n :set nu!<CR>
" leader+s to toggle spelling
noremap <Leader>s :set spell!<CR>
" leader+p to toggle paste
noremap <Leader>p :set paste!<CR>
" leader+r to toggle relativenumbering
noremap <Leader>r :set relativenumber!<CR>
" searching
set incsearch " highlight chars as searching
set hlsearch  " highlight matches


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

" Set spelling for some file types
augroup fileSpell
	autocmd!
	autocmd FileType latex,text,md,markdown setlocal spell
	autocmd BufRead,BufNewFile *.tex,*.txt,*.md setlocal spell
augroup END

" Smooth scroll settings
"distance, duration, speed
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 2)<CR>

" GitGutter settings
set updatetime=100

" ALE settings
let g:ale_open_list = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" lightline settings
if !has('gui_running')
  set t_Co=256
endif

" Decent dark color scheme
set background=dark
colors desert
