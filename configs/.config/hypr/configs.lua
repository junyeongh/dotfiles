for _, m in ipairs({
  "appearances",
  "inputs",
  "keybindings",
  "monitors",
  "plugins",
  "window_rules",
  "workspace_rules",
}) do
  require("configs." .. m)
end
