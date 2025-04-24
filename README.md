# Dotfiles

```shell
cd ~/dotfiles

# After installing Nix,
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- switch -f configs/home.nix
# or
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- switch --flake ./configs#yeong

stow -D configs # Unlink all
stow configs    # Link all
```

## Nix

[Download | Nix & NixOS](https://nixos.org/download/)

```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```

[Home Manager Manual](https://nix-community.github.io/home-manager/index.xhtml)

<!--
# Install using nix profile
nix profile install nixpkgs#home-manager
-->
```shell
# Install using nix-channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# After installing home-manager, update packages using:
home-manager switch -f home.nix
# or
home-manager switch --flake flake.nix
```

[NixOS Search - Packages](https://search.nixos.org/packages)

---

## [Homebrew](https://brew.sh/) for linux (deprecated; replaced with Nix)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```shell
brew bundle dump
brew bundle
```
