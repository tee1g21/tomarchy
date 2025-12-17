#!/bin/bash
# ~/src/tomarchy/install.sh

# Create the local bin directory if it doesn't exist
mkdir -p ~/.local/bin

# Link custom scripts
#    -sf (symbolic link, force overwrite if it exists)
# Custom Menu Script which include suspend
ln -sf ~/Repositories/tomarchy/.local/bin/omarchy-menu-custom ~/.local/bin/omarchy-menu-custom

# 3. Make them executable (just in case)
chmod +x ~/Repositories/tomarchy/.local/bin/*

echo "Tomarchy installed! 🍅"