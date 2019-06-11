# dotfiles

Configuration files for various tools I use on my Linux machines: zsh, neovim, tmux, git and sway.  
The neovim configuration has been in part copied from [cedi/vim-config](https://github.com/cedi/vim-config).

## Dependencies

 * git
 * curl
 * tmux
 * ctags
 * cscope
 * (sway)

## Installation 

**Warning**: the installation script overwrites existing configuration files.

    git clone git@github.com:pviotti/dotfiles.git ~/.config/dotfiles
    cd ~/.config/dotfiles
    ./install.sh
    
In neovim run `:PlugInstall` to install its plugins.

To install the configuration files of Sway issue:

    ./install-sway.sh

