# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- Test NixOS configuration: `sudo nixos-rebuild test --flake .#thinkpad`
- Build NixOS configuration: `sudo nixos-rebuild switch --flake .#thinkpad`
- Format Nix files: `alejandra .`
- Lint Nix files: `deadnix .`
- Rebuild home-manager config: `home-manager switch`

## Code Style Guidelines
- NixOS: Follow standard Nix formatting (use `alejandra` for formatting)
- Lua: Follow AstroNvim conventions in Neovim configuration
- Indentation: 2 spaces
- New files should follow existing patterns in similar files
- Commented code should be removed, not left as-is
- Keep configurations modular; prefer separate module files
- Hyprland configs: Use standard syntax and follow existing conventions
- Error handling: Use proper error handling in scripts

## Editor Integration
- EDITOR and VISUAL environment variables are set to "nvim"
- Neovim with AstroNvim v4+ is the primary editor