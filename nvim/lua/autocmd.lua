local autocmd = vim.api.nvim_create_autocmd

local id = vim.api.nvim_create_augroup('MyAutocmdGroup', { clear = true })


autocmd(
  { 'VimEnter', 'WinEnter', 'WinResized', 'VimResized' },
  {
    group = id,
    -- pattern = { '*' },
    desc = 'keep the cursor in the middle of the window',
    callback = function()
      local winid = vim.api.nvim_get_current_win()
      local height = vim.fn.winheight(winid)
      vim.wo[winid].scrolloff = math.floor((height - 2) / 3)
    end,
  }
)


autocmd(
  { 'TermOpen' },
  {
    group = id,
    -- pattern = { '*' },
    desc = 'enter the insert mode when a terminal opened',
    callback = function()
      local winid = vim.api.nvim_get_current_win()
      vim.wo[winid].number = false
      vim.cmd('startinsert')
    end,
  }
)

autocmd(
  { 'TermClose' },
  {
    group = id,
    -- pattern = { '*' },
    desc = 'close the window when the terminal exited',
    callback = function()
      vim.cmd(':q')
    end,
  }
)

autocmd(
  { 'BufEnter' },
  {
    group = id,
    -- pattern = { '*' },
    desc = 'custom keymaps for reading help',
    callback = function()
      if(vim.bo.buftype == 'help') then
        vim.keymap.set('n', '<C-{>', '<C-t><C-o>', {
          buffer = 0,
          remap = false,
        })
      end
    end,
  }
)

-- autocmd(
--   { 'VimEnter' },
--   {
--     group = id,
--     -- pattern = { '*' },
--     desc = 'hide tmux status line',
--     callback = function()
--       vim.cmd('silent !tmux set status off')
--     end,
--   }
-- )


-- autocmd(
--   { 'VimLeave' },
--   {
--     group = id,
--     -- pattern = { '*' },
--     desc = 'enable tmux status line',
--     callback = function()
--       vim.cmd('silent !tmux set status on')
--     end,
--   }
-- )


-- autocmd(
--   { 'CmdlineLeave' },
--   {
--     group = id,
--     pattern = { '*' },
--     desc = 'clear cmdline',
--     callback = function()
--       vim.fn.timer_start(3000, function()
--         print(' ')
--       end)
--     end,
--   }
-- )


autocmd(
  { 'InsertEnter' },
  {
    group = id,
    pattern = { '*' },
    desc = 'clear the cmdline when enter the insert mode',
    callback = function()
      print(' ')
    end,
  }
)


autocmd(
  { 'WinEnter' },
  {
    group = id,
    desc = 'enter the insert mode when the cursor moved to the terminal window',
    callback = function()
      if vim.bo.buftype == 'terminal' then
        vim.cmd('startinsert')
      end
    end
  }
)


autocmd(
  { 'FileType' },
  {
    group = id,
    pattern = { '*' },
    desc = 'stop putting comments in front of new lines',
    callback = function ()
      vim.opt.formatoptions:remove('c')
      vim.opt.formatoptions:remove('r')
      vim.opt.formatoptions:remove('o')
    end
  }
)

