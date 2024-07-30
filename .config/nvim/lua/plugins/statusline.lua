return {
	{

		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			-- Start lualine
			require("lualine").setup()
		end,
	},
}
