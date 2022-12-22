return {
  {
    "jpalardy/vim-slime",
    ft = "julia",
    config = function()
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_no_mappings = 1
      vim.g.slime_target = "kitty"
      vim.g.slime_default_config = { listen_on = os.getenv "KITTY_LISTEN_ON", window_id = 1 }
      vim.keymap.set("n", "<CR>", ":write<CR><Plug>SlimeParagraphSend")
      vim.keymap.set("n", "<CR>", "<Plug>SlimeRegionSend")
    end,
  },
}
