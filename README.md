# Dotfiles

```shell
cd ~/dotfiles
stow -D . # Unlink all
stow . # Link all
```

## [Homebrew](https://brew.sh/) for linux

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```shell
brew bundle dump
brew bundle
```

## Install Programming Languages

### Install Rust

<https://www.rust-lang.org/tools/install/>

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Install Haskell

<https://www.haskell.org/ghcup/>

```bash
sudo apt install build-essential curl libffi-dev libffi8 libgmp-dev libgmp10 libncurses-dev pkg-config
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

### Install Clojure

<https://clojure.org/guides/install_clojure/>

```bash
sudo apt install
curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
chmod +x linux-install.sh
sudo ./linux-install.sh
```
