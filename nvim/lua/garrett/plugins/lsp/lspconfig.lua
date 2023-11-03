-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")
	-- set keybinds
	-- keymap.set(
	-- 	"n",
	-- 	"gf",
	-- 	"<cmd>lua require'telescope.builtin'.lsp_references(require'telescope.themes'.get_ivy({}))<CR>",
	-- 	opts
	-- ) -- show definition, references
	keymap.set("n", "<leader>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>") -- got to declaration
	keymap.set("n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>") -- see definition and make edits in window
	keymap.set("n", "<leader>gdd", "<cmd>Lspsaga goto_definition<CR>") --
	keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>") -- go to implementation
	keymap.set("n", "<leader>gca", "<cmd>Lspsaga code_action<CR>") -- see available code actions
	keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>") -- see available code actions
	-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>") -- smart rename
	keymap.set("n", "<leader>gae", "<cmd>lua require'telescope.builtin'.diagnostics()<CR>") -- show  diagnostics for line
	keymap.set("n", "<leader>ge", "<cmd>lua vim.diagnostic.open_float()<CR>") -- show  diagnostics for line
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_cursor_diagnostics<CR>") -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>") -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>") -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>") -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>") -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte", "python" },
})

-- configure intelephense server (php)
lspconfig["intelephense"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		intelephense = {
			environment = {
				includePaths = "<value>",
			},
		},
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
