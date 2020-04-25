#!/bin/bash
set -euo pipefile

pwd=$(pwd)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -f ~/.zshrc

ln -fs "$pwd/zshrc" "$HOME/.zshrc"
ln -fs "$pwd/tmux.conf" "$HOME/.tmux.conf"
ln -fs "$pwd/gitconfig" "$HOME/.gitconfig"
ln -fs "$pwd/pam_environment" "$HOME/.pam_environment"
ln -fs "$pwd/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"

# kitty
mkdir -p "$HOME/.config/kitty"
ln -fs "$pwd/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim/config
ln -fs "$pwd/nvim/init.vim" "$HOME/.config/nvim/init.vim"
ln -fs "$pwd/nvim/config/general.vim" "$HOME/.config/nvim/config/general.vim"
ln -fs "$pwd/nvim/config/keybindings.vim" "$HOME/.config/nvim/config/keybindings.vim"
ln -fs "$pwd/nvim/config/language.vim" "$HOME/.config/nvim/config/language.vim"
ln -fs "$pwd/nvim/config/plugins.vim" "$HOME/.config/nvim/config/plugins.vim"
ln -fs "$pwd/nvim/config/styles.vim" "$HOME/.config/nvim/config/styles.vim"

# sway
rm -rf ~/.config/sway
ln -fs "$pwd/sway" "$HOME/.config/sway"

# ranger
mkdir -p "$HOME/.config/ranger"
ln -fs "$pwd/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
ln -fs "$pwd/ranger/rifle.conf" "$HOME/.config/ranger/rifle.conf"
ln -fs "$pwd/ranger/scope.sh" "$HOME/.config/ranger/scope.sh"
