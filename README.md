# Dotfiles

```shell
# Clone this repository to your home directory
cd ~/dotfiles

# After installing Nix and Home Manager and run the following command to set up Home Manager
stow --delete configs # Unlink all
stow configs          # Link all
```

```shell
# stow options
-S, --stow            Stow the package names that follow this option
-D, --delete          Unstow the package names that follow this option
-R, --restow          Restow (like stow -D followed by stow -S)
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

---

## [Homebrew](https://brew.sh/) for Linux (deprecated)

Managing CLI tools is replaced with Nix + Home Manager

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

<https://docs.brew.sh/>
```shell
# List installed formulae that are not dependencies of another installed formula or cask.
brew leaves

# Bundler for non-Ruby dependencies from Homebrew, Homebrew Cask, Mac App Store, Whalebrew and Visual Studio Code (and forks/variants).
brew bundle dump
brew bundle
```
