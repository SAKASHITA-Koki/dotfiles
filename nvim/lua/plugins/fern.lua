local options = { noremap = true, silent = true }
vim.keymap.set('n', '<LEADER>t', ':Fern . -reveal=%<CR>', options)
vim.keymap.set('n', '<LEADER>s', ':Fern . -opener=split -reveal=%<CR>', options)
vim.keymap.set('n', '<LEADER>v', ':Fern . -opener=vsplit -reveal=%<CR>', options)
vim.keymap.set('n', '<LEADER>d', ':Fern . -drawer -reveal=%<CR>', options)

vim.g['fern#hide_cursor'] = true

local id = vim.api.nvim_create_augroup('FernInit', { clear = true })
vim.api.nvim_create_autocmd(
  { 'FileType' },
  {
    group = id,
    pattern = 'fern',
    callback = function()
      -- vim.api.nvim_buf_set_option(0, 'number', false)
      vim.opt_local.number = false
      local options = {
        noremap = false,
        silent = true,
        buffer = 0,
        nowait = true,
      }
      vim.keymap.set('n',
        '<Plug>(fern-close-drawer)',
        ':<C-u>FernDo close -drawer -stay<CR>',
        { noremap = true, silent = true, nowait = true }
      )
      vim.keymap.set('n',
        '<Plug>(fern-action-open-and-close)',
        '<Plug>(fern-action-open)<Plug>(fern-close-drawer)',
        options
      )
      -- couldn't replace vim.keymap.set somehow
      vim.cmd([[
        nmap <expr><buffer>
          \ <Plug>(fern-action-open-expand-collapse)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open-and-close)",
          \   "\<Plug>(fern-action-expand)",
          \   "\<Plug>(fern-action-collapse)"
          \ )
      ]])
      vim.keymap.set('n', '<CR>',
        '<Plug>(fern-action-open-expand-collapse)',
        { noremap = false, buffer = 0, silent = true, nowait = true }
      )
      vim.keymap.set('n', 's',
        '<Plug>(fern-action-open:split)<C-w><C-p>', options)
      vim.keymap.set('n', 'v',
        '<Plug>(fern-action-open:vsplit)<C-w><C-p>', options)
      vim.keymap.set('n', '<C-k>', '<Plug>(fern-action-collapse)', options)
      vim.keymap.set('n', '<C-j>', '<Plug>(fern-action-expand)', options)
      vim.keymap.set('n', 'a', '<Plug>(fern-action-new-path)', options)
      vim.keymap.set('n', 'c', '<Plug>(fern-action-new-path)', options)
      vim.keymap.set('n', 'd', '<Plug>(fern-action-trash)', options)
      vim.keymap.set('v', 'd', '<Plug>(fern-action-trash)', options)
      vim.keymap.set('x', 'd', '<Plug>(fern-action-trash)', options)
      vim.keymap.set('n', 'm', '<Plug>(fern-action-rename)', options)
      vim.keymap.set('v', 'm', '<Plug>(fern-action-rename)', options)
      vim.keymap.set('x', 'm', '<Plug>(fern-action-rename)', options)
      vim.keymap.set('n', 'r', '<Plug>(fern-action-reload)', options)
      vim.keymap.set('n', 'q', ':<C-u>FernDo close -stay<CR>', options)
      vim.keymap.set('n', 'D', '<Plug>(fern-action-copy)', options)

    end,
  }
)

