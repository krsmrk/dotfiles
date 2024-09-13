return {
	{
		"danymat/neogen",
		version = "*",
		enabled = true,
		config = function()
			local neogen = require('neogen')
			neogen.setup()
			-- neogen.setup({ snippet_engine = "luasnip" })
		end,
	}
}
