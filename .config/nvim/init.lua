-- Map leader key to space.
-- Must happen before any plugin setup or wrong leader key will be mapped.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Do replace tabs with spaces.
vim.opt.expandtab = false

-- Display size of <Tab>.
vim.opt.tabstop = 4

-- Number of blanks for indentation commands. Uses tabstop when 0.
vim.opt.shiftwidth = 0

-- With 'expandtab' the number of spaces to add/remove for <Tab>/<Backspace>.
-- Otherwise number of spaces to replace by single tab character.
-- Equal to 'tabstop' for negative values.
vim.opt.softtabstop = -1

-- Apply shiftwidth at start of line and softtabstop elsewhere for tab key.
vim.opt.smarttab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

-- Bootstrap lazy.nvim plugin manager
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

-- Load all plugin configurations from lua files in plugin folder
require("lazy").setup("plugins")

-- Theme
require("nightfox").setup()
vim.cmd [[colorscheme nordfox]]

-- Start lualine
require("lualine").setup()

-- Use native-fzf in Telescope
require('telescope').load_extension('fzf')
require('user.keybindings')
require('plugin-config/format-on-save')

local servers = {
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}
--  Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end
}

local lspconfig = require('lspconfig')

lspconfig.terraformls.setup {}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars", "*.hcl" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
