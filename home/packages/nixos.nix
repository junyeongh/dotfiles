{ pkgs, ... }:

# NixOS-specific packages (GUI apps, desktop tools)
# https://search.nixos.org/packages
with pkgs;
[
  # GUI Applications
  firefox
  vscode
  ghostty

  # Desktop utilities
  # wl-clipboard
]
