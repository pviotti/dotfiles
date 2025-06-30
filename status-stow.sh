#!/bin/bash
set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to the stow directory
cd "$SCRIPT_DIR/stow"

echo "Stow packages status:"
echo "====================="
echo ""

# Check each package
for package in */; do
    if [ -d "$package" ]; then
        package_name="${package%/}"
        
        # Check if the package is stowed (has symbolic links)
        if stow -t "$HOME" -n "$package_name" 2>&1 | grep -q "would create"; then
            echo "❌ $package_name - Not installed"
        else
            echo "✅ $package_name - Installed"
        fi
    fi
done

echo ""
echo "To install a package: stow -t \$HOME <package-name>"
echo "To uninstall a package: stow -D -t \$HOME <package-name>" 