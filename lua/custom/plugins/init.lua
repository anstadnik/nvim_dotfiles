return {
  ['machakann/vim-sandwich'] = { keys = { "sa", "sd", "sr" } },
  ['simrat39/rust-tools.nvim'] = {
    module = "rust-tools",
    -- [[ requires = { 'nvim-lua/plenary.nvim' }, ]]
  },
  ['Saecki/crates.nvim'] = {
    requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
    ft = "toml",
    config = function()
      require('null-ls')
      require('crates').setup { null_ls = { enabled = true, }, }
    end
  },
  ['folke/trouble.nvim'] = {
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end,
  },
  ['numToStr/Navigator.nvim'] = {
    config = function()
      require('Navigator').setup({ disable_on_zoom = true })
    end
  },
  ['junegunn/vim-easy-align'] = {
    -- keys = "ga"
  },
  ['nvim-treesitter/nvim-treesitter-textobjects'] = {
    after = "nvim-treesitter"
  },
  ['chaoren/vim-wordmotion'] = {},
  ['rhysd/clever-f.vim'] = {},
  ['tpope/vim-fugitive'] = {},
  ['nvim-telescope/telescope-ui-select.nvim'] = {
    after = 'telescope.nvim',
    config = function()
      require("telescope").load_extension("ui-select")
    end
  },

  ["Maan2003/lsp_lines.nvim"] =
  {
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
  ["tzachar/cmp-tabnine"] = {
    run = './install.sh', after = 'nvim-cmp'
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    requires = "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = false,
      })
    end
  },

  -- ["anstadnik/luasnip-latex-snippets.nvim"] = {
  --   -- ft = "tex",
  --   after = "LuaSnip"
  -- },

  -- Override
  ["nvim-telescope/telescope.nvim"] = {
    event = "BufRead",
  },
  ["L3MON4D3/LuaSnip"] = {
    config = function()
      require("plugins.configs.others").luasnip()
      require('luasnip.loaders.from_lua').lazy_load()
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
}
