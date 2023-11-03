local bufferline = require("bufferline")
bufferline.setup({
	options = {
		mode = "buffers",
		separator_style = "thick",
		always_show_bufferline = false,
		show_buffer_close_icons = true,
		show_close_icon = true,
		color_icons = true,
		close_icons = true,
		buffer_close_icon = "X",
	},
	highlights = {
		separator = {
			guifg = "#073642",
			guibg = "#002b36",
		},
		separator_selected = {
			guifg = "#073642",
		},
		background = {
			guifg = "#657b83",
			guibg = "#002b36",
		},
		buffer_selected = {
			guifg = "#fdf6e3",
			gui = "bold",
		},
		fill = {
			guibg = "#073642",
		},
	},
})

vim.g.transparent_groups = vim.list_extend(
	vim.g.transparent_groups or {},
	vim.tbl_map(function(v)
		return v.hl_group
	end, vim.tbl_values(require("bufferline.config").highlights))
)

vim.keymap.set("n", "<S-L>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-H>", "<Cmd>BufferLineCyclePrev<CR>", {})
