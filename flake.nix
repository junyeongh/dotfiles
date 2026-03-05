{
  description = "Home Manager configuration of yeong";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      solaar,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # Standalone home-manager configurations (for non-NixOS systems)
      homeConfigurations = {
        # WSL
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-unstable;
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
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/nixos/configuration.nix
            solaar.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { pkgs = pkgs-unstable; };
              home-manager.users.yeong =
                { lib, pkgs, ... }:
                {
                  imports = [
                    ./home
                    ./hosts/nixos/home
                  ];
                };
            }
          ];
        };
      };
    };
}
