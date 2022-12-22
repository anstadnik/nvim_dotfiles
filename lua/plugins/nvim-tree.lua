return {
	{"nvim-tree/nvim-tree.lua",
config = function() 
    vim.keymap.set("n", "<C-n>",  "<cmd> NvimTreeToggle <CR>")
    vim.keymap.set("n", "<leader>e",  "<cmd> NvimTreeFocus <CR>")
require("nvim-tree").setup()
end}
}
