return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/symbols-outline.nvim", "williamboman/mason-lspconfig.nvim" },
    config = require "plugins.configs.lspconfig",
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  { "williamboman/mason.nvim", dependencies = "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true,
      }
    end,
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    ft = { "rust", "py" },
    config = function()
      require("lsp_lines").setup {
        virtual_text = false,
      }
    end,
  },
  "simrat39/rust-tools.nvim",
  {
    "Saecki/crates.nvim",
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
}
