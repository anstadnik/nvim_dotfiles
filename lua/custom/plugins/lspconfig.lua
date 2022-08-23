local on_attach = require("plugins.configs.lspconfig").on_attach
local on_attach_with_format = function(client, bufnr)
  on_attach(client, bufnr)
  if vim.g.vim_version > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  else
    -- stable
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
  end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(require("plugins.configs.lspconfig").capabilities)
-- local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- lspservers with default config
local servers = { "pyright", "dockerls", "bashls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig["yamlls"].setup {
  on_attach = on_attach_with_format,
  capabilities = capabilities,
}

local rt = require "rust-tools"
rt.setup {
  -- tools = { autoSetHints = false },
  server = {
    on_attach = function(client, bufnr)
      on_attach_with_format(client, bufnr)
      require("core.utils").load_mappings("rust_tools", { buffer = bufnr })
      -- Hover actions
      -- vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    capabilities = capabilities,
    standalone = true,
    -- flags = { debounce_text_changes = 150 },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" },
        cargo = { allFeatures = true },
      },
    },
  },
}

lspconfig["sourcery"].setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    -- flags = { debounce_text_changes = 150 },
  },
  init_options = {
    editor_version = "vim",
    extension_version = "vim.lsp",
    token = "user_9IMPzM1nhVENfmTL5gZoD0KOh3_zFWPCHqjuHQs019beGcu1yi78i0TYBmM",
  },
}

lspconfig["texlab"].setup {
  -- server = {
  on_attach = on_attach_with_format,
  capabilities = capabilities,
  -- flags = { debounce_text_changes = 150 },
  -- },
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        -- args = { "-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
        -- executable = "latexmk",
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
        forwardSearchAfter = true,
        onSave = true,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = { "--synctex-forward", "%l:1:%f", "%p" },
        executable = "zathura",
      },
      chktex = { onOpenAndSave = true, onEdit = false },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = true,
      },
    },
  },
}

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
