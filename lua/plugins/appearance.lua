return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        native_lsp = { enabled = true },
        -- navic = { enabled = false },
      }
      vim.cmd.colorscheme "catppuccin"
      vim.opt.background = "light"
    end,
  },
  -- {
  --   "rmehri01/onenord.nvim",
  --   depended = "f-person/auto-dark-mode.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("onenord").setup {
  --       styles = {
  --         comments = "italic",
  --         keywords = "none",
  --         functions = "bold",
  --         strings = "none",
  --         variables = "none",
  --       },
  --       disable = { background = true },
  --     }
  --   end,
  -- },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = function()
      return vim.fn.has "macunix"
    end,
    depencies = { "catppuccin/nvim" },
    config = function()
      local auto_dark_mode = require "auto-dark-mode"

      auto_dark_mode.setup {
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option("background", "dark")
          vim.fn.system { "kitty", "+kitten", "themes", "Catppuccin-Mocha" }
        end,
        set_light_mode = function()
          vim.api.nvim_set_option("background", "light")
          vim.fn.system { "kitty", "+kitten", "themes", "Catppuccin-Latte" }
        end,
      }
      auto_dark_mode.init()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        theme = "catppuccin",
        options = {
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_c = {
            "filename",
            -- {
            --   require("nvim-navic").get_location,
            --   cond = require("nvim-navic").is_available,
            -- },
          },
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
  -- {
  --   "nanozuki/tabby.nvim",
  --   config = function()
  --     require("tabby.tabline").use_preset("active_tab_with_wins", {})
  --   end,
  -- },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin",
    },
    config = function()
      require("bufferline").setup {
        options = {
          mode = "tabs",
          separator_style = "slope",
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
          diagnostidcs = "nvim_lsp",
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
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
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)

      require("ufo").setup()
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    enabled = function()
      return vim.fn.has "nvim-0.9" == 1
    end,
    config = function()
      require("statuscol").setup {
        foldfunc = "builtin",
        setopt = true,
      }
    end,
  },
  {
    "Pocco81/true-zen.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    config = function()
      require("true-zen").setup {
        integrations = {
          tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
          kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
            enabled = true,
            font = "+3",
          },
          twilight = true, -- enable twilight (ataraxis)
          lualine = true, -- hide nvim-lualine (ataraxis)
        },
      }
    end,
  },
}
