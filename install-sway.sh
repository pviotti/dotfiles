#!/bin/bash

localDir=$(pwd)

mkdir -p ~/.config/sway

ln -s "$localDir/sway/config" "$HOME/.config/sway/config"
ln -s "$localDir/sway/status.sh" "$HOME/.config/sway/status.sh"
ln -s "$localDir/sway/toggle_kb.sh" "$HOME/.config/sway/toggle_kb.sh"
