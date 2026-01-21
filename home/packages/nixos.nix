{ pkgs, ... }:

# NixOS-specific packages
# https://search.nixos.org/packages
with pkgs;
[
  _1password-cli
  _1password-gui
  dropbox
  # dropbox-cli
  ferdium
  firefox
  ghostty
  google-chrome
  obsidian
  tailscale
  vscode
  # gnome extensions
  # gnomeExtensions.quick-settings-tweaks # Quick Settings Tweaks
  gnomeExtensions.appindicator # AppIndicator and KStatusNotifierItem Support
  gnomeExtensions.apps # Apps Menu
  gnomeExtensions.blur-my-shell # Blur my Shell
  gnomeExtensions.caffeine # Caffeine
  gnomeExtensions.dash-to-dock # Dash to Dock
  gnomeExtensions.osd-volume-number # OSD Volume Number
  gnomeExtensions.removable-drive-menu # Removable Drive Menu
  gnomeExtensions.user-themes # User Themes
]
