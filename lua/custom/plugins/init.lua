return {
  ["machakann/vim-sandwich"] = { keys = { "sa", "sd", "sr" } },
  ["kkoomen/vim-doge"] = {
    keys = { "<leader>d" },
    run = ":call doge#install()",
  },
  ["will133/vim-dirdiff"] = {
    command = "DirDiff",
  },
  ["simrat39/rust-tools.nvim"] = {
    module = "rust-tools",
    -- [[ requires = { 'nvim-lua/plenary.nvim' }, ]]
  },
  -- ["akinsho/flutter-tools.nvim"] = {
  --   module = "flutter-tools",
  -- },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    module = "null-ls",
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
  },
  ["Saecki/crates.nvim"] = {
    requires = { "nvim-lua/plenary.nvim", "jose-elias-alvarez/null-ls.nvim" },
    event = "BufEnter Cargo.toml",
    config = function()
      require "null-ls"
      require("crates").setup { null_ls = { enabled = true } }
    end,
  },
  ["folke/trouble.nvim"] = {
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end,
  },
  ["numToStr/Navigator.nvim"] = {
    config = function()
      require("Navigator").setup { disable_on_zoom = true }
    end,
  },
  ["junegunn/vim-easy-align"] = {
    -- keys = "ga"
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
  },
  ["chaoren/vim-wordmotion"] = {},
  ["rhysd/clever-f.vim"] = {},
  ["tpope/vim-fugitive"] = {},
  ["nvim-telescope/telescope-ui-select.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  ["Maan2003/lsp_lines.nvim"] = {
    ft = { "rust", "py" },
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.

      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }
    end,
  },
  ["tzachar/cmp-tabnine"] = {
    run = "./install.sh",
    after = "nvim-cmp",
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    requires = "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true,
      }
    end,
  },

  -- Override
  ["nvim-telescope/telescope.nvim"] = {
    event = "BufRead",
  },
  ["L3MON4D3/LuaSnip"] = {
    config = function()
      local present, luasnip = pcall(require, "luasnip")

      if not present then
        return
      end

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/luasnippets" }

      vim.keymap.set("i", "<C-u>", function()
        if require("luasnip").choice_active() then
          require "luasnip.extras.select_choice"()
        end
      end)

      require("luasnip").config.setup {
        ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          [require("luasnip.util.types").insertNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
          },
        },
        history = true,
        updateevents = "TextChanged,TextChangedI",
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "LuasnipChoiceNodeEnter",
        callback = function()
          if require("luasnip").choice_active() then
            vim.schedule(require "luasnip.extras.select_choice")
            -- vim.defer_fn(require "luasnip.extras.select_choice", 200)
          end
        end,
      })
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["simrat39/symbols-outline.nvim"] = {
    config = function()
      require("symbols-outline").setup()
    end,
  },
}
