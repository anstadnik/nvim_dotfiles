local M = {}

M.ensure_installed = {
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
}
M.textobjects = {
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
}
M.incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "<leader>v",
    node_incremental = "<leader>v",
    scope_incremental = "<leader>s",
    node_decremental = "<leader>m",
  },
}
M.indent = {
  enable = true,
  disable = { "python" },
}

return M
