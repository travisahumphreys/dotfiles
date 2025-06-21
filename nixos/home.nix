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
      presenterm
      multiviewer-for-f1
      inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
 
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
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
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      preload = ["/home/travis/dotfiles/hypr/wall.png"];
     wallpaper = [" , /home/travis/dotfiles/hypr/wall.png"];
    };
  };
 
  # Your home-manager configurations go here
  programs = {

    home-manager.enable = true;
    
    git = {
      enable = true;
      userName = "travis-humphreys";
      userEmail = "travis.a.humphreys@gmail.com";
    };
    
    bottom.enable = true;
  
  };

}
