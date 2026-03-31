return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
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
			keymaps = {
				["<Esc>"] = { "actions.close", mode = "n" },
			},
			float = {
				padding = 4,
				max_width = 0.8,
				max_height = 0.8,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				preview_split = "auto",
			},
		},
		dependencies = {
			{ "echasnovski/mini.icons", opts = {} },
		},
		keys = {
			{ "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
				},
			})
			vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
			vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
			vim.keymap.set("n", "<leader>bd", "<Cmd>bd<CR>", { desc = "Close current buffer" })
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"<leader>xd",
				"<cmd>Trouble todo toggle<cr>",
				desc = "Todo (Trouble)",
			},
		},
	},
}
