local colorschemes = {
  { -- github-theme
    "projekt0n/github-nvim-theme",
    lazy = true,
    name = "github-theme",
  },
}

return {
  { colorschemes },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark",
    },
  },
}
