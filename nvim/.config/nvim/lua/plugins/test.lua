return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- "Issafalcon/neotest-dotnet",
			"nvim-neotest/neotest-python",
			"mrcjkb/rustaceanvim",
		},

		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					-- require("neotest-dotnet")({
					-- 	dap = { justMyCode = false },
					-- }),
					require("neotest-python")({
						dap = { justMyCode = false },
					}),
					require("rustaceanvim.neotest"),
				},
				-- output = {
				-- 	open_on_run = true, -- Opens the output window automatically when running tests
				-- },
			})

			vim.keymap.set("n", "<leader>tt", function()
				neotest.run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>tT", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Run all tests in file" })
			vim.keymap.set("n", "<leader>td", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Debug nearest test" })
			vim.keymap.set("n", "<leader>ts", function()
				neotest.summary.toggle()
			end, { desc = "Toggle test summary" })
			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open()
			end, { desc = "Show test output" })
			vim.keymap.set("n", "<leader>tO", function()
				neotest.output.open({ enter = true })
			end, { desc = "Show output and enter window" })
			vim.keymap.set("n", "<leader>tp", function()
				neotest.output_panel.toggle()
			end, { desc = "Toggle test output panel" })
			vim.keymap.set("n", "<leader>tw", function()
				neotest.watch.toggle()
			end, { desc = "Toggle watch mode" })
			vim.keymap.set("n", "<leader>tq", function()
				neotest.run.stop()
			end, { desc = "Stop running test" })
			vim.keymap.set("n", "<leader>tv", function()
				local file = vim.fn.expand("%:p")
				local line = vim.fn.line(".")
				-- Get the test function name at current cursor position
				local test_name = vim.fn.search("def test_", "bn")
				if test_name > 0 then
					local func_line = vim.fn.getline(test_name)
					local func_name = func_line:match("def (test_[^(]+)")
					if func_name then
						local cmd = string.format("pytest -vv --tb=long %s::%s", file, func_name)
						vim.cmd("split | terminal " .. cmd)
					end
				end
			end, { desc = "Run current test with verbose output" })
		end,
	},
}
