return {
	{
		"folke/tokyonight.nvim",
		disabled = true,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				filter = "ristretto",
				terminal_colors = true,
			})
			vim.cmd.colorscheme("monokai-pro")
		end,
	},
}
