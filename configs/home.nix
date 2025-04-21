{ config, pkgs, ... }:

{
  home = {
    username = "yeong";
    homeDirectory = "/home/yeong";
    stateVersion = "24.11";
    packages = with pkgs; [
      bat
      btop
      delta
      difftastic
      direnv
      eza
      fastfetch
      fnm
      fzf
      lazydocker
      lazygit
      neovim
      oh-my-posh
      ripgrep
      stow
      uv
      yazi
      zoxide
    ];
    file = { };
    sessionVariables = { };
  };

  programs.home-manager.enable = true;
}
