# dotfiles

Configuration files for various tools I use on my Linux machines:
zsh, neovim, tmux, git, kitty, gpg-agent, ranger and sway.
The neovim configuration has been in part copied from [cedi/vim-config](https://github.com/cedi/vim-config).

## Installation

**Warning**: the installation script overwrites existing configuration files.

    git clone git@github.com:pviotti/dotfiles.git ~/.config/dotfiles
    cd ~/.config/dotfiles
    ./install.sh

In neovim run `:PlugInstall` to install its plugins.

## Other configurations

- Add user to `video` group to allow for [`light`][light] execution
```bash
sudo gpasswd -a <username> video
groups <username> # validation; need to log back in
```


 [light]: https://gitlab.com/dpeukert/light