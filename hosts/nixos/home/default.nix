{ lib, pkgs, ... }:

{
  home.packages = lib.mkAfter (import ./packages.nix { inherit pkgs; });
}
