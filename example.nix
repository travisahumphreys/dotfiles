{
  description = "NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, wsl, ... }@inputs: {
    homeConfigurations."laptop-mbp13-work" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config = { allowUnfree = true; };
        };
        modules = [ ./hosts/laptop-mbp13-work/home.nix ];
      };
    nixosConfigurations."wsl-dell-inspiron-5509" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        wsl.nixosModules.wsl./hosts/wsl-dell-inspiron-5509/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.nixos =
            import ./hosts/wsl-dell-inspiron-5509/home.nix;
        }
      ];
    };
    nixosConfigurations."thinkpad-x61" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop-thinkpad-x61/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.nixos =
            import ./hosts/laptop-thinkpad-x61/home.nix;
        }
      ];
    };
    nixosConfigurations."nixos-aliyun-01" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/server-aliyun-sh-01/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.nixos =
            import ./hosts/server-aliyun-sh-01/home.nix;
        }
      ];
    };
  };
}
