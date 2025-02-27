{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  home.username = "travis";
  home.homeDirectory = "/home/travis";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Specify the state version
  home.stateVersion = "25.05"; # Please read the comment below about the version
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    extraConfig = ''
      ${builtins.readFile ../hypr/hyprland.conf}
    '';
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprwinwrap
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];
  };
  # Your home-manager configurations go here
  programs = {
    git = {
      enable = true;
      userName = "travis-humphreys";
      userEmail = "travis.a.humphreys@gmail.com";
    };
    # Add more program configurations as needed
  };

  # Packages you want installed in your user profile
  home.packages = with pkgs; [
    # Add your packages here
  ];
}
