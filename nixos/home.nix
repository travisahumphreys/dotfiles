{
  config,
  pkgs,
  ...
}: {
  home.username = "travis";
  home.homeDirectory = "/home/travis";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Specify the state version
  home.stateVersion = "25.05"; # Please read the comment below about the version

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
