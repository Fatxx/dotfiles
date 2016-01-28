set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin('~/.vim/bundle')

NeoBundle 'christoomey/vim-run-interactive' " Interactive Shell
NeoBundle 'tpope/vim-fugitive' " Git helper
NeoBundle 'vim-scripts/tComment' " Comments Toggle
NeoBundle 'ajh17/Spacegray.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'wakatime/vim-wakatime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
call neobundle#end()

filetype plugin indent on

NeoBundleCheck

colorscheme spacegray 
set ruler         " show the cursor position all the time
set undolevels=1000 " Increase undo levels
set pastetoggle=<F2>
set mouse=a
" set encoding=utf-8
set noswapfile
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
" set showcmd       " display incomplete commands
" set laststatus=2  " Always display the status line
" set nocompatible
" set nonumber
" set nowrap
" set linebreak
" set showbreak=>\ \ \

let mapleader=","
let g:airline_powerline_fonts = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_loc_list_height = 5
nnoremap <leader>e :lclose<CR>

" JS
"let g:syntastic_javascript_checkers = ["standard"]
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
  "set columns=999
  "set linespace=2:s endi
endif

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

" Clear search highlight
nnoremap <leader>q :noh<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Toggle NERDTree
"nnoremap <Leader>t :NERDTreeToggle<CR>

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
  " Clear whitespaces
  "autocmd FileType html,css,scss,javascript,py autocmd BufWritePre <buffer> :%s/\s\+$//e
  " - CSS
  autocmd FileType css,scss,sass setlocal iskeyword+=-
  " - MD
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  " Enable spellchecking for Markdown
  "autocmd FileType markdown setlocal spell
  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  " - Folding 
  autocmd FileType html,javascript,css,scss,sass,py setlocal foldmethod=indent
  autocmd FileType html,javascript,css,scss,sass,py normal zR
  " - NERDTree
  "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  " - StandardJS
 "autocmd bufwritepost *.js silent !standard % --format
  set autoread
augroup END

" Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ 'tmp/',
      \ '.sass-cache',
      \ 'node_modules/',
      \ 'bower_components/',
      \ 'dist/',
      \ '.git5_specs/',
      \ '.pyc',
      \ ], '\|'))

let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
endif

noremap <C-p> :Unite -start-insert -auto-resize file file_rec/async<cr>
nnoremap [unite]/ :Unite grep:.<cr>
nnoremap [unite]s :Unite -quick-match -start-insert buffer<cr>
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>

autocmd vimrc FileType unite call s:unite_settings()
function! s:unite_settings()
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction
