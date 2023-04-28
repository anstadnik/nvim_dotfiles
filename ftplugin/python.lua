vim.keymap.set("n", "<CR>", function()
  -- Find main.py in the current directory or parent directories
  local main_py = vim.fn.findfile("main.py", ".;")

  -- If main.py is found, execute it with Python
  if main_py == "" then
    main_py = vim.api.nvim_buf_get_name(0)
  end

  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "ipython " .. main_py .. "\n" }
end, { buffer = true })
