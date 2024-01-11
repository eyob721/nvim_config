#!/usr/bin/env bash

# remove configuration
rm -rf ~/.config/nvim/{init.lua,lua/,*.json}

# remove extra files
rm -rf ~/.local/share/nvim{,.bak}
rm -rf ~/.local/state/nvim{,.bak}
rm -rf ~/.cache/nvim{,.bak}
