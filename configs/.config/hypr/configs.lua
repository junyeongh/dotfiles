for _, m in ipairs({
  "appearances",
  "inputs",
  "keybindings",
  "monitors",
  "window_rules",
  "workspace_rules",
}) do
  require("configs." .. m)
end