return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    config = require "plugins.configs.lspconfig",
  },
  {
    "simrat39/symbols-outline.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup { automatic_installation = true }
    end,
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    ft = { "rust", "py" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lsp_lines").setup {
        virtual_text = false,
      }
    end,
  },
  "simrat39/rust-tools.nvim",
  {
    "Saecki/crates.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    event = "BufEnter Cargo.toml",
    config = function()
      require "null-ls"
      require("crates").setup { null_ls = { enabled = true } }
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("nvim-navic").setup {
        highlight = true,
      }
    end,
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
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {}
    end,
  },
  {
    "znck/grammarly",
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
