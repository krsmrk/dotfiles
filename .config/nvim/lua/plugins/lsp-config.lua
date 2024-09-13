local vim = vim
local inlay_hints = function(_, _)
-- Args: client, buffer_number
	if vim.lsp.inlay_hint then
		local current_buffer_number = 0
		vim.keymap.set("n", "<leader>h", function()
			if vim.lsp.inlay_hint.is_enabled({bufnr=current_buffer_number}) then
				vim.lsp.inlay_hint.enable(false, {bufnr=current_buffer_number})
				vim.notify("Inlay hints off.")
			else
				vim.lsp.inlay_hint.enable(true, {bufnr=current_buffer_number})
				vim.notify("Inlay hints on.")
			end
		end, { desc = "Toggle inlay hints." })
	end
end

local servers = {
	basedpyright = {
		settings = {
			basedpyright = {
				analysis = {
					-- Using Ruff's import organizer
					disableOrganizeImports = true,
					typeCheckingMode = "standard",
					-- Ignore all files for analysis to exclusively use Ruff for linting
					--ignore = { '*' },
				},
			},
		},
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	sqlls = {},
	terraformls = {
		on_attach = function()
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				pattern = { "*.tf", "*.tfvars", "*.hcl" },
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end,
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		-- `opts = {}` is the same as calling `require("fidget").setup({})`
		{ "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", opts = {} },
		{ "folke/neodev.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		-- Currently Mason itself does not support "ensure_installed"
		-- mason_lspconfig support "ensure_installed" for LSPs
		-- Use mason-tool-installer instead for other tools
		local install_list = {}
		for _, v in pairs(vim.tbl_keys(servers)) do
			table.insert(install_list, v)
		end

		mason.setup()
		mason_tool_installer.setup({
			ensure_installed = {
				"biome",
				"csharpier",
				"cspell",
				"stylua",
			},
		})

		mason_lspconfig.setup({
			ensure_installed = install_list,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				local server_setup = (servers[server_name] or {})
				server_setup.capabilities = capabilities
				server_setup.on_attach = inlay_hints
				lspconfig[server_name].setup(server_setup)
			end,
		})
	end,
}
