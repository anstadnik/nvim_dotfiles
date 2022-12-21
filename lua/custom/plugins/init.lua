return {
  -- ["luk400/vim-jukit"] = {
  -- },
  ["goerz/jupytext.vim"] = {
    filetype = "json",
    setup = function()
      -- vim.g.jupytext_print_debug_msgs = false
      vim.g.jupytext_fmt = "py"
    end,
  },

  -- Text editing
  ["machakann/vim-sandwich"] = { keys = { "sa", "sd", "sr" } },
  ["junegunn/vim-easy-align"] = { keys = "ga" },
  ["chaoren/vim-wordmotion"] = {},
  ["rhysd/clever-f.vim"] = {},

  -- ["kkoomen/vim-doge"] = {
  --   keys = { "D" },
  --   config = function()
  --     vim.g.doge_enable_mappings = 0
  --   end,
  --   run = ":call doge#install()",
  -- },

  -- LSP
  ["simrat39/rust-tools.nvim"] = {
    module = "rust-tools",
    -- [[ requires = { 'nvim-lua/plenary.nvim' }, ]]
  },
  ["Saecki/crates.nvim"] = {
    requires = { "nvim-lua/plenary.nvim", "jose-elias-alvarez/null-ls.nvim" },
    event = "BufEnter Cargo.toml",
    config = function()
      require "null-ls"
      require("crates").setup { null_ls = { enabled = true } }
    end,
  },
  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
    ft = { "rust", "py" },
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
    end,
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
  ["folke/trouble.nvim"] = {
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end,
  },

  -- Treesitter
  ["nvim-treesitter/nvim-treesitter-textobjects"] = { after = "nvim-treesitter" },
  ["numToStr/Navigator.nvim"] = {
    config = function()
      require("Navigator").setup { disable_on_zoom = true }
    end,
  },
  ["tpope/vim-fugitive"] = {},
  ["nvim-telescope/telescope-ui-select.nvim"] = {
    event = "VimEnter",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  -- Cmp-related in a comment box
  ["petertriho/cmp-git"] = {
    after = "nvim-cmp",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("cmp_git").setup()
    end,
  },
  ["zbirenbaum/copilot.lua"] = {
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("copilot").setup { suggestion = { auto_trigger = true } }
      end)
    end,
  },
  ["zbirenbaum/copilot-cmp"] = {
    after = { "copilot.lua", "nvim-cmp" },
    module = "copilot_cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Override
  ["rafamadriz/friendly-snippets"] = false,
  ["NvChad/nvim-colorizer.lua"] = false,
  ["williamboman/mason.nvim"] = false,
  ["nvim-treesitter/nvim-treesitter"] = { override_options = require "custom.plugins.configs.treesitter" },
  ["hrsh7th/nvim-cmp"] = {
    after = false,
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
    override_options = require "custom.plugins.configs.cmp",
  },
  ["nvim-telescope/telescope.nvim"] = {
    module = "telescope",
    override_options = function()
      return {
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_cursor {} },
        },
      }
    end,
  },
  ["kyazdani42/nvim-tree.lua"] = { override_options = { diagnostics = { enable = true } } },
  ["lewis6991/gitsigns.nvim"] = { override_options = require "custom.plugins.configs.gitsigns" },
  ["L3MON4D3/LuaSnip"] = require "custom.plugins.configs.luasnip",
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },
  ["simrat39/symbols-outline.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  ["jpalardy/vim-slime"] = {
    filetype = "julia",
    config = function()
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_no_mappings = 1
      vim.g.slime_target = "kitty"
      require("core.utils").load_mappings "slime"
      vim.g.slime_default_config = { listen_on = os.getenv "KITTY_LISTEN_ON", window_id = 1 }
    end,
  },
  ["folke/noice.nvim"] = {
    -- event = "VimEnter",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
      require("noice").setup {
        notify = { enable = false },
        signature = { enable = false },
        hover = { enable = false },
        -- lsp = {
        --   override = {
        --     -- override the default lsp markdown formatter with Noice
        --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        --     -- override the lsp markdown formatter with Noice
        --     ["vim.lsp.util.stylize_markdown"] = true,
        --     -- override cmp documentation with Noice (needs the other options to work)
        --     ["cmp.entry.get_documentation"] = true,
        --   },
        -- },
        -- -- notify = { enabled = false },
      }
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- ["mfussenegger/nvim-dap"] = {
  --   module = { "dapui", "dap" },
  --   config = function()
  --     require("dapui").setup()
  --     require("telescope").load_extension "dap"
  --     require("dap-python").setup "~/.virtualenvs/masters/bin/python"
  --     require("nvim-dap-virtual-text").setup()
  --
  --     -- local dap = require "dap"
  --     -- local api = vim.api
  --     -- local keymap_restore = {}
  --     -- dap.listeners.after["event_initialized"]["me"] = function()
  --     --   for _, buf in pairs(api.nvim_list_bufs()) do
  --     --     local keymaps = api.nvim_buf_get_keymap(buf, "n")
  --     --     for _, keymap in pairs(keymaps) do
  --     --       if keymap.lhs == "K" then
  --     --         table.insert(keymap_restore, keymap)
  --     --         api.nvim_buf_del_keymap(buf, "n", "K")
  --     --       end
  --     --     end
  --     --   end
  --     --   api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
  --     -- end
  --     --
  --     -- dap.listeners.after["event_terminated"]["me"] = function()
  --     --   for _, keymap in pairs(keymap_restore) do
  --     --     api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
  --     --   end
  --     --   keymap_restore = {}
  --     -- end
  --     require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  --       sources = {
  --         { name = "dap" },
  --       },
  --     })
  --   end,
  --   requires = {
  --     "mfussenegger/nvim-dap",
  --     "mfussenegger/nvim-dap-python",
  --     "rcarriga/cmp-dap",
  --     "nvim-telescope/telescope-dap.nvim",
  --     "rcarriga/nvim-dap-ui",
  --     "theHamsta/nvim-dap-virtual-text",
  --   },
  -- },

  -- ["https://gitlab.com/astadnik/snippets"] = {},
  -- ["smjonas/snippet-converter.nvim"] = {
  --   config = function()
  --     local template = {
  --       -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
  --       sources = {
  --         ultisnips = {
  --           -- Add snippets from (plugin) folders or individual files on your runtimepath...
  --           -- "https://gitlab.com/astadnik/snippets",
  --           -- "./latex-snippets/tex.snippets",
  --           -- ...or use absolute paths on your system.
  --           vim.fn.stdpath "config" .. "/snippets/UltiSnips",
  --         },
  --         -- snipmate = {
  --         --   "vim-snippets/snippets",
  --         -- },
  --       },
  --       output = {
  --         -- Specify the output formats and paths
  --         vscode_luasnip = {
  --           vim.fn.stdpath "config" .. "/luasnip_snippets",
  --         },
  --       },
  --     }
  --
  --     require("snippet_converter").setup {
  --       templates = { template },
  --       -- To change the default settings (see configuration section in the documentation)
  --       -- settings = {},
  --     }
  --   end,
  -- },
}
