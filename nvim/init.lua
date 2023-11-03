vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"nvim-lua/plenary.nvim",
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	"szw/vim-maximizer", -- maximizes and restores current window

	-- essential plugins
	"tpope/vim-surround", -- add, delete, change surroundings (it's awesome)
	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	"numToStr/Comment.nvim",

	-- file explorer
	"nvim-tree/nvim-tree.lua",

	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",

	-- statusline
	"nvim-lualine/lualine.nvim",

	-- fuzzy finding w/ telescope
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder

	-- autocompletion
	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file system paths

	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets
	"honza/vim-snippets", -- vim snippets
	"dcampos/nvim-snippy", -- custom snippets

	-- managing & installing lsp servers, linters & formatters
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	"neovim/nvim-lspconfig", -- easily configure language servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}, -- enhanced lsp uis

	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},

	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
	{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose tags

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- nvim v0.7.2
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- debugging
	{ "mfussenegger/nvim-dap", commit = "b3d4408" },
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"nvim-telescope/telescope-dap.nvim",
	"xdebug/vscode-php-debug",

	{ "catppuccin/nvim", as = "catppuccin" },

	{ "vimwiki/vimwiki" },

	{
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		commit = "8b62563",
		config = function()
			require("rest-nvim").setup({
				ces = {},
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	},

	-- replacer
	{
		"filipdutescu/renamer.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		-- Lua
	},

	{
		"folke/todo-comments.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	},

	{ "xiyaowong/transparent.nvim" },

	{ "garrettkrohn/harpoon" },
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
}, {})

-- require("garrett.plugins-setup")
require("garrett.core.options")
require("garrett.core.keymaps")
require("garrett.core.colorscheme")
require("garrett.plugins.comment")
require("garrett.plugins.nvim-tree")
require("garrett.plugins.lualine")
require("garrett.plugins.telescope")
require("garrett.plugins.nvim-cmp")
require("garrett.plugins.lsp.mason")
require("garrett.plugins.lsp.lspsaga")
require("garrett.plugins.lsp.lspconfig")
require("garrett.plugins.lsp.null-ls")
require("garrett.plugins.autopairs")
require("garrett.plugins.treesitter")
require("garrett.plugins.gitsigns")
-- require("garrett.plugins.bufferline")
-- require("garrett.plugins.dap")
-- require("garrett.plugins.lsplines")
require("garrett.plugins.snippy")
require("garrett.plugins.replacer")
-- require("garrett.plugins.dbee")
require("garrett.plugins.xdebug")
require("garrett.plugins.todo-comments")
