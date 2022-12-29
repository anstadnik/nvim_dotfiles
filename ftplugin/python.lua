local path = vim.api.nvim_buf_get_name(0)

vim.keymap.set("n", "<CR>", function()
  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "python " .. path .. "\n" }
end, { buffer = true })
