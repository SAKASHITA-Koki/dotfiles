-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = function(mode, lhs, rhs, options)
  options = options or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- normal
local nmap = function(lhs, rhs, options)
  map("n", lhs, rhs, options)
end
-- insert
local imap = function(lhs, rhs, options)
  map("i", lhs, rhs, options)
end
-- visual
local vmap = function(lhs, rhs, options)
  map("v", lhs, rhs, options)
end
-- visual block
local xmap = function(lhs, rhs, options)
  map("x", lhs, rhs, options)
end
-- terminal
local tmap = function(lhs, rhs, options)
  map("t", lhs, rhs, options)
end
-- command
local cmap = function(lhs, rhs, options)
  map("c", lhs, rhs, options)
end

-- ------------------------------

imap("jj", "<ESC>")
-- U for redo
nmap("U", "<C-r>")
-- vv for enter visual-block mode
--   (enter visual mode with the formerv and then the latter v for enter visual-block)
vmap("v", "<C-v>")
-- mark with m, jump with M (more intuitive than `)
nmap("M", "`")
-- better cursor/window moving
nmap("s", "<NOP>")
nmap("sh", "<C-w>h")
nmap("sj", "<C-w>j")
nmap("sk", "<C-w>k")
nmap("sl", "<C-w>l")
nmap("sH", "<C-w>H")
nmap("sJ", "<C-w>J")
nmap("sK", "<C-w>K")
nmap("sL", "<C-w>L")

-- nmap('<C-s>', ':w<CR>')
-- imap('<C-s>', '<ESC>:w<CR>')
-- nmap('<C-q>', ':qa<CR>')
-- imap('<C-q>', '<ESC>:qa<CR>')
-- nmap('<C-S-S>', ':wa<CR>')
-- imap('<C-S-S>', '<ESC>:wa<CR>')

-- imap('<C-h>', '<LEFT>')
-- imap('<C-j>', '<DOWN>')
-- imap('<C-k>', '<UP>')
-- imap('<C-l>', '<RIGHT>')
-- cmap('<C-h>', '<LEFT>')
-- cmap('<C-l>', '<RIGHT>')

-- nmap('j', 'gj')
-- nmap('k', 'gk')
nmap("H", "^")
nmap("L", "$")
nmap("J", "<C-d>")
nmap("K", "<C-u>")
-- nmap('W', 'b')

nmap("+", "<C-a>")
nmap("-", "<C-x>")

-- nmap(
--   '<SPACE><SPACE>',
--   '"zyiw:let @/=\'\\<\'.@z.\'\\>\'<CR>:set hlsearch<CR>'
-- )
-- nmap(
--   '#',
--   '"zyiw:let @/=\'\\<\'.@z.\'\\>\'<CR>:set hlsearch<CR>:%s/<C-r>///g<LEFT><LEFT>'
-- )
nmap("<ESC><ESC>", ":noh<CR>")

nmap("<C-j>", '"zdd"zp')
nmap("<C-k>", '"zdd<Up>"zP')
vmap("<C-j>", '"zx"zp`[V`]')
vmap("<C-k>", '"zx<UP>"zP`[V`]')

-- append comma
nmap(",,", "mzA,<ESC>`z")
imap(",,", "<ESC>mzA,<ESC>`za")

tmap("<C-n><C-n>", "<C-\\><C-n>")
tmap("<C-w>", "<C-\\><C-n><C-w>")
tmap("<C-S-W>", "<C-\\><C-n><C-S-W>")
