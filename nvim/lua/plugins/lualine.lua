vim.opt['showmode'] = false

require('lualine').setup({
  options = {
    -- component_separators = { left = '|', right = '|'},
    -- section_separators = { left = ' ', right = ' ' },
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {'TelescopePrompt'},
    always_divide_middle = true,
    colored = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      {
        'filename',
        path = 1,
        file_status = true,
        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[RO]',
          unnamed = 'Untitled',
        }
      }
    },
    lualine_x = {
      {
        'diagnostics',
        source = {'nvim-lsp'},
      },
      'filetype'
    },
    lualine_y = {
      {'progress'},
      {'location'}
    },
    lualine_z = {''}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
})

