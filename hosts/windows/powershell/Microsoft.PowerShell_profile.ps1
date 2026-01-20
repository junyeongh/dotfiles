# oh-my-posh (themes: https://ohmyposh.dev/docs/themes)
oh-my-posh init pwsh --config '~\.config\oh-my-posh\negligible_edit.toml' | Invoke-Expression
# oh-my-posh init pwsh --config 'C:\Program Files (x86)\oh-my-posh\themes\{theme}.omp.json' | Invoke-Expression
# theme in themes = [kushal, quick-term, robbyrussell, tokyo]

# Alias
if (Get-Command eza -ErrorAction SilentlyContinue) {
    if (Test-Path Alias:ls) {
        Remove-Item Alias:ls -Force
    }

    Function ls {
        eza -all --icons --git --header --group-directories-first --sort=type $args
    }
    Function tree {
        eza -all --tree
    }
}

# Command Not Found - Manually from PowerToys
# #f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound

# Fast and simple Node.js version manager, built in Rust
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

if (Get-Command wt -ErrorAction SilentlyContinue) { Invoke-Expression (& wt config shell init powershell | Out-String) }
