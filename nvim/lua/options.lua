local options = {


  -- Basic
  shell = 'zsh',
  background = 'dark',
  backspace = { 'indent', 'eol', 'start' },
  showcmd = false,
  virtualedit = 'block',
  wildmode = 'list:full',
  spell = false,
  clipboard = 'unnamedplus',



  -- Apprearance
  number = true,
  cursorline = true,
  laststatus = 2,
  statusline = '%m%f%=%l:%c [%p%%]',


  -- Indentation

  -- When 'softtabstop' is zero, expandtab is disabled.
  -- Or when it is negative value(-1), the 'shiftwidth' value is used instead.
  --
  -- When 'shiftwidth' is zero, the 'tabstop' value is used instead.
  --
  -- So, both of values softtabstop=-1 and shiftwidth=0 results in
  -- the 'tabstop' value.
  smartindent = false,
  autoindent = true,
  expandtab = true,
  tabstop = 2,
  softtabstop = -1,
  shiftwidth = 0,

  -- Make tabs and spaces visible
  list = true,
  listchars = { tab = '>-', trail = '.' },


  -- Searching
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  wrapscan = true,
  hlsearch = true


}


for key, value in pairs(options) do
  vim.opt[key] = value
end

