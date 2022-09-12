local path = vim.api.nvim_buf_get_name(0)

vim.keymap.set('n', '<CR>', function()
  vim.fn.system { "tmux", "send-keys", "-t", "debug:1.1", "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", "debug:1.1", "python " .. path .. "\n" }
end, {buffer = true})
