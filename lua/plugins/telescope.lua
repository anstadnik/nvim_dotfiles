return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>n", "<cmd> Telescope find_files <CR>")
      vim.keymap.set("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
      vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
      vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
      vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
      vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
      vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
      vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
      vim.keymap.set("n", "<leader>tk", "<cmd> Telescope keymaps <CR>")
      vim.keymap.set("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
      vim.keymap.set("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
      vim.keymap.set("n", "<leader>pt", "<cmd> Telescope terms <CR>")
      vim.keymap.set("n", "<leader>th", "<cmd> Telescope themes <CR>")
      require("telescope").setup {
        defaults = {
          mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
          },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_cursor {} },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
  "nvim-telescope/telescope-ui-select.nvim",
}
