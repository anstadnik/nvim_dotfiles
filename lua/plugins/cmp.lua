return {
  {
    "hrsh7th/nvim-cmp",
    config = require "plugins.configs.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "tzachar/cmp-tabnine",
      "petertriho/cmp-git",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    config = function()
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/luasnippets" }
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
          end
        end,
      })
    end,
  },

  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- misc plugins
  { "tzachar/cmp-tabnine", build = "./install.sh" },
  {
    "petertriho/cmp-git",
    config = function()
      require("cmp_git").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      vim.schedule(function()
        -- require("copilot").setup {}
        require("copilot").setup {
          suggestion = { auto_trigger = true },
          filetypes = {
            yaml = false,
            markdown = true,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
          },
        }
      end)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()

      local lspkind = require "lspkind"
      lspkind.init {
        symbol_map = {
          Copilot = "",
        },
      }

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
  { "onsails/lspkind.nvim", dependencies = "zbirenbaum/copilot-cmp" },
}
