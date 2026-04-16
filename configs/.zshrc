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
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi
if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
if command -v oh-my-posh &>/dev/null; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/negligible_edit.toml)"
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/{theme}.omp.json')"
  # themes = [kushal, robbyrussell, di4am0nd, negligible]
fi
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# Alias definitions
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi
if [ -f ~/.aliases.local ]; then
  . ~/.aliases.local
fi
# worktrunk
if command -v git-wt >/dev/null 2>&1; then eval "$(command git-wt config shell init zsh)"; fi
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
####################################################################################################
# Programming languages and runtimes

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
