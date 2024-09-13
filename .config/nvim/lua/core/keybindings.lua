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

-- Toggle relative line numbers
vim.keymap.set("n", "<Leader>r", "<cmd>set relativenumber!<cr>", { noremap=true, silent=true })

-- LSP functionality
vim.keymap.set('n', '<leader>ih', '<cmd>Lspsaga hover_doc<CR>')
vim.keymap.set('n', '<leader>ir', '<cmd>Lspsaga rename<CR>') -- navigate
vim.keymap.set('n', '<leader>ia', '<cmd>Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>iu', '<cmd>Lspsaga incoming_calls<CR>')
vim.keymap.set('n', '<leader>ic', '<cmd>Lspsaga outgoing_calls<CR>')
vim.keymap.set('n', '<leader>ip', '<cmd>Lspsaga peek_definition<CR>')
vim.keymap.set('n', '<leader>il', '<cmd>Lspsaga peek_type_definition<CR>') --look
vim.keymap.set('n', '<leader>id', '<cmd>Lspsaga goto_definition<CR>')
vim.keymap.set('n', '<leader>it', '<cmd>Lspsaga goto_type_definition<CR>')
vim.keymap.set('n', '<leader>in', '<cmd>Lspsaga outline<CR>') -- navigate
vim.keymap.set('n', '<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
vim.keymap.set('n', '<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<CR>')
