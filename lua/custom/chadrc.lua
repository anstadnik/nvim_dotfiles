local M = {}

M.ui = {
  theme_toggle = { "onenord", "one_light" },
  theme = "onenord",
  transparency=true,
  tabufline = {
    lazyload = false,
  },
}

local pluginConfs = require "custom.plugins.configs"

M.plugins = {
  -- remove
  ["NvChad/nvim-colorizer.lua"] = false,
  ["williamboman/mason.nvim"] = false,
}

local over_plugins = {
  { "nvim-treesitter/nvim-treesitter", pluginConfs.treesitter },
  { "hrsh7th/nvim-cmp", pluginConfs.nvimcmp },
  { "nvim-telescope/telescope.nvim", pluginConfs.telescope },
  { "kyazdani42/nvim-tree.lua", pluginConfs.nvimtree },
  { "lewis6991/gitsigns.nvim", pluginConfs.gitsigns },
  { "L3MON4D3/LuaSnip", pluginConfs.luasnip },
}

for _, v in ipairs(over_plugins) do
  M.plugins[v[1]] = { override_options = v[2] }
end

local cust_plugins = require "custom.plugins"
for k, v in pairs(cust_plugins) do
  M.plugins[k] = v
end

M.mappings = require "custom.mappings"

return M
