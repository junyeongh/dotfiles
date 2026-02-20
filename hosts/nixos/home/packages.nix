{ pkgs, ... }:

# NixOS-specific packages
# https://search.nixos.org/packages

with pkgs;
[
  bubblewrap
  dropbox-cli
  ferdium
  firefox
  ghostty
  gnome-tweaks
  google-chrome
  heynote
  obsidian
  socat
  spotify
  tailscale
  vlc
  vscode
  wofi
  yaak
  zed-editor
  # gnome extensions
  gnomeExtensions.appindicator # AppIndicator and KStatusNotifierItem Support
  gnomeExtensions.apps # Apps Menu
  gnomeExtensions.blur-my-shell # Blur my Shell
  gnomeExtensions.caffeine # Caffeine
  gnomeExtensions.clipboard-indicator # Clipboard Indicator
  gnomeExtensions.dash-to-dock # Dash to Dock
  gnomeExtensions.osd-volume-number # OSD Volume Number
  gnomeExtensions.quick-settings-tweaker
  gnomeExtensions.removable-drive-menu # Removable Drive Menu
  gnomeExtensions.tactile
  gnomeExtensions.tiling-assistant
]
