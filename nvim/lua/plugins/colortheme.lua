return {
	'AlphaTechnolog/pywal.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('pywal').setup()

		vim.keymap.set("n", "<leader>bg", "<Cmd>TransparentToggle<CR>")
	end
}
