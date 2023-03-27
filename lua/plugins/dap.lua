return {
  {
    "mfussenegger/nvim-dap",
    ft = { "python", "rust" },
    dependencies = {
      -- "rcarriga/cmp-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = require "plugins.configs.dap",
  },
}
