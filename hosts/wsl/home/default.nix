{ lib, pkgs, ... }:

{
  targets.genericLinux.enable = true;

  home.packages = lib.mkAfter (import ./packages.nix { inherit pkgs; });
}
