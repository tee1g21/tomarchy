# Tomarchy 🍅

An opinionated, highly customised Linux environment built on top of DHH's Omarchy (Arch Linux). Tomarchy acts as a bespoke OS configuration layer, transforming the base Hyprland desktop into a tailored, developer-centric workspace equipped with advanced multi-monitor workflows, unified theming, and custom system tooling.

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

---

## Features

### Custom System Menu
Replaces the default system menu to retain the **Suspend** option, ensuring you have full control over your machine's power states.

<img width="302" height="471" alt="custom-system-menu" src="https://github.com/user-attachments/assets/92b21441-d201-494f-bcc2-eccc597b95ad" />

### Spanned Workspaces
Advanced multi-monitor workspace management. Scripts to seamlessly switch, move, and push windows or entire workspaces across dual monitors, keeping focus exactly where you need it.

https://github.com/user-attachments/assets/397053e1-2588-4bff-acf2-cd6f7aa156ff

### External Monitor Brightness Control
A tailored Waybar configuration with an updated layout, custom styling (`style.css`), an integrated brightness control script for precise display management and 

![custom-brightness](https://github.com/user-attachments/assets/e7ed5e7c-7873-4968-999c-82b15e67909a)

### Power Profiles Selector
Power profiles selector included in custom Waybar for laptops

![power-profiles-selector](https://github.com/user-attachments/assets/7a378f53-54cc-4a8d-897f-f97d765c9a8b)

### Custom Hyprlock
A beautifully customised lock screen that displays the current date, time, and live weather conditions across multiple screen sizes.

<img width="2560" height="1440" alt="hyprlock-light" src="https://github.com/user-attachments/assets/649bac6b-3241-43ef-b9af-6ba2621ae80c" />
<img width="2560" height="1440" alt="hyprlock-dark" src="https://github.com/user-attachments/assets/7b2c9bab-4547-4763-84ba-847bcd71959e" />

### Walker App Launcher
Custom configurations and themes for the Walker application launcher, blending it perfectly with the rest of the desktop aesthetic.

<img width="651" height="405" alt="custom-walker" src="https://github.com/user-attachments/assets/63d6360a-4707-4c37-b14e-5b44d6cc0586" />

### Light/Dark Theme Toggle
A quick and easy way to flip between your favorite light and dark themes on the fly.

![theme-toggle](https://github.com/user-attachments/assets/925e3741-6d42-4ced-8469-b32b1e2201a2)

### Non-Intrusive Keybindings
Tomarchy respects your core system. Custom keybindings are safely appended via a `source` directive in your Hyprland config, keeping the base system clean.


