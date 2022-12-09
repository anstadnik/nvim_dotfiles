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
  ["machakann/vim-sandwich"] = { keys = { "sa", "sd", "sr" } },
  ["kkoomen/vim-doge"] = {
    keys = { "D" },
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

  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
    ft = { "rust", "py" },
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
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
  ["RishabhRD/nvim-cheat.sh"] = {
    requires = "RishabhRD/popfix",
    config = function()
      require("core.utils").load_mappings "cheat_sh"
    end,
  },

  -- ["github/copilot.vim"] = {},

  ["zbirenbaum/copilot.lua"] = {
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("copilot").setup()
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
  ["petertriho/cmp-git"] = {
    after = "nvim-cmp",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("cmp_git").setup()
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
      vim.g.slime_target = "tmux"
      require("core.utils").load_mappings "slime"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{left-of}" }
      -- vim.g.slime_default_config = { socket_name = "default", target_pane = ":" }
    end,
  },
  -- ["ja-ford/delaytrain.nvim"] = {
  --   config = function()
  --     require("delaytrain").setup()
  --   end,
  -- },
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
