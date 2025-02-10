{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager # Enable the home-manager module
        {
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.useGlobalPkgs = true; # Use the system's package set
          home-manager.useUserPackages = true; # Install packages to user profile
          home-manager.users.travis = import ./nixos/home.nix; # Your home config
        }
      ];
    };
  };
}
