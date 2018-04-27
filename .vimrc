"
" A (not so) minimal vimrc.
"

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/w0rp/ale.git'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'Raimondi/delimitMate'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jelera/vim-javascript-syntax'
Plug 'https://github.com/Yggdroot/duoduo'
Plug 'mileszs/ack.vim'
Plug 'scwood/vim-hybrid'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'wakatime/vim-wakatime'
Plug 'jparise/vim-graphql'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =2         " Tab key indents by 4 spaces.
set shiftwidth  =2         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set noswapfile             " No swap files
set t_CO=256
set background=dark
colorscheme hybrid

set mouse=a

set updatetime=100

" fuzzy finder
set rtp+=/usr/local/opt/fzf

if has("gui_macvim")
  set macligatures
endif

set guifont=Fira\ Code:h12

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Keybinds

" Open fuzzy finder 
nnoremap <C-p> :Files .<CR>
" Open fuzzy finder for current word under the cursor
:nnoremap <leader>p :Files .<CR> <C-R><C-W>
" Open folder tree
nnoremap <C-b> <:NERDTreeToggle<CR>
" Toggle Quick Search
cnoreabbrev Ack Ack!
nnoremap <C-f> :Ack!<space>
" Search for current word under the cursor
:nnoremap <leader>f :Ack <C-R><C-W><CR>
" Close Buffer
nnoremap <leader>w :bd<CR>
" Next Buffer
nnoremap <C-n> :bn<CR>
" Format JS
nnoremap <leader>. :ALEFix<CR>
" Clear search highlight
nnoremap <leader>/ :noh<CR>
" Find and Replace
nnoremap <leader>r :%s/<space>/<space>/g
" Copy to Clipboard
vnoremap <C-c> "+y<CR>
" Paste to Clipboard
nnoremap <C-v> "+p<CR>

" JS
let g:javascript_plugin_jsdoc = 1

" Linter and Formatter
let g:ale_fixers = {'javascript': ['prettier_standard']}
let g:ale_linters = {'javascript': ['standard']}
let g:ale_fix_on_save = 1

" Linter errors in airline
let g:airline#extensions#ale#enabled = 1

" Autocomplete
:set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

