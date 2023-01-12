return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {
        open_on_setup = true,
        diagnostics = { enable = true },
        modified = { enable = true },
        -- view = { float = { enable = true } },
      }
      vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeFindFileToggle <CR>")
      -- vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>")
    end,
  },
}
