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
# Homebrew for Linux

if [ -d "/home/linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if command -v eza &>/dev/null; then
        alias ls='eza -all --icons --git --header --group-directories-first --sort=type'
        alias tree='eza -all --tree'
    fi
    if command -v fnm &>/dev/null; then
        eval "$(fnm env --use-on-cd --shell zsh)"
    fi
    if command -v fzf &>/dev/null; then
        alias fzfp='fzf --preview "batcat --color=always --style=header,grid --line-range :500 {}"'
    fi
    if command -v lazygit &>/dev/null; then
        alias lg='lazygit'
    fi
    if command -v oh-my-posh &>/dev/null; then
        eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/negligible_edit.toml)"
        # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/{theme}.omp.json')"
        # themes = [kushal, robbyrussell, di4am0nd, negligible]
    fi
    if command -v zoxide >/dev/null; then
        eval "$(zoxide init zsh)"
        alias z='zoxide'
    fi
fi

####################################################################################################
# Programming languages and runtimes

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# alias cargo_upgrade="cargo install $(cargo install --list | awk '/:$/ { print $1; }')"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

####################################################################################################
## Git aliases

alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout develop'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# Other Aliases
alias mkdir='mkdir -pv'

function cd_ls() {
    builtin cd "$@" && ls -al
}
alias cd='cd_ls'
