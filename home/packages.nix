{ pkgs, pkgs-unstable, ... }:

# https://search.nixos.org/packages
(with pkgs; [ ])
++ (with pkgs-unstable; [
  btop
  direnv
  dotter
  fnm
  gh
  git
  git-lfs
  mise
  neovim
  nil
  nixd
  nixfmt
  tmux
  zellij
])
