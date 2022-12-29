return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>n", "<cmd> Telescope find_files <CR>")
      vim.keymap.set("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
      vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
      vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
      -- vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
      vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
      vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
      vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
      vim.keymap.set("n", "<leader>tk", "<cmd> Telescope keymaps <CR>")
      vim.keymap.set("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
      vim.keymap.set("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
      vim.keymap.set("n", "<leader>fu", "<cmd> Telescope undothemes <CR>")
      require("telescope").setup {
        defaults = {
          mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
          },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_cursor {} },
          undo = {
            undo = {
              side_by_side = true,
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.8,
              },
            },
          },
        },
      }
      require("telescope").load_extension "ui-select"
      require("telescope").load_extension "undo"
    end,
  },
  "nvim-telescope/telescope-ui-select.nvim",
  "debugloop/telescope-undo.nvim",
}
