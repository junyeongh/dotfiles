{ lib, pkgs, ... }:

{
  home.packages = lib.mkAfter (import ./packages.nix { inherit pkgs; });
  home.enableNixpkgsReleaseCheck = false;

  services.tailscale-systray.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      move-to-monitor-down = [ "<Super><Shift>Down" ];
      move-to-monitor-left = [ "<Super><Shift>Left" ];
      move-to-monitor-right = [ "<Super><Shift>Right" ];
      move-to-monitor-up = [ "<Super><Shift>Up" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-down = [ "<Control><Shift><Alt>Down" ];
      move-to-workspace-left = [ "<Super><Shift>Page_Up" ];
      move-to-workspace-right = [ "<Super><Shift>Page_Down" ];
      move-to-workspace-up = [ "<Control><Shift><Alt>Up" ];
      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
      switch-panels = [ "<Control><Alt>Tab" ];
      switch-panels-backward = [ "<Shift><Control><Alt>Tab" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-down = [ "" ];
      switch-to-workspace-last = [ "<Super>End" ];
      switch-to-workspace-left = [ "<Control><Alt>Left" ];
      switch-to-workspace-right = [ "<Control><Alt>Right" ];
      switch-to-workspace-up = [ "" ];
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ "<Super>n" ];
      open-new-window-application-1 = [ "<Shift><Alt>1" ];
      open-new-window-application-2 = [ "<Shift><Alt>2" ];
      open-new-window-application-3 = [ "<Shift><Alt>3" ];
      open-new-window-application-4 = [ "<Shift><Alt>4" ];
      open-new-window-application-5 = [ "<Shift><Alt>5" ];
      open-new-window-application-6 = [ "<Shift><Alt>6" ];
      open-new-window-application-7 = [ "<Shift><Alt>7" ];
      open-new-window-application-8 = [ "<Shift><Alt>8" ];
      open-new-window-application-9 = [ "<Shift><Alt>9" ];
      shift-overview-down = [ "<Super><Alt>Down" ];
      shift-overview-up = [ "<Super><Alt>Up" ];
      show-screen-recording-ui = [ "<Shift>Print" ];
      show-screenshot-ui = [ "Print" ];
      switch-to-application-1 = [ "<Alt>1" ];
      switch-to-application-2 = [ "<Alt>2" ];
      switch-to-application-3 = [ "<Alt>3" ];
      switch-to-application-4 = [ "<Alt>4" ];
      switch-to-application-5 = [ "<Alt>5" ];
      switch-to-application-6 = [ "<Alt>6" ];
      switch-to-application-7 = [ "<Alt>7" ];
      switch-to-application-8 = [ "<Alt>8" ];
      switch-to-application-9 = [ "<Alt>9" ];
      toggle-message-tray = [ "<Super>m" ];
    };
  };
}
