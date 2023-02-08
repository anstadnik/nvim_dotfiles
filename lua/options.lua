-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.g.tex_flavor = "latex"
vim.opt.mouse = ""
vim.opt.scrolloff = 5
vim.opt.gdefault = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.opt.foldlevelstart = 99

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

vim.opt.termguicolors = true
vim.opt.textwidth = 80

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.diffopt:append { 'vertical' }
-- vim.opt.foldlevelstart=99
