return function()
  local cmp = require "cmp"

  local M = {}

  M.mapping = {
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
  }
  M.sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,
      -- require("copilot_cmp.comparators").score,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  }
  M.sources = {
    { name = "luasnip" },
    { name = "git" },
    { name = "copilot" },
    { name = "cmp_tabnine" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  }
  M.formatters = {
    insert_text = require("copilot_cmp.format").remove_existing,
  }

  return M
end
