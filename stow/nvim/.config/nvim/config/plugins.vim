""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}

" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Enhanced Python syntax highlighting
Plug 'vim-python/python-syntax'

" Additional Vim syntax highlighting for C++ (including C++11/14)
" Plug 'octol/vim-cpp-enhanced-highlight'

" A vim plugin to help you to create/update cscope database and connect to existing proper database automa
" Plug 'brookhong/cscope.vim'

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'ctrlpvim/ctrlp.vim'

" Tab completion of words inside of a search ('/')
Plug 'vim-scripts/SearchComplete'

" Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
Plug 'bronson/vim-trailing-whitespace', {'on': 'FixWhitespace'}

" The BClose Vim plugin for deleting a buffer without closing the window
" Plug 'rbgrouleff/bclose.vim'

" Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'chiel92/vim-autoformat', {'on': 'Autoformat'}

" Because what the world needs is yet another vim colourscheme
Plug 'neutaaaaan/iosvkem'

"  Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

" deoplete.nvim source for Python
" Plug 'zchee/deoplete-jedi', {'do': 'make'}

" fsharp
Plug 'fsharp/vim-fsharp', {
            \ 'for': 'fsharp',
            \ 'do':  'make fsautocomplete',
            \}

Plug 'tpope/vim-surround'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()
