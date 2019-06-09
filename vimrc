call plug#begin('~/.vim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set mouse=

set incsearch
set hlsearch

" display line numbers
set number

set wrap
set textwidth=120

:nnoremap <F3> "=strftime("%Y/%m/%d")<CR>p
:inoremap <F3> <C-R>=strftime("%Y/%m/%d")<CR>

syntax on
colorscheme elflord
"colorscheme vividchalk

map <C-t> :tabn<Enter>
map <C-n> :tabnew<Enter>
map <C-n> :NERDTreeTabsToggle<Enter>

set completeopt=menuone,longest

let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"

" Switch window/split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set default vertical and horizontal splits positions
set splitbelow
set splitright

" Replace the word highlighted everywhere
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Open NerdTree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window open is NerdTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
