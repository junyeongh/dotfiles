{
  inputs,
  pkgs-unstable,
  system,
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit pkgs-unstable inputs; };
  modules = [
    ./configuration.nix
    # ./flakes

    # solaar
    inputs.solaar.nixosModules.default
    # home-manager
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit pkgs-unstable;
      };
      home-manager.users.yeong =
        {
          lib,
          pkgs,
          ...
        }:
        {
          imports = [
            ../../home # default home-manager config
            ./home # host-specific home-manager config
          ];
        };
    }
  ];
}
