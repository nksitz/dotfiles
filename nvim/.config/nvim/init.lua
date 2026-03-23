-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end) --schedule because it increases startup time very very
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.confirm = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Keymaps
-- remove highlight after search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- disable arrow navigation
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
-- simplify split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [Diagnostics]]
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = { float = true },
})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- [[ Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

require("config.lazy")
require("config.mappings")

-- -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- -- is not what someone will guess without a bit more experience.
-- --
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- -- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
--
--
--
-- -- [[ Install `lazy.nvim` plugin manager ]]
-- --    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
--   if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
-- end
--
-- ---@type vim.Option
-- local rtp = vim.opt.rtp
-- rtp:prepend(lazypath)
--
-- -- [[ Configure and install plugins ]]
-- --
-- --  To check the current status of your plugins, run
-- --    :Lazy
-- --
-- --  You can press `?` in this menu for help. Use `:q` to close the window
-- --
-- --  To update plugins you can run
-- --    :Lazy update
-- --
-- -- NOTE: Here is where you install your plugins.
-- require('lazy').setup({
--   -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
--
--
--
--
--
--
--
--   { -- You can easily change to a different colorscheme.
--     -- Change the name of the colorscheme plugin below, and then
--     -- change the command in the config to whatever the name of that colorscheme is.
--     --
--     -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
--     'folke/tokyonight.nvim',
--     priority = 1000, -- Make sure to load this before all the other start plugins.
--     config = function()
--       ---@diagnostic disable-next-line: missing-fields
--       require('tokyonight').setup {
--         styles = {
--           comments = { italic = false }, -- Disable italics in comments
--         },
--       }
--
--       -- Load the colorscheme here.
--       -- Like many other themes, this one has different styles, and you could load
--       -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--       vim.cmd.colorscheme 'tokyonight-night'
--     end,
--   },
--
--
--   { -- Collection of various small independent plugins/modules
--     'nvim-mini/mini.nvim',
--     config = function()
--       -- Better Around/Inside textobjects
--       --
--       -- Examples:
--       --  - va)  - [V]isually select [A]round [)]paren
--       --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--       --  - ci'  - [C]hange [I]nside [']quote
--       require('mini.ai').setup { n_lines = 500 }
--
--       -- Add/delete/replace surroundings (brackets, quotes, etc.)
--       --
--       -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--       -- - sd'   - [S]urround [D]elete [']quotes
--       -- - sr)'  - [S]urround [R]eplace [)] [']
--       require('mini.surround').setup()
--
--       -- Simple and easy statusline.
--       --  You could remove this setup call if you don't like it,
--       --  and try some other statusline plugin
--       local statusline = require 'mini.statusline'
--       -- set use_icons to true if you have a Nerd Font
--       statusline.setup { use_icons = vim.g.have_nerd_font }
--
--       -- You can configure sections in the statusline by overriding their
--       -- default behavior. For example, here we set the section for
--       -- cursor location to LINE:COLUMN
--       ---@diagnostic disable-next-line: duplicate-set-field
--       statusline.section_location = function() return '%2l:%-2v' end
--
--       -- ... and there is more!
--       --  Check out: https://github.com/nvim-mini/mini.nvim
--     end,
--   },
--
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     lazy = false,
--     build = ':TSUpdate',
--     branch = 'main',
--     -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
--     config = function()
--       local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
--       require('nvim-treesitter').install(parsers)
--       vim.api.nvim_create_autocmd('FileType', {
--         callback = function(args)
--           local buf, filetype = args.buf, args.match
--
--           local language = vim.treesitter.language.get_lang(filetype)
--           if not language then return end
--
--           -- check if parser exists and load it
--           if not vim.treesitter.language.add(language) then return end
--           -- enables syntax highlighting and other treesitter features
--           vim.treesitter.start(buf, language)
--
--           -- enables treesitter based folds
--           -- for more info on folds see `:help folds`
--           -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--           -- vim.wo.foldmethod = 'expr'
--
--           -- enables treesitter based indentation
--           vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--         end,
--       })
--     end,
--   },
--
--   -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
--   -- init.lua. If you want these files, they are in the repository, so you can just download them and
--   -- place them in the correct locations.
--
--   -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--   --
--   --  Here are some example plugins that I've included in the Kickstart repository.
--   --  Uncomment any of the lines below to enable them (you will need to restart nvim).
--   --
--   -- require 'kickstart.plugins.debug',
--   -- require 'kickstart.plugins.indent_line',
--   -- require 'kickstart.plugins.lint',
--   -- require 'kickstart.plugins.autopairs',
--   -- require 'kickstart.plugins.neo-tree',
--   -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommended keymaps
--
--   -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--   --    This is the easiest way to modularize your config.
--   --
--   --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--   -- { import = 'custom.plugins' },
--   --
--   -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
--   -- Or use telescope!
--   -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
--   -- you can continue same window with `<space>sr` which resumes last telescope search
-- }, { ---@diagnostic disable-line: missing-fields
--   ui = {
--     -- If you are using a Nerd Font: set icons to an empty table which will use the
--     -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
--     icons = vim.g.have_nerd_font and {} or {
--       cmd = '⌘',
--       config = '🛠',
--       event = '📅',
--       ft = '📂',
--       init = '⚙',
--       keys = '🗝',
--       plugin = '🔌',
--       runtime = '💻',
--       require = '🌙',
--       source = '📄',
--       start = '🚀',
--       task = '📌',
--       lazy = '💤 ',
--     },
--   },
-- })
--
-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
