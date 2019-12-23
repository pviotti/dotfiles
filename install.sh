#!/bin/bash
set -euo pipefile

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -f ~/.zshrc

localDir=$(pwd)

ln -fs "$localDir/zshrc" "$HOME/.zshrc"
ln -fs "$localDir/tmux.conf" "$HOME/.tmux.conf"
ln -fs "$localDir/gitconfig" "$HOME/.gitconfig"
ln -fs "$localDir/Xdefaults" "$HOME/.Xdefaults"
ln -fs "$localDir/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"

# vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim/config
ln -fs "$localDir/nvim/init.vim" "$HOME/.config/nvim/init.vim"
ln -fs "$localDir/nvim/config/general.vim" "$HOME/.config/nvim/config/general.vim"
ln -fs "$localDir/nvim/config/keybindings.vim" "$HOME/.config/nvim/config/keybindings.vim"
ln -fs "$localDir/nvim/config/language.vim" "$HOME/.config/nvim/config/language.vim"
ln -fs "$localDir/nvim/config/plugins.vim" "$HOME/.config/nvim/config/plugins.vim"
ln -fs "$localDir/nvim/config/styles.vim" "$HOME/.config/nvim/config/styles.vim"

# sway
rm -rf ~/.config/sway
ln -fs "$localDir/sway" "$HOME/.config/sway"
sed 's|^Exec=|Exec=env MOZ_ENABLE_WAYLAND=1 |g' /usr/share/applications/firefox.desktop > ~/.local/share/applications/firefox.desktop
