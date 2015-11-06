set nocompatible

call plug#begin('~/.vim/bundle')

Plug 'christoomey/vim-run-interactive' " Interactive Shell
Plug 'tpope/vim-fugitive' " Git helper
Plug 'vim-scripts/tComment' " Comments Toggle
Plug 'ervandew/supertab'
Plug 'ajh17/Spacegray.vim'
Plug 'majutsushi/tagbar'
Plug 'wakatime/vim-wakatime'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'

call plug#end()

filetype plugin indent on

colorscheme spacegray
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set undolevels=1000 " Increase undo levels
set pastetoggle=<F2>
set nocompatible
set noswapfile
set mouse=a
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch     " show search matches as you type
set hlsearch
set nonumber
set nowrap
set encoding=utf-8

let g:airline_powerline_fonts = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" JS
let g:syntastic_javascript_checkers = ["eslint"]
" HTML (Workaround to silence errors of angular directives)
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected", "<img> lacks \"src\" attribute"]
" Python
let g:syntastic_python_checkers = ["pep8", "pylint", "python"]
" SCSS
let g:syntastic_scss_checkers = ["scss_lint"]

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set guifont=Fira\ Mono
  set columns=999
  set linespace=1.4
endi

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

let mapleader=","

" Clear search highlight
nnoremap <leader>q :noh<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Toggle NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

nmap <F8> :TagbarToggle<CR>

" Auto Commands
augroup vimrc
  autocmd!
  " - CSS
  autocmd FileType css,scss,sass setlocal iskeyword+=-
  " - MD
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell
  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  " - Folding 
  autocmd FileType html,javascript,css,scss,sass,py setlocal foldmethod=indent
  autocmd FileType html,javascript,css,scss,sass,py normal zR
  " - NERDTree
  autocmd vimenter * NERDTree
augroup END

