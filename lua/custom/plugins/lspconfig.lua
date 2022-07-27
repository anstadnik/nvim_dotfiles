local on_attach = function(client, bufnr)
  require("plugins.configs.lspconfig").on_attach(client, bufnr)
  -- require 'lsp_signature'.on_attach({ hint_enable = true });
  local vim_version = vim.version()

  if vim_version.minor > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  else
    -- stable
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
  end
end

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

require('rust-tools').setup({
  -- tools = { autoSetHints = false },
  server = {
    on_attach = on_attach,
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
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" }
      }
    },
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
