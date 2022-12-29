return function()
  local load_mapping = function(bufnr)
    vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>g", "<cmd> Telescope lsp_document_symbols<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<C-g>", "<cmd> SymbolsOutline<CR>", { buffer = bufnr })
    vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>l", "<cmd> Telescope lsp_dynamic_workspace_symbols<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>e", "<cmd> Telescope diagnostics<CR>", { buffer = bufnr })
    vim.keymap.set("n", "gD", "<cmd> Telescope lsp_type_definitions<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>fm", function()
      vim.lsp.buf.format { async = true }
    end, { buffer = bufnr })
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev()
    end, { buffer = bufnr })
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next()
    end, { buffer = bufnr })
    -- vim.keymap.set("n", "gD", function()
    --   vim.lsp.buf.declaration()
    -- end, { buffer = bufnr })
    -- vim.keymap.set("n", "gd", function()
    --   vim.lsp.buf.definition()
    -- end, { buffer = bufnr })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ls", function()
      vim.lsp.buf.signature_help()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>D", function()
      vim.lsp.buf.type_definition()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ra", function()
      vim.lsp.buf.rename()
    end, { buffer = bufnr })
    vim.keymap.set({ "n", "v" }, "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, { buffer = bufnr })
    -- vim.keymap.set("n", "gr", function()
    --   vim.lsp.buf.references()
    -- end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>f", function()
      vim.diagnostic.open_float()
    end, { buffer = bufnr })
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev()
    end, { buffer = bufnr })
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>q", function()
      vim.diagnostic.setloclist()
    end, { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>fm", function()
    --   vim.lsp.buf.format { async = true }
    -- end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>wa", function()
      vim.lsp.buf.add_workspace_folder()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>wr", function()
      vim.lsp.buf.remove_workspace_folder()
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr })

    -- if client.server_capabilities.signatureHelpProvider then
    --   require("nvchad_ui.signature").setup(client)
    -- end
  end
  local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    load_mapping(bufnr)
  end

  local on_attach_with_format = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    load_mapping(bufnr)
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- local capabilities = require("plugins.configs.lspconfig").capabilities

  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = { "julials", "pyright" }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end

  local servers_with_fmt = { "yamlls", "dockerls" }

  for _, lsp in ipairs(servers_with_fmt) do
    lspconfig[lsp].setup {
      on_attach = on_attach_with_format,
      capabilities = capabilities,
    }
  end

  lspconfig["bashls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh", "zsh", "bash" },
  }

  local rt = require "rust-tools"
  rt.setup {
    -- tools = { autoSetHints = false },
    server = {
      on_attach = function(client, bufnr)
        on_attach_with_format(client, bufnr)
        vim.keymap.set("n", "K", function()
          require("rust-tools").hover_actions.hover_actions()
        end)
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
          executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
          args = { "-g", "%l", "%p", "%f" },
        },
        chktex = { onOpenAndSave = true, onEdit = false },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = true,
        },
      },
    },
  }
  lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
            "s",
            "t",
            "i",
            "c",
            "conds",
            "dl",
            "l",
            "f",
            "sn",
            "d",
            "p",
            "rep",
            "events",
          },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }
end
