# Command Not Found - Manually from PowerToys
# #f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound

# if (Get-Command {{command}} -ErrorAction SilentlyContinue) {}
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
  Invoke-Expression (&oh-my-posh init pwsh --config '~\.config\oh-my-posh\negligible_edit.toml')
  # oh-my-posh (themes: https://ohmyposh.dev/docs/themes)
  # config: 'C:\Program Files (x86)\oh-my-posh\themes\{theme}.omp.json'
  # theme in themes = [kushal, quick-term, robbyrussell, tokyo]
}
if (Get-Command fnm -ErrorAction SilentlyContinue) {
  # Fast and simple Node.js version manager, built in Rust
  Invoke-Expression (&fnm env --use-on-cd --shell powershell | Out-String)
}
if (Get-Command git-wt -ErrorAction SilentlyContinue) {
  Invoke-Expression (&git-wt config shell init powershell | Out-String)
  if (Get-Command wt -ErrorAction SilentlyContinue) {
    Invoke-Expression (&wt config shell init powershell | Out-String)
  }
}
if (Get-Command mise -ErrorAction SilentlyContinue) {
  Invoke-Expression (&mise activate pwsh | Out-String)
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (&zoxide init powershell | Out-String )
}

# Alias
Function Set-ProfileAlias {
  param(
    [Parameter(Mandatory)] [string] $Name,
    [Parameter(Mandatory)] [string] $FunctionName,
    [Parameter(Mandatory)] [scriptblock] $ScriptBlock
  )

  Set-Item -Path "Function:$FunctionName" -Value $ScriptBlock
  Set-Alias -Name $Name -Value $FunctionName -Force
}


if (Get-Command git -ErrorAction SilentlyContinue) {
  Set-ProfileAlias -Name gaa -FunctionName Invoke-GitAddAll -ScriptBlock { git add . @args }
  Set-ProfileAlias -Name gaaa -FunctionName Invoke-GitAddEverything -ScriptBlock { git add --all @args }
  Set-ProfileAlias -Name gau -FunctionName Invoke-GitAddUpdated -ScriptBlock { git add --update @args }
  Set-ProfileAlias -Name gb -FunctionName Invoke-GitBranch -ScriptBlock { git branch @args }
  Set-ProfileAlias -Name gbd -FunctionName Invoke-GitBranchDelete -ScriptBlock { git branch --delete @args }
  Set-ProfileAlias -Name gc -FunctionName Invoke-GitCommit -ScriptBlock { git commit @args }
  Set-ProfileAlias -Name gcf -FunctionName Invoke-GitCommitFixup -ScriptBlock { git commit --fixup @args }
  Set-ProfileAlias -Name gcm -FunctionName Invoke-GitCommitMessage -ScriptBlock { git commit --message @args }
  Set-ProfileAlias -Name gco -FunctionName Invoke-GitCheckout -ScriptBlock { git checkout @args }
  Set-ProfileAlias -Name gcob -FunctionName Invoke-GitCheckoutBranch -ScriptBlock { git checkout -b @args }
  Set-ProfileAlias -Name gcod -FunctionName Invoke-GitCheckoutDevelop -ScriptBlock { git checkout develop @args }
  Set-ProfileAlias -Name gcom -FunctionName Invoke-GitCheckoutMaster -ScriptBlock { git checkout master @args }
  Set-ProfileAlias -Name gcos -FunctionName Invoke-GitCheckoutStaging -ScriptBlock { git checkout staging @args }
  Set-ProfileAlias -Name gd -FunctionName Invoke-GitDiff -ScriptBlock { git diff @args }
  Set-ProfileAlias -Name gda -FunctionName Invoke-GitDiffHead -ScriptBlock { git diff HEAD @args }
  Set-ProfileAlias -Name gi -FunctionName Invoke-GitInit -ScriptBlock { git init @args }
  Set-ProfileAlias -Name gld -FunctionName Invoke-GitLogDates -ScriptBlock { git log '--pretty=format:%h %ad %s' --date=short --all @args }
  Set-ProfileAlias -Name glg -FunctionName Invoke-GitLogGraph -ScriptBlock { git log --graph --oneline --decorate --all @args }
  Set-ProfileAlias -Name gm -FunctionName Invoke-GitMerge -ScriptBlock { git merge --no-ff @args }
  Set-ProfileAlias -Name gma -FunctionName Invoke-GitMergeAbort -ScriptBlock { git merge --abort @args }
  Set-ProfileAlias -Name gmc -FunctionName Invoke-GitMergeContinue -ScriptBlock { git merge --continue @args }
  Set-ProfileAlias -Name gp -FunctionName Invoke-GitPull -ScriptBlock { git pull @args }
  Set-ProfileAlias -Name gpr -FunctionName Invoke-GitPullRebase -ScriptBlock { git pull --rebase @args }
  Set-ProfileAlias -Name gr -FunctionName Invoke-GitRebase -ScriptBlock { git rebase @args }
  Set-ProfileAlias -Name gs -FunctionName Invoke-GitStatus -ScriptBlock { git status @args }
  Set-ProfileAlias -Name gss -FunctionName Invoke-GitStatusShort -ScriptBlock { git status --short @args }
  Set-ProfileAlias -Name gst -FunctionName Invoke-GitStash -ScriptBlock { git stash @args }
  Set-ProfileAlias -Name gsta -FunctionName Invoke-GitStashApply -ScriptBlock { git stash apply @args }
  Set-ProfileAlias -Name gstd -FunctionName Invoke-GitStashDrop -ScriptBlock { git stash drop @args }
  Set-ProfileAlias -Name gstl -FunctionName Invoke-GitStashList -ScriptBlock { git stash list @args }
  Set-ProfileAlias -Name gstp -FunctionName Invoke-GitStashPop -ScriptBlock { git stash pop @args }
  Set-ProfileAlias -Name gsts -FunctionName Invoke-GitStashSave -ScriptBlock { git stash --staged @args }
  Set-ProfileAlias -Name gwa -FunctionName Invoke-GitWorktreeRemove -ScriptBlock { git worktree add @args }
  Set-ProfileAlias -Name gwr -FunctionName Invoke-GitWorktreeRemove -ScriptBlock { git worktree remove @args }
  Set-ProfileAlias -Name gwl -FunctionName Invoke-GitWorktreeList -ScriptBlock { git worktree list @args }
}

if (Get-Command cargo -ErrorAction SilentlyContinue) {
  Set-ProfileAlias -Name cargo-upgrade -FunctionName Update-CargoPackages -ScriptBlock {
    $Packages = cargo install --list |
    Where-Object { $_ -match ':$' } |
    ForEach-Object { ($_ -replace ':$').Trim() }

    if ($Packages.Count -gt 0) {
      cargo install @Packages @args
    }
  }
}

if (Get-Command claude -ErrorAction SilentlyContinue) {
    Set-ProfileAlias -Name claudex -FunctionName Invoke-ClaudeUnsafe -ScriptBlock {
        claude --dangerously-skip-permissions @args
    }
}

if (Get-Command eza -ErrorAction SilentlyContinue) {
    if (Test-Path Alias:ls) { Remove-Item Alias:ls -Force }

    Set-ProfileAlias -Name ls -FunctionName Invoke-EzaList -ScriptBlock {
        eza -all --icons --git --header --group-directories-first --sort=type @args
    }
    Set-ProfileAlias -Name tree -FunctionName Invoke-EzaTree -ScriptBlock {
        eza -all --tree @args
    }
}


if (Get-Command fzf -ErrorAction SilentlyContinue) {
    Set-ProfileAlias -Name fzfp -FunctionName Invoke-FzfPreview -ScriptBlock {
        fzf --preview 'bat --color=always --style=header,grid --line-range :500 {}' @args
    }
}

if (Get-Command gh -ErrorAction SilentlyContinue) {
    gh auth status *> $null
    if ($LASTEXITCODE -eq 0) {
        $env:GITHUB_TOKEN = gh auth token
        $env:MISE_GITHUB_TOKEN = $env:GITHUB_TOKEN
    }
}

if (Get-Command lazydocker -ErrorAction SilentlyContinue) {
    Set-ProfileAlias -Name ld -FunctionName Invoke-LazyDocker -ScriptBlock { lazydocker @args }
}

if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-ProfileAlias -Name lg -FunctionName Invoke-LazyGit -ScriptBlock { lazygit @args }
}

if (Get-Command pnpm -ErrorAction SilentlyContinue) {
    Set-ProfileAlias -Name pnpm-up -FunctionName Invoke-Pnpm -ScriptBlock {
        pnpm update --global --latest @args
    }
}
