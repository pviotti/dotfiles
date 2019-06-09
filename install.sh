#!/bin/bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm ~/.zshrc

localDir=$(pwd)

ln -s "$localDir/zshrc" "$HOME/.zshrc"
ln -s "$localDir/tmux.conf" "$HOME/.tmux.conf"
ln -s "$localDir/gitconfig" "$HOME/.gitconfig"
ln -s "$localDir/Xdefaults" "$HOME/.Xdefaults"
ln -s "$localDir/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s "$localDir/vimrc" "$HOME/.vimrc"
mkdir -p ~/.vim/colors
ln -s "$localDir/vim-vividchalk.vim" "$HOME/.vim/colors/vividchalk.vim"
