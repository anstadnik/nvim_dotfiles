return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.codeium_no_map_tab = 0
      require("chatgpt").setup()
      vim.keymap.set({ "n", "v" }, "<leader>ce", function()
        require("chatgpt").edit_with_instructions()
      end)
      vim.keymap.set({"n", "v"}, "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>")
      vim.keymap.set({"n", "v"}, "<leader>ck", "<cmd>ChatGPTRun keywords<CR>")
      vim.keymap.set({"n", "v"}, "<leader>cd", "<cmd>ChatGPTRun docstring<CR>")
      vim.keymap.set({"n", "v"}, "<leader>ct", "<cmd>ChatGPTRun add_tests<CR>")
      vim.keymap.set({"n", "v"}, "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>")
      vim.keymap.set({"n", "v"}, "<leader>cs", "<cmd>ChatGPTRun summarize<CR>")
      vim.keymap.set({"n", "v"}, "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>")
      vim.keymap.set({"n", "v"}, "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
