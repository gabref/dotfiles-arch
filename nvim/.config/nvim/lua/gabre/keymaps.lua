local map = require('gabre.utils').map

map('n', '<leader>pv', vim.cmd.Ex)
map('i', 'jk', '<esc>')
map('n', '<leader>w', ':w<cr>')
map('n', '<leader>q', ':q<cr>')
map('i', '<C-c>', '<esc>')

-- navigate buffers
map('n', '<s-l>', ':bnext<cr>')
map('n', '<s-h>', ':bprevious<cr>')

-- move text up and down and keep indenting
map("v", "<a-j>", ":m '>+1<CR>gv=gv")
map("v", "<a-k>", ":m '<-2<CR>gv=gv")

-- keep cursor
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- greatest remap ever
-- keeps the paste buffer
map("x", "<leader>p", [["_dP]])
map("n", "<leader>d", [["_d]])
map("v", "<leader>d", [["_d]])
-- next greatest remap ever : asbjornHaland
map("n", "<leader>y", [["+y]])
map("v", "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map("n", "Q", "<nop>")
-- TODO: my script for session
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quick fix list
map("n", "[q", "<cmd>cnext<CR>zz")
map("n", "]q", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search and replace
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make executable
-- vim.map.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

-- shout outtt
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Resize with arrows
map("n", "<c-Up>", ":resize -2<CR>")
map("n", "<c-Down>", ":resize +2<CR>")
map("n", "<c-Left>", ":vertical resize -2<CR>")
map("n", "<c-Right>", ":vertical resize +2<CR>")

-- execute
-- execute current line
map("n", "<leader>xl", "<cmd>.lua<CR>")
-- execute current file
map("n", "<leader>xf", "<cmd>source %<CR>")

-- navigation in command line
map('c', '<c-h>', '<Home>')
map('c', '<c-l>', '<End>')
map('c', '<c-f>', '<Right>')
map('c', '<c-b>', '<Left>')

-- comment
-- map("n", "<leader>c", "gcc")
-- map("x", "<leader>c", "gc")
-- map('n', 'gco', 'o<Esc>Vcx<Esc><cmd>normal gcc<CR>fxa<BS>', { noremap = true, silent = true)
-- map('n', 'gcO', 'O<Esc>Vcx<Esc><cmd>normal gcc<CR>fxa<BS>', { noremap = true, silent = true)
