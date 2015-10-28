call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'christoomey/vim-run-interactive'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/tComment'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax', {'for': ['javascript']}
Plug 'walm/jshint.vim', {'for': ['javascript']}
Plug 'burnettk/vim-angular'
Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'hdima/python-syntax', { 'for': ['python'] }
Plug 'ervandew/supertab'
Plug 'tomasr/molokai'
Plug 'majutsushi/tagbar'
Plug 'wakatime/vim-wakatime'

call plug#end()

let g:angular_filename_convention = 'camelcased'
let g:js_indent = "~/.vim/bundle/JavaScript-Indent/indent/javascript.vim"
let b:javascript_fold = 1

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set undolevels=1000 " Increase undo levels
set pastetoggle=<F2>
set nocompatible
set noswapfile
set mouse=a
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set nonumber

set statusline=%#ErrorMsg#[%{mode()}]%*\ %f%m%r%h%w\ 
set statusline+=\ %=                        " align left
set statusline+=%{fugitive#statusline()}
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [\%c:\%l\/%L]

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set guifont=Fira\ Mono
  set columns=999
  set linespace=1.4
endi

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set number
set numberwidth=5

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

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

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

autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
