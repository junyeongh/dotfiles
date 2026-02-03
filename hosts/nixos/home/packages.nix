{ pkgs, ... }:

# NixOS-specific packages
# https://search.nixos.org/packages

with pkgs;
[
  dropbox-cli
  ferdium
  firefox
  gh
  ghostty
  gnome-tweaks
  google-chrome
  heynote
  obsidian
  tailscale
  vlc
  vscode
  zed-editor
  # gnome extensions
  gnomeExtensions.appindicator # AppIndicator and KStatusNotifierItem Support
  gnomeExtensions.apps # Apps Menu
  gnomeExtensions.blur-my-shell # Blur my Shell
  gnomeExtensions.caffeine # Caffeine
  gnomeExtensions.dash-to-dock # Dash to Dock
  gnomeExtensions.clipboard-indicator # Clipboard Indicator
  gnomeExtensions.osd-volume-number # OSD Volume Number
  gnomeExtensions.removable-drive-menu # Removable Drive Menu
]
