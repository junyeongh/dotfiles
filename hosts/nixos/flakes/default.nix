{ ... }:
let
  entries = builtins.readDir ./.;
  nixFiles = builtins.filter (
    name:
    entries.${name} == "regular"
    && name != "default.nix"
    && builtins.match ".*\\.nix" name != null
  ) (builtins.attrNames entries);
in
{
  imports = map (name: ./. + "/${name}") nixFiles;
}
