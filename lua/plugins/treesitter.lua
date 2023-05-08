return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "mrjones2014/nvim-ts-rainbow",
      "RRethy/nvim-treesitter-textsubjects",
      "HiPhish/nvim-ts-rainbow2",
    },
    config = function()
      vim.treesitter.language.register("python", "sage")

      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "rust",
          "python",
          "lua",
          "comment",
          "latex",
          "bash",
          "vim",
          "regex",
          "markdown",
          "markdown_inline",
          "julia",
          "cpp",
        },
        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["aC"] = "@class.outer",
              ["iC"] = "@class.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ae"] = "@block.outer",
              ["ie"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["ad"] = "@comment.outer",
              ["am"] = "@call.outer",
              ["im"] = "@call.inner",
            },
          },
          lsp_interop = {
            enable = true,
            peek_definition_code = {
              ["<C-p>"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>v",
            node_incremental = "<leader>v",
            scope_incremental = "<leader>s",
            node_decremental = "<leader>m",
          },
        },
        indent = {
          enable = true,
          disable = { "python" },
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        textsubjects = {
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selection
          keymaps = {
            ["."] = "textsubjects-smart",
            [":"] = "textsubjects-container-outer",
            ["i:"] = "textsubjects-container-inner",
          },
        },
      }
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      -- vim.opt.foldenable = false
    end,
  },
}
