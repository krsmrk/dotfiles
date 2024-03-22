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

