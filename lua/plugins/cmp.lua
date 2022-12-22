return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
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
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "cmp_tabnine" },
        },
      }
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "tzachar/cmp-tabnine",
      "petertriho/cmp-git",
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    config = function()
      --require("plugins.configs.others").luasnip()
    end,
  },

  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- misc plugins
  { "tzachar/cmp-tabnine", build = "./install.sh" },
  {
    "petertriho/cmp-git",
    config = function()
      require("cmp_git").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      vim.schedule(function()
        require("copilot").setup { suggestion = { auto_trigger = true } }
      end)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
