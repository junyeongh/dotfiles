{
  description = "Home Manager configuration of yeong";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
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
        "wsl" = import ./hosts/wsl { inherit inputs system pkgs-unstable; };
      };

      # NixOS system configurations
      nixosConfigurations = {
        "probook" = import ./hosts/probook { inherit inputs system pkgs-unstable; };
      };
    };
}
