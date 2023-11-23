local MIN_WIDTH = 30
local FULL_WIDTH = 70


vim.opt['showmode'] = false
vim.opt['laststatus'] = 2



local fileformat = function()
  local winwidth = vim.fn.winwidth(0)
  if(winwidth <= MIN_WIDTH) then
    return ''
  end
  local fileformat = vim.api.nvim_buf_get_option(0, 'fileformat')
  if(winwidth >= FULL_WIDTH) then
    if(fileformat ~= 'unix') then
      return fileformat
    end
  end
  return ''
end

local fileencoding = function()
  local winwidth = vim.fn.winwidth(0)
  if(winwidth <= MIN_WIDTH) then
    return ''
  end
  local encoding = vim.api.nvim_buf_get_option(0, 'fileencoding')
  if(winwidth >= FULL_WIDTH) then
    if(encoding ~= 'utf-8') then
      return encoding
    end
  end
  return ''
end

local filetype = function()
  local winwidth = vim.fn.winwidth(0)
  if(winwidth <= MIN_WIDTH) then
    return ''
  end
  local filetype = vim.bo.filetype
  if(winwidth >= FULL_WIDTH) then
    if(filetype == '') then
      return '[no ft]'
    end
    return filetype
  end
end


vim.g.lightline_funcs = {
  fileformat   = fileformat,
  fileencoding = fileencoding,
  filetype     = filetype,
}

vim.g.lightline = {
  colorscheme = 'iceberg',
  active = {
    left = {
      { 'mode', },
      { 'filename', },
      { 'modified', },
    },
    right = {
      { 'lineinfo', },
      { 'percent', },
      { 'fileformat', 'fileencoding', 'filetype', }
    },
  },
  inactive = {
    left = {
      { 'filename', 'modified', },
    },
    right = {
      { 'percent',  'lineinfo', },
    },
  },
  component_function = {
    fileformat = 'g:lightline_funcs["fileformat"]',
    fileencoding = 'g:lightline_funcs["fileencoding"]',
    filetype = 'g:lightline_funcs["filetype"]',
  },
}

