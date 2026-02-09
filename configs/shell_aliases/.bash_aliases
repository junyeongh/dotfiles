# Bash aliases

if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi
if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell bash)"
fi
if command -v oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/negligible_edit.toml)"
    # eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/{theme}.omp.json')"
    # themes = [kushal, robbyrussell, di4am0nd, negligible]
fi
if command -v wt >/dev/null 2>&1; then
    eval "$(command wt config shell init bash)"
fi

if command -v zoxide >/dev/null; then
    eval "$(zoxide init bash)"
    alias z='zoxide'
fi