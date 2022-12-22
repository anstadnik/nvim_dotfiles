return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {

        transparent = true,
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "bold",
          strings = "none",
          variables = "none",
        },
      }
      require("onedark").load()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
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
  {
    "rcarriga/nvim-notify",
    dependencies = {
      "folke/noice.nvim",
    },
  },
  {
    "folke/noice.nvim",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
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
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "rcarriga/nvim-notify",
    },
  },
}
