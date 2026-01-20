{ config, pkgs, lib, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "25.11";
    packages = import ./packages/common.nix { inherit pkgs; };
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
