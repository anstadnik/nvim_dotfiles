return {
  "machakann/vim-sandwich",
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set({ "n", "v" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  "chaoren/vim-wordmotion",
  "rhysd/clever-f.vim",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },
}
