# Created by newuser for 5.9
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

####################################################################################################
# enable tools
# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/{theme}.omp.json')"
# themes = [kushal, robbyrussell, di4am0nd, negligible]
eval "$(direnv hook zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(herdr completion zsh)"
eval "$(mise activate zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/negligible_edit.toml)"
eval "$(tailscale completion zsh)"
eval "$(zoxide init zsh)"

# Git commit signing goes through op-ssh-sign, which talks to the 1Password GUI
# app on the local display. Over ssh the approval dialog is unreachable and the
# commit just hangs, so drop signing for remote sessions.
# Use `GIT_CONFIG_COUNT=0 git commit -S` to sign anyway.
if [[ -n $SSH_CONNECTION ]]; then
  export GIT_CONFIG_COUNT=1
  export GIT_CONFIG_KEY_0=commit.gpgsign
  export GIT_CONFIG_VALUE_0=false
fi

# Alias definitions
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi
if [ -f ~/.aliases.local ]; then
  . ~/.aliases.local
fi
####################################################################################################
# Programming languages and runtimes

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# `gh auth status` makes a network call (~1s); `gh auth token` is a local
# keyring lookup (~30ms) and already yields nothing when not authenticated.
if command -v gh &>/dev/null; then
  GITHUB_TOKEN=$(gh auth token 2>/dev/null)
  if [[ -n $GITHUB_TOKEN ]]; then
    export GITHUB_TOKEN
    export MISE_GITHUB_TOKEN=$GITHUB_TOKEN
  else
    unset GITHUB_TOKEN
  fi
fi

if command -v nixos-rebuild &>/dev/null; then
  function nixos-up() { sudo nixos-rebuild switch --flake ~/dotfiles#${1:-$(hostname)}; }
fi
