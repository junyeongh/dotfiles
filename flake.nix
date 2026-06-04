{
  description = "Home Manager configuration of yeong";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    solaar.url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
    solaar.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
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
