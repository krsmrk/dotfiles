local vim = vim
-- Map leader key to space.
-- Must happen before any plugin setup or wrong leader key will be mapped.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.cmdheight = 0

-- Do replace tabs with spaces.
vim.opt.expandtab = false

-- Display size of <Tab>.
vim.opt.tabstop = 4

-- Do not wrap long lines.
vim.opt.wrap = false

-- Number of blanks for indentation commands. Uses tabstop when 0.
vim.opt.shiftwidth = 4

-- With 'expandtab' the number of spaces to add/remove for <Tab>/<Backspace>.
-- Otherwise number of spaces to replace by single tab character.
-- Equal to 'tabstop' for negative values.
vim.opt.softtabstop = -1

-- Apply shiftwidth at start of line and softtabstop elsewhere for tab key.
vim.opt.smarttab = true

-- Automatically indent newline
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Continue indentation after line break
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Show whitespace in editor
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 99

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-[>', '<cmd>nohlsearch<CR>')

-- Case-insensitive searching unless \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions live while typing
vim.opt.inccommand = 'split'

vim.g.have_nerd_font = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- The current mode is already in the status line
vim.opt.showmode = false

-- No initial folding
vim.opt.foldenable = false

-- Open split windows on other side
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us,de_20"
vim.spelloptions = "camel"
