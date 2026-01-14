# Dotfiles

```shell
# Clone this repository to your home directory
cd ~/dotfiles

# After installing Nix and Home Manager and run the following command to set up Home Manager
dotter undeploy # Unlink all
dotter deploy   # Link all
```

## Nix

[Download | Nix & NixOS](https://nixos.org/download/)
[NixOS Search - Packages](https://search.nixos.org/packages)

```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```

[Home Manager Manual](https://nix-community.github.io/home-manager/index.xhtml)

```shell
# Install using nix-channel (recommended)
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
# Uninstall using nix-channel
nix-channel --remove home-manager
```
<!--
```shell
# Install Home Manager using flakes
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- switch -f ~/dotfiles/configs/.config/home-manager/home.nix
``` -->

```shell
# After installing home-manager, update packages using:
home-manager switch
```

[NixOS Search - Packages](https://search.nixos.org/packages)
