{ config, pkgs, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "24.11";
    packages = with pkgs; [ # https://search.nixos.org/packages
      bat
      btop
      delta
      difftastic
      direnv
      eza
      fastfetch
      fnm
      fzf
      git
      lazydocker
      lazygit
      neovim
      oh-my-posh
      ripgrep
      stow
      uv
      yazi
      zoxide

      # GUI tools
      # discord
      # firefox
      # slack
      # spotify
    ];
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
