return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					-- "csharp_ls",
					-- "clangd",
					"lua_ls",
					-- "pyright",
					-- "basedpyright",
					"ty",
					"ruff",
					-- "ts_ls",
					-- "tailwindcss",
					"taplo",
					"yamlls",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"codelldb", -- debug dap
					-- "mypy",
					"prettier",
					"prettierd",
					"shellcheck",
					"stylua",
					"yamllint",
				},
			})
		end,
	},
}
