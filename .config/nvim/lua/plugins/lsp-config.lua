local vim = vim
local servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		}
	},
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
	terraformls = {
		on_attach = function()
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				pattern = { "*.tf", "*.tfvars", "*.hcl" },
				callback = function()
					vim.lsp.buf.format()
				end
			})
		end,
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim",          config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		-- `opts = {}` is the same as calling `require("fidget").setup({})`
		{ "j-hui/fidget.nvim",                tag = "legacy", event = "LspAttach", opts = {} },
		{ "folke/neodev.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
	},

	config = function()

		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		--lspconfig.ruff.setup({})

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup_handlers {
			function(server_name)
				local server_setup = (servers[server_name] or {})
				server_setup.capabilities = capabilities
				lspconfig[server_name].setup(server_setup)
			end
		}
	end,
}
