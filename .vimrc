set nocompatible

syntax enable
filetype plugin indent on

set tags+=tags,~/.vim/tags/*
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

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Decent dark color scheme
let g:gruvbox_guisp_fallback = "bg"
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" allows cursor change in tmux mode
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Term window commands. This fixes vim-tmux-navigator in side of
" terminal windows. It is listed as issue on page so maybe it will
" get incoperated into master at some point
if exists(':tnoremap')
 tnoremap <silent> <c-h> <c-w>:TmuxNavigateLeft<cr>
 tnoremap <silent> <c-j> <c-w>:TmuxNavigateDown<cr>
 tnoremap <silent> <c-k> <c-w>:TmuxNavigateUp<cr>
 tnoremap <silent> <c-l> <c-w>:TmuxNavigateRight<cr>
 tnoremap <silent> <c-\> <c-w>:TmuxNavigatePrevious<cr>
endif

" remap leader
let mapleader="," " remap , to leader
" leader+o to display Open buffers
" noremap <Leader>o :buffers<CR>
" noremap <Leader>o :ls<CR>:b<Space>
set wildcharm=<C-z>
"nnoremap <leader>o :buffer <C-z><S-Tab>
noremap <leader>o :BufExplorer<CR>

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
" leader+t to toggle ALE
" noremap <Leader>a :ALEToggle<CR>
" leader+t terminal
noremap <Leader>t :bel terminal ++rows=8 ++close bash<CR>
noremap <Leader>m :make<CR>
" leader+f to open netrw
" noremap <silent> <Leader>f :NERDTreeToggle<CR>
set path=.,**
noremap <Leader>f :find *
noremap <Leader>q :qa<CR>
noremap <Leader>w :wa<CR>
noremap <Leader>dr :VimspectorReset<CR>

" searching
set incsearch " highlight chars as searching
set hlsearch  " highlight matches
nnoremap <silent> <c-Up> :resize -1<CR>
nnoremap <silent> <c-Down> :resize +1<CR>
nnoremap <silent> <c-right> :vertical resize -1<CR>
nnoremap <silent> <c-left> :vertical resize +1<CR>

" Better  menu for files
"set wildmode=longest,list,full
set wildmode=longest:full,full
set wildmenu
" how many lines to keep below current
set scrolloff=5
" show file location
set ruler
" reload after file changes
set autoread

let g:vimspector_enable_mappings = 'HUMAN'

packloadall
silent! helptags ALL

"generate ctags
command Tags !ctags -R .

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

" Python file settings
autocmd FileType python noremap <buffer> <Leader>b obreakpoint()<Esc>
autocmd FileType python noremap <buffer> <Leader>d :bel terminal ++rows=8 ++cols=0 ++close bpython<CR>
autocmd FileType python noremap <buffer> <Leader>D :vert terminal ++close bpython<CR>
autocmd FileType python setlocal completeopt-=preview
let python_highlight_all = 1


""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS 
""""""""""""""""""""""""""""""""""

" Smooth scroll settings
"distance, duration, speed
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 1)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 1)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 2)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 2)<CR>

" GitGutter settings
set updatetime=100

" ALE settings
" let g:ale_open_list = 0
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
let g:ale_linters = { "python": ["ruff"] }
let g:ale_fixers = { "python": ["black", "ruff"] }
let g:ale_fix_on_save = 1


" lightline settings
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
if !has('gui_running')
  set t_Co=256
endif

set omnifunc=syntaxcomplete#Complete

" IDK about this one...
set noequalalways

packadd lsp
augroup LspCustom
    au!
    au CursorMoved * silent! LspDiag! current
augroup END
setlocal keywordprg=:LspHover
let g:IdeMode = !empty(finddir(".git", getcwd() .. ';'))

def TestFunc()
    :set number
enddef
