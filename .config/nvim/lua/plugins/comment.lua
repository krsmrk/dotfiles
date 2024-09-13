return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- Embedded language support
	},
	setup = function()
		local context_comment = require("ts_context_commentstring")
		pre_hook = context_comment.calculate_commentstring() or vim.bo.commentstring
		local c = require("Comment")
		c.setup({ pre_hook = pre_hook })
	end,
}
