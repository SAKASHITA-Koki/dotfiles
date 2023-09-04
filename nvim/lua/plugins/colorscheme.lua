vim.cmd('colorscheme iceberg')


-- NOTE: SCHEME SPECIFIC!

local namespace = 0 -- global

vim.api.nvim_set_hl(namespace, 'Whitespace', {
  link = 'ErrorMsg',
})
vim.api.nvim_set_hl(namespace, 'Search', {
  fg = '#e8e9ec',
  bg = '#33374c',
  underline = true,
})
vim.api.nvim_set_hl(namespace, 'FloatBorder', {
  link = 'Comment',
})
vim.opt['termguicolors'] = true


-- cutomize diagnostic highlight
local severity_colors = {
  Error = '#e27878',
  Warn  = '#e2a478',
  Info  = '#89b8c2',
  Hint  = '#6b7089'
}

-- munsell system (same hue, value: 4.0, chroma: 2.5)
vim.api.nvim_set_hl(namespace, 'DiagnosticHint',
                    { fg = '#6d7089', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineHint',
                    { fg = '#6d7089', bg = 'bg',
                      sp = '#6d7089', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextHint',
                    { fg = '#6d7089', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticInfo',
                    { fg = '#89b8c2', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineInfo',
                    { fg = '#89b8c2', bg = 'bg',
                      sp = '#89b8c2', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextInfo',
                    { fg = '#697f85', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticWarn',
                    { fg = '#e2a478', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineWarn',
                    { fg = '#e2a478', bg = 'bg',
                      sp = '#e2a478', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextWarn',
                    { fg = '#755b4b', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticError',
                    { fg = '#e27878', bg = 'bg' })
vim.api.nvim_set_hl(namespace, 'DiagnosticUnderlineError',
                    { fg = '#e27878', bg = 'bg',
                      sp = '#e27878', underline = true, bold = true })
vim.api.nvim_set_hl(namespace, 'DiagnosticVirtualTextError',
                    { fg = '#795759', bg = 'bg' })


-- for severity_name, severity_color in pairs(severity_colors) do
--   local normal_name = 'Diagnostic' .. severity_name
--   local underline_name = 'DiagnosticUnderline' .. severity_name
--   local sign_name = 'DiagnosticSign' .. severity_name
--   local floating_name = 'DiagnosticFloating' .. severity_name
--   vim.api.nvim_set_hl(namespace, normal_name, {
--     fg = severity_color,
--     bg = 'bg',
--   })
--   vim.api.nvim_set_hl(namespace, underline_name, {
--     fg = severity_color,
--     bg = 'bg',
--     sp = severity_color,
--     underline = true,
--     bold = true,
--   })
--   vim.api.nvim_set_hl(namespace, sign_name, {
--     link = normal_name,
--   })
--   vim.api.nvim_set_hl(namespace, floating_name, {
--     fg = severity_color,
--     bg = 'bg',
--   })
-- end
-- vim.api.nvim_set_hl(namespace, 'DiagnosticFloatingHint', {
--   fg = 'fg',
--   bg = 'bg',
-- })

-- customize floating window
vim.api.nvim_set_hl(namespace, 'NormalFloat', {
  bg = 'bg',
})
vim.api.nvim_set_hl(namespace, 'FloatBorder', {
  fg = 'fg',
  bg = 'bg',
  link = 'Comment',
})

