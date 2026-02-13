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
      uv
      pandoc
      bc
      
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
      # CustomModule = [
      #   {
      #   name = "Spacer";
      #   icon = "		";
      #    command = "";
      #   # listen_cmd = "";
      #   }
      #   ];
        appearance = {
          font_name = "CaskaydiaCove Nerd Font";
          scale_factor = 0.90;
          style = "Islands";
          primary_color =     "#414b50";
          text_color =        "#edeada";
          workspace_colors = ["#2e383c"];
          success_color =     "#a7c080";
          danger_color = {
            base = "#e67e80";
            weak = "#e69875";
          };
          background_color = {
            base = "#414b50";
            weak = "#2e383c";
            strong = "#272e33";
          };
          secondary_color = {
            base = "#859289";
          };
        };
        modules = {
          left = [ [ "Workspaces" ] [ "WindowTitle" ] ];
          center = [ "Clock"  ];
          right = [  "SystemInfo" [ "Settings" ] ];
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
