local target_pane = "{bottom-right}"
-- local target_pane = "debug:1.1"

vim.keymap.set("n", "<CR>", function()
  -- Find main.py in the current directory or parent directories
  local main_py = vim.fn.findfile("main.py", ".;")

  -- If main.py is found, execute it with Python
  if main_py == "" then
    main_py = vim.api.nvim_buf_get_name(0)
  end

  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "ipython " .. main_py .. "\n" }
end, { buffer = true })

vim.keymap.set("n", "<leader><CR>", function()
  -- Find main.py in the current directory or parent directories
  local main_py = vim.fn.findfile("main.py", ".;")

  -- If main.py is found, execute it with Python
  if main_py == "" then
    main_py = vim.api.nvim_buf_get_name(0)
  end

  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "python -m unittest\n" }
end, { buffer = true })
