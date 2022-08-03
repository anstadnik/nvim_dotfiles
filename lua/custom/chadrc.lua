local M = {}

M.ui = {
  theme_toggle = { "onenord", "one_light" },
  theme = "onenord",
  tabufline = {
    lazyload = false,
  }
}

local pluginConfs = require "custom.plugins.configs"

M.plugins = {
  remove = {
    "NvChad/nvim-colorizer.lua",
    "williamboman/mason.nvim",
    -- "neovim/nvim-lspconfig"
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
    ["hrsh7th/nvim-cmp"] = pluginConfs.nvimcmp,
    ["nvim-telescope/telescope.nvim"] = pluginConfs.telescope,
    ["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
    ["lewis6991/gitsigns.nvim"] = pluginConfs.gitsigns,
    ["L3MON4D3/LuaSnip"] = pluginConfs.luasnip,
  },
  user = require "custom.plugins",
}

M.mappings = require "custom.mappings"

return M
