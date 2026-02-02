{ pkgs, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "26.05";
    packages = import ./packages.nix { inherit pkgs; };
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
