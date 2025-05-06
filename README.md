# Dotfiles

A personal NixOS configuration featuring Hyprland, Neovim, and various productivity tools.

## Repository Contents

### NixOS Configuration
- `nixos/configuration.nix` - Main system configuration
- `nixos/hardware-configuration.nix` - Hardware-specific settings
- `nixos/home.nix` - Home-manager user configuration
- `nixos/modules/` - Modular configuration components:
  - `localization.nix` - Language and locale settings
  - `retroarch.nix` - Retro gaming configuration

### Hyprland Setup
- `hypr/hyprland.conf` - Hyprland compositor configuration
- `hypr/hyprpaper.conf` - Wallpaper settings
- `hypr/cursor.nix` - Cursor theme configuration
- `hypr/wall.png` - Wallpaper image

### Neovim Configuration
- `nvim/` - AstroNvim v4+ configuration
- `nvim/lua/plugins/` - Plugin-specific settings:
  - LSP configuration
  - Theme and UI customizations
  - Treesitter setup
  - Code formatting and linting

### Utilities
- `dunst/dunstrc` - Notification daemon configuration
- `scripts/` - Utility scripts:
  - QR code scanning utilities
  - Screenshot tools

### Nix Flake
- `flake.nix` - Declarative system configuration
- `flake.lock` - Dependency lockfile

## Key Features
- Zen kernel for better performance
- AMD GPU configuration
- Pipewire audio with low-latency settings
- Various development tools (zig, go, nodejs, clang)
- Gaming support with Steam and Proton-GE
- Hyprland with custom wallpaper and notifications
- AstroNvim for enhanced text editing