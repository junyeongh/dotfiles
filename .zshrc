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
# Alias definitions
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

####################################################################################################
# Programming languages and runtimes

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# alias cargo_upgrade="cargo install $(cargo install --list | awk '/:$/ { print $1; }')"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
