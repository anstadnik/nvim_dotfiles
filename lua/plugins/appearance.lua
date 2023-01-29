return {
  {
    "rmehri01/onenord.nvim",
    dependencies = "f-person/auto-dark-mode.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onenord").setup {
        styles = {
          comments = "italic",
          keywords = "none",
          functions = "bold",
          strings = "none",
          variables = "none",
        },
        disable = { background = true },
      }
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = function()
      return vim.fn.has "macunix"
    end,
    config = function()
      local auto_dark_mode = require "auto-dark-mode"

      auto_dark_mode.setup {
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option("background", "dark")
          vim.fn.system { "kitty", "+kitten", "themes", "onenord" }
        end,
        set_light_mode = function()
          vim.api.nvim_set_option("background", "light")
          vim.fn.system { "kitty", "+kitten", "themes", "onenord light" }
        end,
      }
      auto_dark_mode.init()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        theme = "onenord",
        options = {
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
        },
      }
    end,
  },
  {
    "nanozuki/tabby.nvim",
    config = function()
      require("tabby.tabline").use_preset("active_tab_with_wins", {})
    end,
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   dependencies = {
  --     "folke/noice.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  {
    "MunifTanjim/nui.nvim",
    dependencies = {
      "folke/noice.nvim",
    },
  },
  {
    "folke/noice.nvim",
    config = function()
      -- require("notify").setup {
      --   background_colour = "#000000",
      --   top_down = false
      -- }
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          -- bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    "KeitaNakamura/tex-conceal.vim",
    filetypes = { "tex" },
  },
  -- {
  --   "luukvbaal/statuscol.nvim",
  --   config = function()
  --     require("statuscol").setup({setopt = true})
  --   end,
  -- },
}
