local snippy = require("snippy")

snippy.setup({
	mappings = {
		i = {
			["<C-i>"] = "expand_or_advance",
			["<C-o>"] = "previous",
		},
	},
})

-- Insert mode snippy completion mapping - '<Control-s>'
vim.keymap.set("i", "<C-u>", function()
	require("snippy").complete()
end, { silent = true })
--
-- require("snippy").setup({
-- 	snippet_dirs = "~/dotfiles/config/nvim/snippets/",
-- 	hl_group = "Search",
-- 	enable_auto = false,
-- 	scopes = {
-- 		_ = {},
--
-- 		lua = function(scopes)
-- 			if vim.api.nvim_buf_get_name(0):find("_spec.lua$") then
-- 				table.insert(scopes, "busted")
-- 			end
-- 			return scopes
-- 		end,
--
-- 		php = { "_", "php", "html", "javascript" },
-- 	},
-- 	mappings = {
-- 		is = {
-- 			["<Tab>"] = "expand_or_advance",
-- 			["<S-Tab>"] = "previous",
-- 		},
-- 		nx = {
-- 			["<leader>x"] = "cut_text",
-- 		},
-- 	},
-- })
