function statusline()
	local noice = require("noice")
	return {
		noice.api.statusline.mode.get,
		cond = noice.api.statusline.mode.has,
	}
end

-- Theme does not integrate well.
local breadcrumbs = function()
	local crumbs = require("lspsaga.symbol.winbar").get_bar()
	if crumbs == nil then return "..." else return crumbs end
end

local empty = function()
	return "I bims"
end

return {
	{

		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			-- Start lualine
			local ll = require("lualine")
			ll.setup(
				{
					options = {
						theme = "nord",
						globalstatus = true,
						icons_enabled = true,
					},
					sections = {
						lualine_b = {
							'branch',
							'diff',
							'diagnostics',
						},
						lualine_c = {
							"filename",
						},
						lualine_x = {
							statusline(),
							"encoding",
							"fileformat",
							"filetype",
						},
					}
				}
			)
		end,
	},
}
