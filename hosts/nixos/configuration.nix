# NixOS manual: 'nixos-help'
# 'man configuration.nix'

{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  hardware.bluetooth.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Seoul";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "kr";
    variant = "kr104";
    options = "lv3:ralt_alt";
  };
  # services.xserver.libinput.enable = true;
  # services.tuned.enable = true;
  # services.upower.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ko_KR.UTF-8/UTF-8"
    ];
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ hangul ];
    };
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.hyprland.enable = true;

  # Sounds
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Other services
  services.fprintd.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;

  services.tailscale = {
    enable = true;
    package = pkgs-unstable.tailscale;
  };
  services.solaar.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    jq
  ];
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  # Fonts
  fonts.packages = with pkgs; [
    nanum
    pretendard
    # Nerd Fonts
    nerd-fonts.d2coding
    nerd-fonts.fira-code
  ];
  # Programs
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "yeong" ];

  programs.git.enable = true;
  programs.git.config = {
    "gpg \"ssh\"" = {
      program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
    };
  };
  programs.nix-ld.enable = true;

  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      rootless.enable = true;
      rootless.setSocketVariable = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.yeong = {
    isNormalUser = true;
    description = "Junyeong Heo";
    extraGroups = [
      "input"
      "networkmanager"
      "wheel"
      # container
      "docker"
      "podman"
    ];
    packages = with pkgs; [
      # thunderbird
    ];
  };

  system.stateVersion = "25.11";
}
