vim.g.user_emmet_mode = 'a'
vim.g.user_emmet_leader_key = '<Plug>'
vim.g.user_emmet_setting = {
  javascriptreact = {
    extends = 'jsx',
  },
  typescriptreact = {
    extends = 'tsx',
  },
}
local options = {
  noremap = true,
  silent = true,
  -- buffer = 0,
}
vim.keymap.set('n', ',,', '<Plug>(emmet-expand-abbr)<ESC>', options)
vim.keymap.set('i', ',,', '<Plug>(emmet-expand-abbr)<ESC>', options)
vim.keymap.set('v', ',,', '<Plug>(emmet-expand-abbr)<ESC>', options)
vim.keymap.set('x', ',,', '<Plug>(emmet-expand-abbr)<ESC>', options)

