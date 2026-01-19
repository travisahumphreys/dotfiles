{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    # ../hypr/cursor.nix
  ];
  home = {
    username = "travis";
    homeDirectory = "/home/travis";
    stateVersion = "25.05"; 
    packages = with pkgs; [ 
    # Add user packages here
      typst
      jq
      presenterm
      bootdev-cli
      inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
 
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = null;
    extraConfig = ''
      ${builtins.readFile ../hypr/hyprland.conf}
    '';
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
    #   #    hyprwinwrap
    #   hyprexpo
    #   hyprbars
    # ];
  };
  ## The hyprpaper service; todo: add wallpapers to flake, use relative paths, assign wallpaper to variable
  services.hyprpaper = {
    # ipc = "on";
    # splash = false;
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      preload = ["/home/travis/dotfiles/hypr/wall.png"];
     wallpaper = ["eDP-1 , /home/travis/dotfiles/hypr/wall.png"];
    };
  };
 
  # Your home-manager configurations go here
  programs = {

    home-manager.enable = true;
    
    git = {
      enable = true;
      settings = {
        user = {
          name = "travis-humphreys";
          email = "travis.a.humphreys@gmail.com";
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
  
  };

}
