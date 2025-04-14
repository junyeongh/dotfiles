return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    },
  },
  config = function()
    local markdownlint = require("lint").linters.markdownlint
    markdownlint.args = {
      "--disable",
      "MD004",
      "md010",
      "md018",
      "md024",
      "md026",
      "md028",
      "md029",
      "md031",
      "md033",
      "md036",
      "md040",
      "md041",
      "md045",
      "md051",
      "md053",
      "--", -- Required
    }
  end,
}
