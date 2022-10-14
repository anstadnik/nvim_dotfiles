local on_attach = require("plugins.configs.lspconfig").on_attach
local on_attach_with_format = function(client, bufnr)
  on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(require("plugins.configs.lspconfig").capabilities)
-- local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- lspservers with default config
local servers = { "pyright", "bashls" }

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

lspconfig["dockerls"].setup {
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


-- -- alternatively you can override the default configs
-- require("flutter-tools").setup {
--   decorations = {
--     statusline = {
--       -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
--       -- this will show the current version of the flutter app from the pubspec.yaml file
--       app_version = true,
--       -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
--       -- this will show the currently running device if an application was started with a specific
--       -- device
--       device = true,
--     }
--   },
--   -- debugger = { -- integrate with nvim dap + install dart code debugger
--   --   enabled = true,
--   --   run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
--   --   register_configurations = function(paths)
--   --     require("dap").configurations.dart = {
--   --       <put here config that you would find in .vscode/launch.json>
--   --     }
--   --   end,
--   -- },
--   -- flutter_path = "/usr/bin/dart",
--   widget_guides = {
--     enabled = true,
--   },
--   dev_tools = {
--     autostart = true, -- autostart devtools server if not detected
--     auto_open_browser = true, -- Automatically opens devtools in the browser
--   },
--   outline = {
--     open_cmd = "30vnew", -- command to use to open the outline buffer
--     auto_open = true -- if true this will open the outline automatically when it is first populated
--   },
--   lsp = {
--     color = { -- show the derived colours for dart variables
--       enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
--       background = false, -- highlight the background
--       foreground = false, -- highlight the foreground
--       virtual_text = true, -- show the highlight using virtual text
--       virtual_text_str = "■", -- the virtual text character to highlight
--     },
--     on_attach = on_attach,
--     capabilities = capabilities, -- e.g. lsp_status capabilities
--   }
-- }

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
