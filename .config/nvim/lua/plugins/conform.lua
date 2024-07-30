return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylelua" },
			-- python = { "isort", "black" },
			python = { "ruff_organize_imports", "ruff_fix", "ruff_format"},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	keys = {
		{
			"<leader>f",
			function() require("conform").format({ lsp_fallback = true }) end,
			desc = "Format",
		},
	},
}
