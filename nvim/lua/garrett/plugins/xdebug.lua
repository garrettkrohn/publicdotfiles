-- https://github.com/xdebug/vscode-php-debug/releases
-- Extract the vsix content
local dap = require("dap")
local dapui = require("dapui")
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { "../../dotfiles/vscode-php-debug/out/phpdebug.js" },
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for xdebug",
		port = 9003,
		log = true,
		pathMappings = {
			["/var/www/html/acct"] = "${workspaceFolder}",
		},
		-- serverSourceRoot = "/var/www/html/acct",
		-- localSourceRoot = "/Users/garrettkrohn/code/kipsu",
	},
}

require("nvim-dap-virtual-text").setup()
require("dapui").setup({
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.5,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
			},
			position = "left",
			size = 80,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.75,
				},
				{
					id = "console",
					size = 0.25,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
})

-- vim.keymap.set("n", "<F5>", function()
-- 	require("dap").continue()
-- end)
vim.keymap.set("n", "<F9>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_into()
end)
-- vim.keymap.set("n", "<F12>", function()
-- 	require("dap").step_out()
-- end)
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
-- vim.keymap.set("n", "<Leader>B", function()
-- 	require("dap").set_breakpoint()
-- end)
-- vim.keymap.set("n", "<Leader>lp", function()
-- 	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end)
-- vim.keymap.set("n", "<Leader>dr", function()
-- 	require("dap").repl.open()
-- end)
-- vim.keymap.set("n", "<Leader>dl", function()
-- 	require("dap").run_last()
-- end)
-- vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
-- 	require("dap.ui.widgets").hover()
-- end)
-- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
-- 	require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "<Leader>df", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.scopes)
-- end)
--
vim.keymap.set("n", "<Leader>do", function()
	require("dapui").open()
end)
vim.keymap.set("n", "<Leader>dx", function()
	require("dapui").close()
end)
vim.keymap.set("n", "<Leader>dg", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<Leader>dt", function()
	require("dap").terminate()
end)

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
