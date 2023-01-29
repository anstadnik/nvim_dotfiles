return {
  {
    "nvim-lua/plenary.nvim",
    dependencies = {
      "Saecki/crates.nvim",
      "nvim-telescope/telescope.nvim",
      "L3MON4D3/LuaSnip",
      "phaazon/mind.nvim",
      "akinsho/flutter-tools.nvim",
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = {
      "nvim-tree/nvim-tree.lua",
      "nvim-lualine/lualine.nvim",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup {
        sources = {
          require("null-ls").builtins.formatting.black,
          require("null-ls").builtins.formatting.isort,
          require("null-ls").builtins.formatting.ruff,
          require("null-ls").builtins.diagnostics.ruff,
          require("null-ls").builtins.formatting.stylua,
          -- require("null-ls").builtins.formatting.shfmt,
          require("null-ls").builtins.formatting.beautysh,
        },
      }
    end,
    dependencies = {
      "Saecki/crates.nvim",
      "nvim-tree/nvim-tree.lua",
    },
  },
}
