local path = vim.api.nvim_buf_get_name(0)

if path:match('/home/astadnik/code/.*') then
   local problem_id = path:match("[^/]*$"):match("%d*%."):sub(1, -2)
   vim.keymap.set('n', '<CR>', function()
      require("nvterm.terminal").send("leetcode test " .. problem_id, "horizontal")
   end, {})
   vim.keymap.set('n', '<leader><CR>', function()
      require("nvterm.terminal").send("leetcode exec " .. problem_id, "horizontal")
   end, {})
else
   vim.keymap.set('n', '<CR>', function()
      vim.fn.system { "tmux", "send-keys", "-t", "debug:1.1", "clear\n" }
      vim.fn.system { "tmux", "send-keys", "-t", "debug:1.1", "cargo run\n" }
   end, {})
   vim.keymap.set('n', '<leader><CR>', function()
      vim.fn.system { "tmux", "send-keys", "-t", "debug:1.1", "clear\n" }
      vim.fn.system { "tmux", "send-keys", "-t", "debug:1.1", "cargo run --release\n" }
   end, {})
end
-- 	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo test -- --nocapture --test-threads 1' ENTER <CR>
-- elseif expand("%:p:h") =~ '/home/astadnik/.leetcode/code/*'
-- 	" nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo test -- --nocapture' ENTER <CR>
-- 	nnoremap <silent> <CR> :let $PROBLEM_ID=split(expand('%:t'), '\.')[0]<CR>:w<CR>:terminal leetcode test $PROBLEM_ID<CR>
-- 	nnoremap <silent> <leader><CR> :let $PROBLEM_ID=split(expand('%:t'), '\.')[0]<CR>:w<CR>:terminal leetcode exec $PROBLEM_ID<CR>
-- elseif expand("%:p:h") =~ '/home/astadnik/edu/masters/sem_2/perf/hw4'
-- 	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'maturin build' ENTER <CR>
-- elseif expand("%:p:h") =~ '/home/astadnik/edu/rustlings/*'
-- 	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'rustlings verify' ENTER <CR>
-- else
-- 	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo run' ENTER <CR>
-- endif
-- " nnoremap <silent> <CR> :RustRunnables<CR>
-- " nnoremap <silent> <leader><CR> :RustDebuggables<CR>
