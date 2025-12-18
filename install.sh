#!/bin/bash

REPO_DIR="$HOME/Repositories/tomarchy"

install_menu_custom() {
    echo "Installing custom menu..."
    ln -sf "$REPO_DIR/.local/bin/omarchy-menu-custom" "$HOME/.local/bin/omarchy-menu-custom"
}

install_theme_toggle() {
    echo "Installing theme toggle..."
    ln -sf "$REPO_DIR/.local/bin/omarchy-theme-toggle" "$HOME/.local/bin/omarchy-theme-toggle"
}

install_custom_bindings() { 
    echo "Installing custom bindings..."
    ln -sf "$REPO_DIR/.config/hypr/custom-bindings.conf" "$HOME/.config/hypr/custom-bindings.conf"

    SOURCE_LINE="source = ~/.config/hypr/custom-bindings.conf"
    TARGET_FILE="$HOME/.config/hypr/bindings.conf"

    if ! grep -qF "$SOURCE_LINE" "$TARGET_FILE"; then
        echo "" >> "$TARGET_FILE"
        echo "$SOURCE_LINE" >> "$TARGET_FILE"
        echo "Successfully added source line to bindings.conf"
    else
        echo "Source line already exists, skipping append."
    fi
}

main() { 
mkdir -p "$HOME/.local/bin"

install_menu_custom
install_theme_toggle
install_custom_bindings

chmod +x "$HOME/.local/bin/"*

echo "Tomarchy installed! 🍅"

}

main "$@"
