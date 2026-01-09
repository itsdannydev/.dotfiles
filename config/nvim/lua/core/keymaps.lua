-- Set leader key 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebas key's default behaviour in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness 
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>',opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- deletes just a single character, without copying into the register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>>', opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set('n', '+', '<C-a>', opts) --increment
vim.keymap.set('n', '-', '<C-x>', opts) --decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split the window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split the window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- makes split windows with equal width and height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between the splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts) -- select the upper split window
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts) -- select the lower split window
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts) -- select the left split window
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts) -- select the right split window 

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- opens a new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) --closes the current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) -- next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) -- previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts) 

-- Stay in indent mode (otherwise it will exit Visual Mode after one indentation)
-- select line(s) and use > or < to adjust indent
vim.keymap.set('v', '<', '<gv', opts) -- increase indent
vim.keymap.set('v', '>', '>gv', opts) -- decrease indent

-- Keep last yanked(copied) when pasting
-- By default, the delete operation(_d) overwrites the yank register 
vim.keymap.set('v', 'p', '"_dP', opts)


-- Toggle diagnostics (Errors in code)
local diagnostics_active = true
vim.keymap.set('n', '<leader>do', function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.enable(true)
    else
        vim.diagnostic.enable(false)
    end
end)

-- Diagnostics keymaps
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Saving and Loading Coding sessions
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })
