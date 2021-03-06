""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" language specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugin
filetype plugin on
filetype indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
" expand all tabs
autocmd BufNewFile,BufRead *.py set expandtab

" set vertical line
autocmd BufRead,BufNewFile *.py set colorcolumn=81

" FSharp
let g:fsharp_interactive_bin = '/usr/bin/dotnet fsi'

