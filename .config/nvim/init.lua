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

local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
	exclude_path_patterns = {
		"/node_modules/",
		".local/share/nvim/lazy",
	},
	formatter_by_ft = {
		css = formatters.lsp,
		html = formatters.lsp,
		java = formatters.lsp,
		javascript = formatters.lsp,
		json = formatters.lsp,
		lua = formatters.lsp,
		-- markdown = formatters.prettierd,
		openscad = formatters.lsp,
		python = formatters.black,
		rust = formatters.lsp,
		scad = formatters.lsp,
		scss = formatters.lsp,
		sh = formatters.shfmt,
		terraform = formatters.lsp,
		typescript = formatters.prettierd,
		typescriptreact = formatters.prettierd,
		yaml = formatters.lsp,

		-- Add conditional formatter that only runs if a certain file exists
		-- in one of the parent directories.
	},

	-- By default, all shell commands are prefixed with "sh -c" (see PR #3)
	-- To prevent that set `run_with_sh` to `false`.
	run_with_sh = false,
})
