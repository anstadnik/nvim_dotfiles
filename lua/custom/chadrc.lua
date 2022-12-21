local M = {}

M.ui = {
  theme_toggle = { "onenord", "one_light" },
  theme = "onenord",
  transparency = true,
  tabufline = {
    lazyload = false,
  },
}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

return M
