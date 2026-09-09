{ pkgs, pkgs-unstable, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "26.05";
    packages = import ./packages.nix {
      inherit pkgs pkgs-unstable;
    };
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
