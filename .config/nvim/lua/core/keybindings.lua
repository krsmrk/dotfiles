local vim = vim

-- Clear highlight search on pressing <Esc> in normal mode
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-[>', '<cmd>nohlsearch<CR>')

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>qf', quickfix, { noremap=true, silent=true })
