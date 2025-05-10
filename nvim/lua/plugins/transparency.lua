return {
	'xiyaowong/transparent.nvim',
	config = function()
		vim.keymap.set("n", "<leader>bg", "<Cmd>TransparentToggle<CR>", { noremap = true, silent = true })
	end
}
