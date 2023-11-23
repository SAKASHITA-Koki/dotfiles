vim.cmd('colorscheme iceberg')


-- NOTE: SCHEME SPECIFIC!

local namespace = 0 -- global

vim.api.nvim_set_hl(namespace, 'Whitespace', {
  link = 'ErrorMsg',
})
vim.api.nvim_set_hl(namespace, 'Search', {
  bg = '#33374c',
  underline = true,
})
vim.api.nvim_set_hl(namespace, 'FloatBorder', {
  link = 'Comment',
})
vim.opt['termguicolors'] = true


-- munsell system (same hue, value: 4.0, chroma: 2.5)
vim.api.nvim_set_hl(namespace, 'DiagnosticHint',
                    { fg = '#6d7089' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineHint',
                    { fg = '#6d7089',
                      sp = '#6d7089', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextHint',
                    { fg = '#6d7089' })
vim.api.nvim_set_hl(namespace, 'DiagnosticInfo',
                    { fg = '#89b8c2' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineInfo',
                    { fg = '#89b8c2',
                      sp = '#89b8c2', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextInfo',
                    { fg = '#697f85' })
vim.api.nvim_set_hl(namespace, 'DiagnosticWarn',
                    { fg = '#e2a478' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineWarn',
                    { fg = '#e2a478',
                      sp = '#e2a478', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextWarn',
                    { fg = '#755b4b' })
vim.api.nvim_set_hl(namespace, 'DiagnosticError',
                    { fg = '#e27878' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineError',
                    { fg = '#e27878',
                      sp = '#e27878', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextError',
                    { fg = '#795759' })

-- customize floating window
vim.api.nvim_set_hl(namespace, 'NormalFloat', {
  bg = 'bg',
})
vim.api.nvim_set_hl(namespace, 'FloatBorder', {
  fg = 'fg',
  bg = 'bg',
  link = 'Comment',
})

