#!/bin/bash

REPO_DIR="$HOME/Repositories/tomarchy"


uninstall_custom_menu() {
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

    # Remove weather-related files if present
    rm -rf "$HOME/.cache/tomarchy/hyprlock-weather"
    rm -f "$HOME/.local/bin/hyprlock-weather"
}

uninstall_custom_walker() {
    echo "Uninstalling custom walker..."

    local target="$HOME/.config/walker/config.toml"
    local themes="$HOME/.config/walker/themes"
    local backup="$target.old"

    # Remove the themes symlink
    if [ -L "$themes" ]; then
        rm "$themes"
        echo "Removed themes symlink."
    fi

    # Handle the config.toml
    if [ -L "$target" ]; then
        rm "$target"
        echo "Removed walker config.toml symlink."
    fi

    # Restore the backup
    if [ -f "$backup" ]; then
        mv "$backup" "$target"
        echo "Restored original walker config.toml."
    fi
}

uninstall_custom_waybar() {
    echo "Uninstalling custom waybar..."

    local config_target="$HOME/.config/waybar/config.jsonc"
    local config_backup="$HOME/.config/waybar/config.jsonc.bak"
    local brightness_target="$HOME/.local/bin/brightness-control"

    # Remove config symlink only if it is a symlink
    if [ -L "$config_target" ]; then
        rm "$config_target"
        echo "Removed waybar config symlink."
    fi

    # Restore backup config if present and target is absent
    if [ -e "$config_backup" ] && [ ! -e "$config_target" ]; then
        mv "$config_backup" "$config_target"
        echo "Restored original waybar config.jsonc from backup."
    fi

    # Remove brightness script symlink only if it is a symlink
    if [ -L "$brightness_target" ]; then
        rm "$brightness_target"
        echo "Removed brightness-control symlink."
    fi
}

main() {
    echo "Starting Tomarchy uninstallation... 🍅"

    #uninstall_custom_menu
    uninstall_theme_toggle
    uninstall_custom_bindings
    uninstall_custom_hyprlock
    uninstall_custom_walker
    uninstall_custom_waybar

    echo "Tomarchy uninstalled successfully."
}

main "$@"
