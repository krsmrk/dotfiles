return {
	'nvimdev/lspsaga.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter', -- optional
		'nvim-tree/nvim-web-devicons', -- optional
	},
	after = 'nvim-lspconfig',
	config = function()
		require('lspsaga').setup({
			code_action = { show_server_name = true },
			symbol_in_winbar = {
				enable = true,
				color_mode = false
			},
		})
	end,
}
