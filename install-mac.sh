#!/bin/bash
set -euo pipefail

pwd=$(pwd)

mkdir -p "$HOME/Library/KeyBindings"
ln -fs "$pwd/mac/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"

# remove "Last login.." initial message when opening a terminal
touch ~/.hushlogin
