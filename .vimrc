""""""""""""""""""
" Key Remappings "
""""""""""""""""""

"remap jj to <Esc>
imap jj <Esc>

" Enable folding with spacebar
nnoremap <space> za

""""""
" UI "
""""""
" font
 set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
" set guifont=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15

" Disable scrollbar
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" disable vi compatibility
set nocompatible

" automatically load changed files
set autoread

" auto-reload vimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc
"autocmd! bufwritepost gvimrc source ~/.vim/gvimrc

" show the filename in the window titlebar
set title

" set encoding
set encoding=utf-8

" disable swapfiles
set noswapfile

" directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backupf

" display incomplete commands at the bottom
set showcmd

" mouse support
set mouse=a

" line numbers
set number

" highlight cursor line
set cursorline

" wrapping stuff
set textwidth=80
set colorcolumn=80

" Code folding
set foldmethod=indent
set foldlevel=99

" ignore whitespace in diff mode
" set diffopt+=iwhite

" Be able to arrow key and backspace across newlines
set whichwrap=bs<>[]

" Status bar
set laststatus=2

" remember last cursor position
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\ 	exe "normal g`\"" |
	\ endif

" show '>   ' at the beginning of lines that are automatically wrapped
set showbreak=>\ \ \

" enable completion
set ofu=syntaxcomplete#Complete

" make laggy connections work faster
set ttyfast

" let vim open up to 100 tabs at once
set tabpagemax=100

" case-insensitive filename completion
set wildignorecase

"""""""""""""
" Searching "
"""""""""""""

set hlsearch "when there is a previous search pattern, highlight all its matches
set incsearch "while typing a search command, show immediately where the so far typed pattern matches
set ignorecase "ignore case in search patterns
set smartcase "override the 'ignorecase' option if the search pattern contains uppercase characters
set gdefault "imply global for new searches

"""""""""""""
" Indenting "
"""""""""""""

" When auto-indenting, use the indenting format of the previous line
set copyindent
" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
" space at the start of the line.
set smarttab
" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command)
set autoindent
" Automatically inserts one extra level of indentation in some cases, and works
" for C-like files
set smartindent
" @TODO make this File specific
"sets tabstop 2
set tabstop=2
"when indenting with >  use 2 spaces
set shiftwidth=2
"On pressing tab, insert 2 spaces
set expandtab

" Python specific indenting
au BufNewFile, BufRead *.py,
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Javascript indentation
au BufNewFile, BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" highlight trailing whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h, *.js match BadWhitespace /\s\+$/


""""""""
" GVim "
""""""""

"disable cursor blinking
set gcr=n:blinkon0

"remove menu bar
set guioptions-=m

"""""""""""""""""""""
" Language-Specific "
"""""""""""""""""""""

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.html.erb set ft=eruby

" Add json syntax highlighting
au BufNewFile,BufRead *.json set ft=json syntax=javascript

"""""""""""""""""""""
"     Plug          "
"""""""""""""""""""""

call plug#begin('~/.vim/plugged')
  " Nerdtree
  Plug 'preservim/nerdtree'

  " Ale (eslint)
  Plug 'dense-analysis/ale'

  "Vim polygot
  Plug 'sheerun/vim-polyglot'

  " Vim lightline (powerline clone)
  Plug 'itchyny/lightline.vim'

  " SimpylFold -- Better folding
  Plug 'tmhedberg/SimpylFold'

  " Better Python indentation
  Plug 'vim-scripts/indentpython.vim'

	" YCM
	Plug 'Valloric/YouCompleteMe'

  " Pythong style checker
  Plug 'nvie/vim-flake8'

  " Themes "

  " vim-gitbranch (Provides gitbranch function instead of full integration)
  Plug 'itchyny/vim-gitbranch'

  " Zenburn
  Plug 'jnurmine/Zenburn', { 'as' : 'zenburn' }

	" One dark
	Plug 'joshdick/onedark.vim'

call plug#end()

"""""""""
" Theme "
"""""""""

syntax enable
set background=dark "uncomment this if your terminal has a dark background
colorscheme onedark

"""""""""""""""""""""
"     lightLine     "
"""""""""""""""""""""
let laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }


"""""""""""""""""""""
"     Nerdtree      "
"""""""""""""""""""""
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"""""""""""""""""""""
"     ALE           "
"ALEInfo shows what is currently configured
"""""""""""""""""""""
"Enable ESLint for javascript
let b:ale_linters = {'javascript': ['eslint']}
let b:ale_fixers = ['eslint']
let g:ale_linters_explicit = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

"""""""""""""""""""""
"     Flake 8       "
"""""""""""""""""""""
autocmd BufWritePost *.py call Flake8()
