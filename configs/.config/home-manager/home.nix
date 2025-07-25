{ config, pkgs, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "25.05";
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
      git-lfs
      just
      lazydocker
      lazygit
      neovim
      oh-my-posh
      ripgrep
      stow
      uv
      zoxide
    ];
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
