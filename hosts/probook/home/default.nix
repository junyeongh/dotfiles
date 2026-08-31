{
  # inputs,
  lib,
  pkgs,
  ...
}:
{
  home.enableNixpkgsReleaseCheck = false;
  home.packages = lib.mkAfter (import ./packages.nix { inherit pkgs; });

  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.plugins = [
  #   pkgs.hyprlandPlugins.<plugin>
  # ];

  services.tailscale-systray.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
      switch-group = [ "<Alt>Above_Tab" ];
      switch-group-backward = [ "<Shift><Alt>Above_Tab" ];

      move-to-monitor-down = [ "<Super><Shift>Down" ];
      move-to-monitor-left = [ "<Super><Shift>Left" ];
      move-to-monitor-right = [ "<Super><Shift>Right" ];
      move-to-monitor-up = [ "<Super><Shift>Up" ];

      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];

      switch-to-workspace-1 = [ "<Super><Alt>1" ];
      switch-to-workspace-2 = [ "<Super><Alt>2" ];
      switch-to-workspace-3 = [ "<Super><Alt>3" ];
      switch-to-workspace-4 = [ "<Super><Alt>4" ];

      switch-to-workspace-up = [ "<Super><Control>Up" ];
      switch-to-workspace-down = [ "<Super><Control>Down" ];
      switch-to-workspace-left = [ "<Super><Control>Left" ];
      switch-to-workspace-right = [ "<Super><Control>Right" ];
    };

    "org/gnome/shell/keybindings" = {
      open-new-window-application-1 = [ "<Super><Control>1" ];
      open-new-window-application-2 = [ "<Super><Control>2" ];
      open-new-window-application-3 = [ "<Super><Control>3" ];
      open-new-window-application-4 = [ "<Super><Control>4" ];
      open-new-window-application-5 = [ "<Super><Control>5" ];
      open-new-window-application-6 = [ "<Super><Control>6" ];
      open-new-window-application-7 = [ "<Super><Control>7" ];
      open-new-window-application-8 = [ "<Super><Control>8" ];
      open-new-window-application-9 = [ "<Super><Control>9" ];

      switch-to-application-1 = [ "<Super>1" ];
      switch-to-application-2 = [ "<Super>2" ];
      switch-to-application-3 = [ "<Super>3" ];
      switch-to-application-4 = [ "<Super>4" ];
      switch-to-application-5 = [ "<Super>5" ];
      switch-to-application-6 = [ "<Super>6" ];
      switch-to-application-7 = [ "<Super>7" ];
      switch-to-application-8 = [ "<Super>8" ];
      switch-to-application-9 = [ "<Super>9" ];

      show-screenshot-ui = [ "Print" ];
      show-screen-recording-ui = [ "<Shift>Print" ];
      focus-active-notification = [ "<Super>n" ];
      toggle-message-tray = [ "<Super>m" ];
    };
  };
}
