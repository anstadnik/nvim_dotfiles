return {
  {
    "nvim-lua/plenary.nvim",
    dependencies = {
      "Saecki/crates.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
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
          require("null-ls").builtins.formatting.stylua,
          require("null-ls").builtins.formatting.shfmt,
        },
      }
    end,
    dependencies = {
      "Saecki/crates.nvim",
      "nvim-tree/nvim-tree.lua",
    },
  },
}
