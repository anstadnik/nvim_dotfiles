return {
  "machakann/vim-sandwich",
  { "junegunn/vim-easy-align", keys = "ga" },
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
    setup = function()
      require("core.utils").load_mappings "comment"
    end,
  },
}
