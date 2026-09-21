{
  # inputs,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.enableNixpkgsReleaseCheck = false;
  home.packages = lib.mkAfter (import ./packages.nix { inherit pkgs pkgs-unstable; });

  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.plugins = [
  #   pkgs.hyprlandPlugins.<plugin>
  # ];

  services.tailscale-systray.enable = true;

  programs.helix.enable = true;
  programs.helix.defaultEditor = true;

  dconf.settings = import ./dconf.nix;
}
