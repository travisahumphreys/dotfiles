 { config, pkgs, ... }:

let
  cursor-theme = "Catppuccin-Mocha-Dark-Cursors";
  cursor-package = pkgs.catppuccin-cursors.mochaDark;
in
{
  # Install hyprcursor
  home.packages = [ 
    pkgs.hyprcursor 
    cursor-package
  ];

  # Set environment variables for both X11 and Hyprland
  home.sessionVariables = {
    XCURSOR_THEME = cursor-theme;
    HYPRCURSOR_THEME = cursor-theme;
    HYPRCURSOR_SIZE = "24";
  };
  
  # Configure pointer cursor settings
  home.pointerCursor = {
    name = cursor-theme;
    package = cursor-package;
    size = 24;
    
    # Enable for different environments
    x11.enable = true;
    gtk.enable = true;
  };
  
  # If you're using Hyprland, add these settings too
  wayland.windowManager.hyprland = {
    enable = true; # Only add if you're using Hyprland
    settings = {
      env = [
        "HYPRCURSOR_THEME,${cursor-theme}"
        "HYPRCURSOR_SIZE,24"
      ];
    };
  };
}
