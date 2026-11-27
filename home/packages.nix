{ pkgs, pkgs-unstable, ... }:

# https://search.nixos.org/packages
(with pkgs; [ ])
++ (with pkgs-unstable; [
  dotter
  fnm
  neovim
  nil
  nixd
  nixfmt
  tmux
])
