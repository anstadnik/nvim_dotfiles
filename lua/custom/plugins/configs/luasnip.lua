local M = {}
M.wants = false
M.override_options = {
  enable_autosnippets = true,
}
M.config = function()
  -- local luasnip = require "luasnip"

  -- require("luasnip.loaders.from_vscode").lazy_load()
  -- require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
  require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/luasnippets" }

  -- vim.keymap.set("i", "<C-u>", function()
  --   if require("luasnip").choice_active() then
  --     require "luasnip.extras.select_choice"()
  --   end
  -- end)

  require("luasnip").config.setup {
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = { { "●", "GruvboxOrange" } },
        },
      },
      [require("luasnip.util.types").insertNode] = {
        active = {
          virt_text = { { "●", "GruvboxBlue" } },
        },
      },
    },
    history = true,
    updateevents = "TextChanged,TextChangedI",
    region_check_events = "CursorMoved,CursorHold,InsertEnter",
    delete_check_events = "TextChanged",
    enable_autosnippets = true,
  }

  vim.api.nvim_create_autocmd("User", {
    pattern = "LuasnipChoiceNodeEnter",
    callback = function()
      if require("luasnip").choice_active() then
        vim.schedule(require "luasnip.extras.select_choice")
        -- vim.defer_fn(require "luasnip.extras.select_choice", 200)
      end
    end,
  })
end

return M
