{ pkgs, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "25.11";
    packages = import ./packages { inherit pkgs; };
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
