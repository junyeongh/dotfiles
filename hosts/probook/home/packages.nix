{ pkgs, ... }:

# NixOS-specific packages
# https://search.nixos.org/packages

with pkgs;
[
  bottles
  dbeaver-bin
  dconf-editor
  dropbox-cli
  ferdium
  firefox
  ghostty
  gnome-tweaks
  google-chrome
  heynote
  kanata
  kdePackages.plasma-workspace # for xembedsniproxy (Wine tray icon -> noctalia-shell tray bridge)
  noctalia-shell
  obsidian
  openssl
  spotify
  vlc
  vscode
  wofi
  yaak
  zathura
  zed-editor

  # Claude Code sandbox dependencies
  bubblewrap
  socat
  # Claude Code voice mode dependencies
  sox

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
  gnomeExtensions.tactile # Tactile
  gnomeExtensions.tiling-assistant # Tiling Assistant
]
