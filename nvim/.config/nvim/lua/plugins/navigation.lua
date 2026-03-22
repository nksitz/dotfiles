return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			require("telescope").setup({
				-- defaults = {
				-- mappings = []
				-- }
				extensions = {
					fzf = {},
				},
			})

			require("telescope").load_extension("fzf")

			vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "Telescope help" })
			vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files, { desc = "Telescope find file" })
			vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Telescope find words" })
			vim.keymap.set("n", "<space>en", function()
				local opts = require("telescope.themes").get_ivy({
					cwd = vim.fn.stdpath("config"),
				})
				require("telescope.builtin").find_files(opts)
			end)
			vim.keymap.set("n", "<space>ep", function()
				require("telescope.builtin").find_files({
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
				})
			end)
		end,
	},

	{
		"stevearc/oil.nvim",
		opts = {
			view_options = {
				show_hidden = true,
			},
		},
		dependencies = {
			{ "echasnovski/mini.icons", opts = {} },
		},
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
	},
}
