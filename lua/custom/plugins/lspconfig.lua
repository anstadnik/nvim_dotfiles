local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   local on_attach = function(client, bufnr)
      attach(client, bufnr)
      -- require 'lsp_signature'.on_attach({ hint_enable = true });
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
   end

   -- lspservers with default config
   local servers = { "pyright", "vimls", "clangd", "dockerls", "bashls" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = on_attach,
         capabilities = capabilities,
      }
   end

   require('rust-tools').setup({
      tools = { autoSetHints = false },
      server = {
         on_attach = on_attach,
         capabilities = capabilities,
         -- flags = { debounce_text_changes = 150 },
         settings = {
            ["rust-analyzer"] = {
               checkOnSave = { command = "clippy" }
            }
         }
      },
   })

   end

   return M
