{ config, pkgs, ... }:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "25.11";

    packages = packages;
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
}
