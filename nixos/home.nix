{
  pkgs,
  inputs,
  ...
}: 
  let
    activeCursor = pkgs.catppuccin-cursors.mochaDark;
    zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
    claude-desktop = inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop-fhs;
    claude-code = inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
  in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./modules/dunst.nix
    ./modules/hypridlelock.nix
    ./modules/hyprland.nix
    ./modules/clipse.nix
    ./modules/hyprpaper.nix
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
      # python3 #--------- Python --------------------------#
      nodejs_25 #------- NodeJS --------------------------#
      ripgrep #--------- Regular Expressions -------------#
      fzf #------------- Fuzzy Finder --------------------#
      sqlite-interactive
      uv
      cargo
      

      #---------------- TUI / CLI Utilites ---------------#
      btop #------------ System Resource Monitor ---------#
      lynx #------------ TUI web browser -----------------#
      fastfetch #------- look, me shiny ------------------#
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
      gum
      tree-sitter
      csvkit
      bc
      
      #---------------- Nix Tooling ----------------------#
      alejandra #------- Nix Formatter -------------------#
      deadnix #--------- Nix Linter ----------------------#
      nixd #------------ Nix LSP -------------------------#

      #---------------- Secrets Management ---------------#
      sops #------------ Encrypted Secrets ----------------#
      age #------------- Encryption Tool ------------------#

      #---------------- Miscellaneous --------------------#
      quickshell #------ Widget Maker --------------------#
      activeCursor #---- Mocha Dark Cursor Theme ---------#
      socat 

      #---------------- Work Utilities -------------------#
      zint-qt #--------- Barcode Generator ---------------#
      zbar #------------ Barcode Reader ------------------#
      qrrs #------------ QR Code Generator / Reader ------#
      
      #---------------- GUI Applications -----------------#
      inkscape #-------- Vector Graphics -----------------#
      obsidian #-------- Markdown Notes ------------------#
      zen-browser #----- Web Browser ---------------------#
      claude-desktop qemu virtiofsd bubblewrap 

      #---------------- Learning -------------------------#
      bootdev-cli #----- boot.dev Answer-checker ---------#
    ];
  };

  #---------------------------------#
  #----- Service Configuration -----#
  #---------------------------------#  
  
  services = {
    
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
  };


  # ------------------------------- #
  # ---- Program Configuration ---- #
  # ------------------------------- #
  
  programs = {

    home-manager.enable = true;
    
    nh = {
      enable = true;
      osFlake = "/home/travis/dotfiles";
    };
    
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
