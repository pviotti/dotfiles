""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable utf-8 everywhere
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" make backspace works properly
set backspace=2

" Set history
set history=999

" Set to autoread when a file is changed from the outside
set autoread

" enable mouse
if has("mouse")
	set mouse=a
endif

" use system clipboard
set clipboard=unnamed

" Search recursive for ctags file
set tags=./tags;

"set textwidth=80

set scrolloff=50

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Define search options
set ignorecase
set smartcase
set incsearch
set hlsearch
set nowrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup indention and spaces to tab/tab to spaces conversion
set autoindent
set tabstop=4
" When indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer settings
" allow a unsaved buffer to be hidden
set hidden

" Auto remove all trailing whitespaces on write
au BufWrite * :FixWhitespace

if has("autocmd")
	" When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
		  \ endif
endif " if hash("autocmd")

" Enable autocompletion on startup
let g:deoplete#enable_at_startup = 1
