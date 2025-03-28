{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  home = {
    username = "travis";
    homeDirectory = "/home/travis";
    stateVersion = "25.05"; 
    packages = with pkgs; [ 
    # Add user packages here
      presenterm
    ];
  };
 
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    extraConfig = ''
      ${builtins.readFile ../hypr/hyprland.conf}
    '';
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      hyprwinwrap
      hyprexpo
      hyprbars
    ];
  };

  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      preload = ["../hypr/wall.png"];
     wallpaper = [" , ../hypr/wall.png"];
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
