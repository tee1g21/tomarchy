#!/bin/bash

REPO_DIR="$HOME/Repositories/tomarchy"


uninstall_menu_custom() {
    local target="$HOME/.local/bin/omarchy-menu-custom"
    if [ -L "$target" ]; then
        echo "Removing custom menu link..."
        rm "$target"
    fi
}

uninstall_theme_toggle() {
    local target="$HOME/.local/bin/omarchy-theme-toggle"
    if [ -L "$target" ]; then
        echo "Removing theme toggle link..."
        rm "$target"
    fi
}

uninstall_custom_bindings() {
    local source_file="$HOME/.config/hypr/custom-bindings.conf"
    local target_file="$HOME/.config/hypr/bindings.conf"
    local source_line="source = ~/.config/hypr/custom-bindings.conf"

    echo "Cleaning up custom bindings..."
    
    # Remove the symlink
    if [ -L "$source_file" ]; then
        rm "$source_file"
    fi

    # Revert the source line in the main config
    if [ -f "$target_file" ]; then
        # Use \| as a delimiter to avoid clashing with the / in the file path
        sed -i "\|$source_line|d" "$target_file"
        
        # Optional: Remove trailing empty lines left behind
        sed -i '${/^$/d;}' "$target_file"
    fi
}

uninstall_custom_hyprlock() {
    local target="$HOME/.config/hypr/hyprlock.conf"
    local backup="$target.old"

    echo "Reverting hyprlock.conf..."

    # Remove the symlink
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Restore the backup if it exists
    if [ -f "$backup" ]; then
        mv "$backup" "$target"
        echo "Restored original hyprlock.conf from backup."
    fi
}

main() {
    echo "Starting Tomarchy uninstallation... 🍅"

    uninstall_menu_custom
    uninstall_theme_toggle
    uninstall_custom_bindings
    uninstall_custom_hyprlock

    echo "Tomarchy uninstalled successfully."
}

main "$@"