#!/bin/bash
set -euo pipefail

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed. Please install it first:"
    echo "  - Arch/Manjaro: sudo pacman -S stow"
    echo "  - Ubuntu/Debian: sudo apt install stow"
    echo "  - Fedora: sudo dnf install stow"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to the stow directory
cd "$SCRIPT_DIR/stow"

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

# Install vim-plug for neovim if not already installed
if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ]; then
    echo "Installing vim-plug for neovim..."
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Stow all packages
echo "Installing dotfiles using GNU Stow..."

# Install each package
for package in */; do
    if [ -d "$package" ]; then
        package_name="${package%/}"
        echo "Installing $package_name..."
        stow -t "$HOME" "$package_name"
    fi
done

echo "Dotfiles installation complete!"
echo ""
echo "Next steps: check README.md for more information."
echo ""
echo "To uninstall a package, use: stow -D -t \$HOME <package-name>"
echo "To reinstall a package, use: stow -R -t \$HOME <package-name>" 