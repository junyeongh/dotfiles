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

  programs.btop.enable = true;
  programs.btop.package = pkgs-unstable.btop;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.package = pkgs-unstable.direnv;

  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.lfs.package = pkgs-unstable.git-lfs;
  programs.git.package = pkgs-unstable.git;

  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
  programs.helix.package = pkgs-unstable.helix;

  programs.mise.enable = true;
  programs.mise.package = pkgs-unstable.mise;

  programs.zellij.enable = true;
  programs.zellij.package = pkgs-unstable.zellij;
}
