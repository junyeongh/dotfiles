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

  # Hyprland is launched without UWSM; this target is started from hyprland.lua
  # so that services bound to graphical-session.target can run
  systemd.user.targets.hyprland-session.Unit = {
    Description = "Hyprland compositor session";
    Documentation = [ "man:systemd.special(7)" ];
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
  };

  programs.noctalia.enable = true;

  services.xembed-sni-proxy.enable = true;
  services.xembed-sni-proxy.package = pkgs.kdePackages.plasma-workspace;

  dconf.settings = import ./dconf.nix;
}
