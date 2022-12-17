-- custom.mappings

local M = {}

M.disabled = {
  i = {
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
  t = {
    -- ["<A-i>"] = "",
    -- ["<A-h>"] = "",
    -- ["<A-v>"] = "",
  },
  n = {
    -- ["<A-i>"] = "",
    -- ["<A-h>"] = "",
    -- ["<A-v>"] = "",
    ["<S-b>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<leader>rn"] = "",
    ["d]"] = "",
    ["gi"] = "",
    ["<Tab>"] = "",
    ["<S-Tab>"] = "",
  },
  v = {
    ["<leader>/"] = "",
  },
}

M.custom = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { silent = false } },
    [":"] = { ";", "Next searched letter", opts = { silent = false } },
  },
  v = {
    [";"] = { ":", "Enter command mode", opts = { silent = false } },
    [":"] = { ";", "Next searched letter", opts = { silent = false } },
  },
  i = {
    ["jk"] = { "<ESC>", "Escape normal mode" },
  },
}

M.telescope = {
  -- plugin = true,

  n = {
    ["<leader>n"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>/"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
  },
}

M.trouble = {
  -- plugin = true,
  n = {
    ["<leader>q"] = {
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      "   diagnostic",
    },
  },
}

M.navigator = {
  -- plugin = true,
  n = {
    ["<C-h>"] = { "<CMD>lua require('Navigator').left()<CR>", "Seamless TMUX navigation" },
    ["<C-k>"] = { "<CMD>lua require('Navigator').up()<CR>", "Seamless TMUX navigation" },
    ["<C-l>"] = { "<CMD>lua require('Navigator').right()<CR>", "Seamless TMUX navigation" },
    ["<C-j>"] = { "<CMD>lua require('Navigator').down()<CR>", "Seamless TMUX navigation" },
  },
}

M.easyalign = {
  -- plugin = true,
  n = {
    ["ga"] = { "<Plug>(EasyAlign)", "Align" },
  },
  v = {
    ["ga"] = { "<Plug>(EasyAlign)", "Align" },
  },
}

M.gitsigns = {
  -- plugin = true,
  n = {
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    ["<leader>hS"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Git stage buffer",
    },
    ["<leader>hu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Git stage buffer",
    },
    ["<leader>hR"] = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Git stage buffer",
    },
    ["<leader>hp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Git stage buffer",
    },
    ["<leader>hb"] = {
      function()
        require("gitsigns").blame_line { full = true }()
      end,
      "Git stage buffer",
    },
    ["<leader>tb"] = {
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      "Git stage buffer",
    },
    ["<leader>hd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "Git stage buffer",
    },
    ["<leader>hD"] = {
      function()
        require("gitsigns").diffthis "~"()
      end,
      "Git stage buffer",
    },
    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Git stage buffer",
    },
  },
}

M.lspconfig = {
  -- plugin = true,
  n = {
    ["gd"] = {
      "<cmd> Telescope lsp_definitions<CR>",
      "   lsp definition",
    },
    ["<leader>g"] = {
      "<cmd> Telescope lsp_document_symbols<CR>",
      "   document symbols",
    },
    ["<C-g>"] = {
      "<cmd> SymbolsOutline<CR>",
      "   symbol outline",
    },
    ["gr"] = {
      "<cmd> Telescope lsp_references<CR>",
      "   lsp references",
    },
    ["<leader>l"] = {
      "<cmd> Telescope lsp_dynamic_workspace_symbols<CR>",
      "   lsp references",
    },
    ["<leader>e"] = {
      "<cmd> Telescope diagnostics<CR>",
      "   search diagnostic",
    },
    ["gD"] = {
      "<cmd> Telescope lsp_type_definitions<CR>",
      "   lsp definition type",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
    -- ["<leader>r"] = {
    --    function()
    --       require("nvchad_ui.renamer").open()
    --    end,
    --    "   lsp rename",
    -- },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "   goto prev",
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "   goto_next",
    },
  },
  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "   lsp code_action",
    },
  },
}

M.rust_tools = {
  -- plugin = true,
  n = {
    ["K"] = {
      function()
        require("rust-tools").hover_actions.hover_actions()
      end,
      "lsp hover",
    },
    -- -- Code action groups
    -- vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
  },
}

M.dap = {
  n = {
    ["<leader>dd"] = {
      function()
        require("dapui").toggle()
      end,
      "Dap",
    },
    ["<leader>dr"] = {
      function()
        require("dap").continue()
      end,
      "Dap",
    },
    ["<leader>dn"] = {
      function()
        require("dap").step_over()
      end,
      "Dap",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      "Dap",
    },
    ["<leader>df"] = {
      function()
        require("dap").step_out()
      end,
      "Dap",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Dap",
    },
    ["<leader>dB"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Dap",
    },
    ["<leader>dp"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Dap",
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Dap",
    },
    ["<leader>dq"] = {
      function()
        require("dap").terminate()
      end,
      "Dap",
    },
  },
}

M.slime = {
  -- n = { ["<CR>"] = { ":write<CR><Plug>SlimeParagraphSend", "Slime" } },
  n = { ["<CR>"] = { ":write<CR><Plug>SlimeParagraphSend", "Slime" } },
  x = { ["<CR>"] = { "<Plug>SlimeRegionSend", "Slime" } },
}

M.cheat_sh = {
  n = {
    ["<leader><leader>"] = { "<cmd> Cheat <CR>", "Cheat.sh" },
  },
}

return M
