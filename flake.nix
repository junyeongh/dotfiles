{
  description = "Home Manager configuration of yeong";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Standalone home-manager configurations (for non-NixOS systems)
      homeConfigurations = {
        # WSL
        "wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home
            ./hosts/wsl/home
          ];
        };
      };

      # NixOS system configurations
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yeong =
                  { lib, pkgs, ... }:
                  {
                    imports = [
                      ./home
                      ./hosts/nixos/home
                    ];
                  };
              };
            }
          ];
        };
      };
    };
}
