{
  inputs,
  pkgs-unstable,
  ...
}:
let
  home-manager = inputs.home-manager;
in
home-manager.lib.homeManagerConfiguration {
  pkgs = pkgs-unstable;
  modules = [
    ../../home # default home-manager config
    ./home # host-specific home-manager config
  ];
}
