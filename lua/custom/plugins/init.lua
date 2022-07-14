return {
   ['machakann/vim-sandwich'] = { keys = { "sa", "sd", "sr" } },
   ['simrat39/rust-tools.nvim'] = {
      module = "rust-tools",
      -- [[ requires = { 'nvim-lua/plenary.nvim' }, ]]
   },
   ['Saecki/crates.nvim'] = {
      requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
      ft = "toml",
      config = function()
         require('null-ls')
         require('crates').setup { null_ls = { enabled = true, }, }
      end
   },
   ['folke/trouble.nvim'] = {
      cmd = "TroubleToggle",
      config = function()
         require("trouble").setup {}
      end,
   },
   ['numToStr/Navigator.nvim'] = {
      config = function()
         require('Navigator').setup({ disable_on_zoom = true })
      end
   },
   ['junegunn/vim-easy-align'] = {
      keys = "ga"
   },
   -- ['ray-x/lsp_signature.nvim' ] = {
   --    after = 'nvim-lspconfig'
   -- },
   ['nvim-treesitter/nvim-treesitter-textobjects'] = {
      after = "nvim-treesitter"
   },
   ['chaoren/vim-wordmotion'] = {},
   ['rhysd/clever-f.vim'] = {},
   ['tpope/vim-fugitive'] = {},
   ['nvim-telescope/telescope-ui-select.nvim'] = {
      after = 'telescope.nvim',
      config = function()
         require("telescope").load_extension("ui-select")
      end
   },

   -- Override
   ["nvim-telescope/telescope.nvim"] = {
      event = "BufRead"
   },
}
