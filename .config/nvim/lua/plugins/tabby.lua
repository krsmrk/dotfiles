local modified = ""
local unmodified = ""
local tab_modified = function(tab_id)
	local wins = require("tabby.module.api").get_tab_wins(tab_id)
	for i, x in pairs(wins) do
		if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
			return modified
		end
	end
	return unmodified
end

local buffer_modified = function(win_id)
	if vim.bo[vim.api.nvim_win_get_buf(win_id)].modified then
		return modified
	end
	return unmodified
end

local build_tabline = function(line)
	local theme = {
		fill = 'TabLineFill',
		-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
		head = 'TabLine',
		current_tab = 'TabLineSel',
		tab = 'TabLine',
		win = 'TabLine',
		tail = 'TabLine',
	}
	return {
		{
			{ '  ', hl = theme.head },
			line.sep('', theme.head, theme.fill),
		},
		line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			return {
				line.sep('', hl, theme.fill),
				--tab.is_current() and '' or '󰆣',
				tab_modified(tab.id),
				tab.number(),
				tab.name(),
				tab.close_btn(''),
				line.sep('', hl, theme.fill),
				hl = hl,
				margin = ' ',
			}
		end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			local hl = win.is_current() and theme.current_tab or theme.tab
			return {
				line.sep('', hl, theme.fill),
				--win.is_current() and '' or '',
				buffer_modified(win.id),
				win.buf_name(),
				line.sep('', hl, theme.fill),
				hl = hl,
				margin = ' ',
			}
		end),
		{
			line.sep('', theme.tail, theme.fill),
			{ '  ', hl = theme.tail },
		},
		hl = theme.fill,
	}
end

return {
	'nanozuki/tabby.nvim',
	event = 'VimEnter',
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		local tabby = require("tabby")
		tabby.setup({ line = build_tabline })
		-- configs...
	end,
}
