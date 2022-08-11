local on_attach = require("plugins.configs.lspconfig").on_attach

local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- lspservers with default config
local servers = { "pyright", "vimls", "clangd", "dockerls", "bashls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local rt = require("rust-tools")
rt.setup({
  -- tools = { autoSetHints = false },
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require('core.utils').load_mappings("rust_tools", { buffer = bufnr })
      -- Hover actions
      -- vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    capabilities = capabilities,
    standalone = true,
    -- flags = { debounce_text_changes = 150 },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" },
        cargo = { allFeatures = true }
      }
    }
  },
})

lspconfig["sourcery"].setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    -- flags = { debounce_text_changes = 150 },
  },
  init_options = {
    editor_version = 'vim',
    extension_version = 'vim.lsp',
    token = 'user_9IMPzM1nhVENfmTL5gZoD0KOh3_zFWPCHqjuHQs019beGcu1yi78i0TYBmM'
  },
})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
