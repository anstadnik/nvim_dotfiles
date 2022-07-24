local M = {}

M.ui = {
  theme_toggle = { "onenord", "onenord_light" },
  theme = "onenord",
  tabufline = {
    lazyload = false,
  }
}

M.options = {
  user = function()
    require "custom.options"
  end,
}

local pluginConfs = require "custom.plugins.configs"

M.plugins = {
  -- remove = { "lewis6991/gitsigns.nvim" },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
    ["hrsh7th/nvim-cmp"] = pluginConfs.nvimcmp,
    ["nvim-telescope/telescope.nvim"] = pluginConfs.telescope,
    ["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
    ["lewis6991/gitsigns.nvim"] = pluginConfs.gitsigns,
    ["L3MON4D3/LuaSnip"] = pluginConfs.luasnip,
  },
  user = require "custom.plugins",
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },

}

M.mappings = require "custom.mappings"

return M
