--  The configuration is done below. Search for lspconfig to find it below.
return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'williamboman/mason.nvim', config = true },
		'williamboman/mason-lspconfig.nvim',
		-- `opts = {}` is the same as calling `require('fidget').setup({})`
		{ 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = {} },
		'folke/neodev.nvim',
	},
}
