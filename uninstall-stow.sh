#!/bin/bash
set -euo pipefail

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed. Please install it first."
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to the stow directory
cd "$SCRIPT_DIR/stow"

echo "Uninstalling dotfiles using GNU Stow..."
echo "This will remove all symbolic links created by stow for your dotfiles packages."
echo "Your original configuration files will not be deleted."
echo ""
read -p "Are you sure you want to uninstall all stow-managed dotfiles? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted. No changes made."
    exit 0
fi

# Uninstall each package
for package in */; do
    if [ -d "$package" ]; then
        package_name="${package%/}"
        echo "Uninstalling $package_name..."
        stow -D -t "$HOME" "$package_name"
    fi
done

echo "Dotfiles uninstallation complete!"
echo "Note: This only removes the symbolic links. Your original configuration files may still exist." 