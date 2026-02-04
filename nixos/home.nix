{
  pkgs,
  inputs,
  ...
}: 
  let
    activeCursor = pkgs.catppuccin-cursors.mochaDark;
    zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./modules/dunst.nix
    ./modules/hypridlelock.nix
    ./modules/hyprland.nix
  ];
  home = {
    username = "travis";
    homeDirectory = "/home/travis";
    stateVersion = "25.05";
    packages = with pkgs; [ 
      
      #---------------- Terminal Environment -------------#
      kitty # ---------- Terminal Emulator ---------------#
      neovim # --------- Default Editor ------------------#
      zellij # --------- Terminal Multiplexer ------------#
      
      #---------------- Dev Languages --------------------#
      typst #----------- Document Formatting / Gen -------#
      jq #-------------- JSON Query ----------------------#
      go #-------------- Golang --------------------------#
      python3 #--------- Python --------------------------#
      nodejs_25 #------- NodeJS --------------------------#
      ripgrep #--------- Regular Expressions -------------#
      fzf #------------- Fuzzy Finder --------------------#
      sqlite-interactive
      
      #---------------- TUI Utilites ---------------------#
      btop #------------ System Resource Monitor ---------#
      lynx #------------ TUI web browser -----------------#
      fastfetch #------- look, me shiny ------------------#
      clipse #---------- Clipboard service ---------------#
      visidata #-------- Spreadsheets and Databases ------#
      lazygit #--------- Git TUI -------------------------#
      pop #------------- TUI email utility ---------------#
      github-cli #------ Auth and settings ---------------#
      slides #---------- Terminal-based Presentations ----#
      presenterm #------ Terminal-based Presentations ----#
      graph-easy #------ Charts and Graphs ---------------#
      wget #------------ Barebones HTTP ------------------#
      unzip #----------- File Compression ----------------#
      claude-code #----- AI Agent ------------------------#
      
      #---------------- Nix Tooling ----------------------#
      alejandra #------- Nix Formatter -------------------#
      deadnix #--------- Nix Linter ----------------------#
      nixd #------------ Nix LSP -------------------------#
      
      #---------------- Miscellaneous --------------------#
      quickshell #------ Widget Maker --------------------#
      activeCursor #---- Mocha Dark Cursor Theme ---------#
      
      #---------------- Work Utilities -------------------#
      zint-qt #--------- Barcode Generator ---------------#
      zbar #------------ Barcode Reader ------------------#
      qrrs #------------ QR Code Generator / Reader ------#
      
      #---------------- GUI Applications -----------------#
      inkscape #-------- Vector Graphics -----------------#
      obsidian #-------- Markdown Notes ------------------#
      zen-browser #----- Web Browser ---------------------#

      #---------------- Learning -------------------------#
      bootdev-cli #----- boot.dev Answer-checker ---------#
    ];
  };

  #---------------------------------#
  #----- hyprland Config -----------#
  #---------------------------------#
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   systemd.enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage = null;
  #   extraConfig = ''
  #     ${builtins.readFile ../hypr/hyprland.conf}
  #   '';
  # };
  
  #---------------------------------#
  #----- Service Configuration -----#
  #---------------------------------#  
  
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
    
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
    #clipse = {};
  };

  systemd.user.services.hyprpaper = {
    Unit = {
      After = [ "hyprland-session.target" ];
      PartOf = [ "hyprland-session.target" ];
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
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

    ashell = {
      enable = true;
      settings = {
        appearance = {
          font_name = "CaskaydiaCove Nerd Font";
          scale_factor = 0.90;
          style = "Islands";
          
  # base00: "#272e33" # bg0,       palette1 dark
  # base01: "#2e383c" # bg1,       palette1 dark
  # base02: "#414b50" # bg3,       palette1 dark
  # base03: "#859289" # grey1,     palette2 dark
  # base04: "#9da9a0" # grey2,     palette2 dark
  # base05: "#d3c6aa" # fg,        palette2 dark
  # base06: "#edeada" # bg3,       palette1 light
  # base07: "#fffbef" # bg0,       palette1 light
  # base08: "#e67e80" # red,       palette2 dark
  # base09: "#e69875" # orange,    palette2 dark
  # base0A: "#dbbc7f" # yellow,    palette2 dark
  # base0B: "#a7c080" # green,     palette2 dark
  # base0C: "#83c092" # aqua,      palette2 dark
  # base0D: "#7fbbb3" # blue,      palette2 dark
  # base0E: "#d699b6" # purple,    palette2 dark
  # base0F: "#9da9a0" # grey2,     palette2 dark

          primary_color = "#7aa2f7";
          success_color = "#9ece6a";
          text_color = "#a9b1d6";
          workspace_colors = ["#7aa2f7" "#9ece6a"];
          danger_color = {
            base = "#f7768e";
            weak = "#e0af68";
          };
          background_color = {
            base = "#1a1b26";
            weak = "#24273a";
            strong = "#414868";
          };
          secondary_color = {
            base = "#0c0d14";
          };
        };
        modules = {
          left = [ "Workspaces" ];
          center = [ "WindowTitle" ];
          right = [ "Clock" [ "SystemInfo" "Settings" ] ];
        };
      };
    };

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
