return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-rust",
        },
      }

      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").run.run()
      end, { buffer = true })
      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").run.stop()
      end, { buffer = true })
      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand "%")
      end, { buffer = true })
      vim.keymap.set("n", "<leader>td", function()
        require("neotest").run.run { strategy = "dap" }
      end, { buffer = true })

    end,
  },
}
