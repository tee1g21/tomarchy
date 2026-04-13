# Tomarchy 🍅

An opinionated, highly customised Linux environment built on top of DHH's Omarchy (Arch Linux). Tomarchy acts as a bespoke OS configuration layer, transforming the base Hyprland desktop into a tailored, developer-centric workspace equipped with advanced multi-monitor workflows, unified theming, and custom system tooling.

---

## Features

### Custom System Menu
Replaces the default system menu to retain the **Suspend** option, ensuring you have full control over your machine's power states.

### Spanned Workspaces
Advanced multi-monitor workspace management. Scripts to seamlessly switch, move, and push windows or entire workspaces across dual monitors, keeping focus exactly where you need it.

### Custom Waybar
A tailored Waybar configuration with an updated layout, custom styling (`style.css`), an integrated brightness control script for precise display management and power profile toggle for portable devices.

### Custom Hyprlock
A beautifully customised lock screen that displays the current date, time, and live weather conditions across multiple screen sizes.

### Walker App Launcher
Custom configurations and themes for the Walker application launcher, blending it perfectly with the rest of the desktop aesthetic.

### Light/Dark Theme Toggle
A quick and easy way to flip between your favorite light and dark themes on the fly.

### Non-Intrusive Keybindings
Tomarchy respects your core system. Custom keybindings are safely appended via a `source` directive in your Hyprland config, keeping the base system clean.

---

## Installation

Tomarchy uses a safe symlink-based installation system. When modifying core system files (like Waybar or Hyprlock configs), it automatically creates backups (`.bak` or `.old`) in your home directory before applying changes.

```bash
# Make the install script executable
chmod +x install.sh

# Run the installer
./install.sh
```

**What it does:**
- Symlinks custom scripts to `~/.local/bin/`
- Backs up existing `waybar`, `walker`, and `hyprlock` configs, then symlinks the Tomarchy versions.
- Appends `source` lines to your Hyprland configuration to load Tomarchy bindings and workspaces.

---

## Uninstallation

Want to revert to the base Omarchy setup? The uninstaller will safely remove all symlinks, clean up the injected `source` lines from your Hyprland configs, and restore your original backed-up configuration files.

```bash
# Make the uninstall script executable
chmod +x uninstall.sh

# Run the uninstaller
./uninstall.sh
```
