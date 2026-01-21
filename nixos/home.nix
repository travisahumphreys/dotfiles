{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./modules/dunst.nix
    # ../hypr/cursor.nix
  ];
  home = {
    username = "travis";
    homeDirectory = "/home/travis";
    stateVersion = "25.05"; 
    packages = with pkgs; [ 
      
      # ---------- Terminal Environment --------- #
      kitty # terminal emulator
      neovim # Default Editor
      zellij # Terminal Multiplexer
      
      # ---------- Dev Languages ---------------- #
      typst
      jq
      go
      python3
      nodejs_25
      ripgrep
      fzf
      
      # ---------- TUI Utilites ----------------- #
      btop # System Resource Monitor
      lynx # TUI web browser
      fastfetch # look, me shiny
      clipse # Clipboard service
      visidata # Spreadsheets and Databases
      lazygit # Git TUI
      pop # TUI email utility
      github-cli # Auth and settings
      slides # Terminal-based Presentations
      graph-easy # Charts and Graphs
      wget # AstroLSP dependency
      unzip # AstroLSP dependency
      presenterm
      
      # ---------- Nix Tooling ------------------ #
      alejandra
      deadnix
      nixd
      
      # ---------- Miscellaneous ---------------- #
      quickshell
      catppuccin-cursors.mochaDark
      
      # ---------- Work Utilities --------------- #
      zint-qt
      zbar
      qrrs
      
      # ---------- GUI Applications ------------- #
      inkscape # vector graphics
      obsidian # note-taking with markdown
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      
      # ---------- Learning --------------------- #
      bootdev-cli
    ];
  };
 
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = null;
    extraConfig = ''
      ${builtins.readFile ../hypr/hyprland.conf}
    '';
  };
  
  # --------------------------------#
  # ---- Service Configuration ---- #
  # ------------------------------- #  
  
  services = {
    hyprpaper = {
      enable = true;
      package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        ipc = "on";
        splash = false;
        wallpaper = [
          {
            monitor = "eDP-1";
            path = "/home/travis/dotfiles/hypr/wall.png";
          }
        ];
      };
    };
  
    #dunst = {};
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
    #clipse = {};
  };

  # ------------------------------- #
  # ---- Program Configuration ---- #
  # ------------------------------- #
  
  programs = {

    home-manager.enable = true;
    
    git = {
      enable = true;
      settings = {
        user = {
          name = "travis-humphreys";
          email = "travis.a.humphreys@gmail.com";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
    
    bottom.enable = true;

    ashell.enable = true;

    rofi = {
      enable = true;
      package = pkgs.rofi;
      theme = "DarkBlue";
      extraConfig = {
        modi = "drun,run,window,ssh";
        show-icons = true;
        display-drun = " Apps";
        display-run = " Run";
        display-window = " Window";
      };
    };
    
    #btop = {};
    #kitty = {};
    #lazygit = {};
    
  };

}
