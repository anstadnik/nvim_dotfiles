local M = {}

M.treesitter = {
  ensure_installed = {
    "rust",
    "python",
    "lua",
    "comment",
    "latex",
    "bash",
    "vim",
    "regex",
    "markdown",
    "markdown_inline",
    "julia",
    "cpp",
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
      },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["<C-p>"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>v",
      node_incremental = "<leader>v",
      scope_incremental = "<leader>s",
      node_decremental = "<leader>m",
    },
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
}

M.nvimcmp = function()
  local present, cmp = pcall(require, "cmp")
  if present then
    return {
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- function(fallback)
        --   -- print(ls.choice_active())
        --   if ls.choice_active() then
        --     ls.change_choice(1)
        --   elseif not require("cmp").select_prev_item() then
        --     local release = require("cmp").core:suspend()
        --     fallback()
        --     vim.schedule(release)
        --   end
        -- end,
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- function(fallback)
        --   -- print(ls.choice_active())
        --   if ls.choice_active() then
        --     -- print("a")
        --     ls.change_choice(-1)
        --   elseif not require("cmp").select_next_item() then
        --     local release = require("cmp").core:suspend()
        --     fallback()
        --     vim.schedule(release)
        --   end
        -- end,
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-j>"] = cmp.mapping {
          i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
          c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
          x = function(fallback)
            if require("luasnip").jumpable() then
              require("luasnip").jump()
            else
              fallback()
            end
          end,
        },
        ["<C-l>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-next", true, true, true), "")
          elseif require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
            fallback()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          require("copilot_cmp.comparators").score,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = {
        { name = "git" },
        { name = "copilot" },
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "luasnip" },
      },
      formatters = {
        insert_text = require("copilot_cmp.format").remove_existing,
      },
    }
  end
end

M.telescope = function()
  return {
    defaults = {
      mappings = { i = { ["<esc>"] = require("telescope.actions").close } },
    },
    extensions = {
      ["ui-select"] = { require("telescope.themes").get_cursor {} },
    },
  }
end

M.nvimtree = {
  diagnostics = {
    enable = true,
  },
}

M.luasnip = {
  enable_autosnippets = true,
}

M.gitsigns = {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line { full = true }
    end)
    map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function()
      gs.diffthis "~"
    end)
    map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

return M
