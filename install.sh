#!/bin/bash

REPO_DIR=$(git rev-parse --show-toplevel 2>/dev/null)

install_custom_menu() {
    echo "Installing custom menu..."

    ln -sf "$REPO_DIR/.local/bin/omarchy-menu-custom" "$HOME/.local/bin/omarchy-menu-custom"
}

install_theme_toggle() {
    echo "Installing theme toggle..."

    ln -sf "$REPO_DIR/.local/bin/omarchy-theme-toggle" "$HOME/.local/bin/omarchy-theme-toggle"
}

install_custom_bindings() {
    echo "Installing custom bindings..."

    ln -sf "$REPO_DIR/.config/hypr/bindings.conf" "$HOME/.config/hypr/custom-bindings.conf"

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

install_custom_hyprlock() {
    echo "Installing custom hyprlock..."

    local target="$HOME/.config/hypr/hyprlock.conf"
    local backup="$target.old"

    # Only backup if the target is a real file and backup doesn't exist
    if [ -f "$target" ] && [ ! -L "$target" ] && [ ! -f "$backup" ]; then
        mv "$target" "$backup"
        echo "Original hyprlock.conf backed up to .old"
    fi

    ln -sf "$REPO_DIR/.config/hypr/hyprlock.conf" "$target"

    # Link weather widget scrip to local bin
    ln -sf "$REPO_DIR/.local/bin/hyprlock-weather" "$HOME/.local/bin/hyprlock-weather"

    # clear weather cache
    rm -rf "$HOME/.cache/tomarchy/hyprlock-weather"

}

install_custom_walker() {
    echo "Installing custom walker..."

    mkdir -p "$HOME/.config/walker"

    ln -sfn "$REPO_DIR/.config/walker/themes" "$HOME/.config/walker/themes"

    local target="$HOME/.config/walker/config.toml"
    local backup="$target.old"

    if [ -f "$target" ] && [ ! -L "$target" ] && [ ! -f "$backup" ]; then
        mv "$target" "$backup"
        echo "Original walker config.toml backed up to .old"
    elif [ -L "$target" ]; then
        echo "Walker config is already a symlink, skipping backup."
    fi

    ln -sf "$REPO_DIR/.config/walker/config.toml" "$target"
}

install_custom_waybar() {
    echo "Installing custom waybar..."

    mkdir -p "$HOME/.config/waybar"
    mkdir -p "$HOME/.local/bin"

    local config_target="$HOME/.config/waybar/config.jsonc"
    local config_backup="$HOME/.config/waybar/config.jsonc.bak"
    local config_source="$REPO_DIR/.config/waybar/config.jsonc"

    local brightness_target="$HOME/.local/bin/brightness-control.sh"
    local brightness_source="$REPO_DIR/.local/bin/brightness-control.sh"

    # Backup existing system config only if it's a real file and no backup exists yet
    if [ -e "$config_target" ] && [ ! -L "$config_target" ] && [ ! -e "$config_backup" ]; then
        mv "$config_target" "$config_backup"
        echo "Original waybar config.jsonc backed up to config.jsonc.bak"
    fi

    # Replace existing symlink/file safely with the managed symlink
    rm -f "$config_target"
    ln -s "$config_source" "$config_target"

    # Link only the latest brightness script
    rm -f "$brightness_target"
    ln -s "$brightness_source" "$brightness_target"
}

main() {
mkdir -p "$HOME/.local/bin"

#install_custom_menu
install_theme_toggle
install_custom_bindings
install_custom_hyprlock
install_custom_walker
install_custom_waybar

chmod +x "$HOME/.local/bin/"*

echo "Tomarchy installed! 🍅"

}

main "$@"
