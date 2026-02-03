# Dotfiles

```shell
# Clone this repository to your home directory
cd ~/dotfiles

# For NixOS environment, run
nixos-rebuild switch --flake .#nixos

# For non-NixOS environment,
# Install Nix and home-manager using nix flake
nix --extra-experimental-features "nix-command flakes" \
  run nixpkgs#home-manager -- switch --flake .#{attribute-name}

# Then, run the following command to apply configurations
dotter undeploy # Unlink all
dotter deploy   # Link all
```

## Nix

[Download | Nix & NixOS](https://nixos.org/download/)

```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```

[Home Manager Manual](https://nix-community.github.io/home-manager/index.xhtml)

```shell
# Install home-manager using nix-channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# Uninstall home-manager installed using nix-channel
nix-channel --remove home-manager
nix-channel --update
# (Optional) Clean up generations
nix-collect-garbage -d
```

```shell
# To update packages, run
cd ~/dotfiles

# For NixOS environment, rebuild the system
sudo nixos-rebuild switch --flake .#{attribute-name}
# For non-NixOS environment, apply home-manager configurations
home-manager switch --flake .#{attribute-name}
```

[NixOS Search - Packages](https://search.nixos.org/packages)
