require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = {
    -- 'tsserver',
    -- 'gdscript',
    -- 'astro',
  }
})


------------------------------

-- local function best_diagnostic(diagnostics)
--   if vim.tbl_isempty(diagnostics) then
--     return
--   end
--
--   local best = nil
--   local line_diagnostics = {}
--   local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
--
--   for k, v in pairs(diagnostics) do
--     if v.lnum == line_nr then
--       line_diagnostics[k] = v
--     end
--   end
--
--   for _, diagnostic in ipairs(line_diagnostics) do
--     if best == nil then
--       best = diagnostic
--     elseif diagnostic.severity < best.severity then
--       best = diagnostic
--     end
--   end
--
--   return best
-- end
--
-- local function current_line_diagnostics()
--   local bufnr = 0
--   local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
--   local opts = { ["lnum"] = line_nr }
--
--   return vim.diagnostic.get(bufnr, opts)
-- end
--
-- local signs = {
--   Error = " ",
--   Warn = " ",
--   Hint = " ",
--   Info = " ",
-- }
--
-- local virt_handler = vim.diagnostic.handlers.virtual_text
-- local ns = vim.api.nvim_create_namespace "current_line_virt"
-- local severity = vim.diagnostic.severity
-- local virt_options = {
--   prefix = "",
--   format = function(diagnostic)
--     local message = vim.split(diagnostic.message, "\n")[1]
--
--     if diagnostic.severity == severity.ERROR then
--       return signs.Error .. message
--     elseif diagnostic.severity == severity.INFO then
--       return signs.Info .. message
--     elseif diagnostic.severity == severity.WARN then
--       return signs.Warn .. message
--     elseif diagnostic.severity == severity.HINT then
--       return signs.Hint .. message
--     else
--       return message
--     end
--   end,
-- }
--
-- vim.diagnostic.handlers.current_line_virt = {
--   show = function(_, bufnr, diagnostics, _)
--     local diagnostic = best_diagnostic(diagnostics)
--     if not diagnostic then
--       return
--     end
--
--     local filtered_diagnostics = { diagnostic }
--
--     pcall(
--       virt_handler.show,
--       ns,
--       bufnr,
--       filtered_diagnostics,
--       { virtual_text = virt_options }
--     )
--   end,
--   hide = function(_, bufnr)
--     bufnr = bufnr or vim.api.nvim_get_current_buf()
--     virt_handler.hide(ns, bufnr)
--   end,
-- }


------------------------------



-- appearance customize
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  float = {
    header = '',
    border = 'rounded',
  },
  virtual_lines = false,
})
vim.opt['signcolumn'] = 'no'

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = 'rounded',
    width = 50,
  }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = 'rounded',
  }
)



mason_lspconfig.setup_handlers({
  function(server)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local options = {

      capabilities = capabilities,

      on_attach = function(client, bufnr)

        -- Signature setup
        require('lsp_signature').on_attach({
          bind = true,
          hint_enable = false,
          handler_opts = {
            -- double, rounded, single, shadow, none, or a table of borders
            border = 'rounded',
          },
        }, bufnr)


        -- LSP keymaps
        local bufmap = function(mode, lhs, rhs, options)
          options = options or { noremap = true, silent = true }
          options['buffer'] = bufnr
          vim.keymap.set(mode, lhs, rhs, options)
        end
        -- bufmap('n', '<SPACE>e',  vim.lsp.buf.hover)
        -- bufmap('n', 'gf', vim.lsp.buf.formatting)
        bufmap('n', 'gr', vim.lsp.buf.references)
        bufmap('n', 'gd', vim.lsp.buf.definition)
        bufmap('n', 'gD', vim.lsp.buf.declaration)
        bufmap('n', 'gi', vim.lsp.buf.implementation)
        bufmap('n', 'gt', vim.lsp.buf.type_definition)
        bufmap('n', 'gn', vim.lsp.buf.rename)
        -- bufmap('n', 'ga', vim.lsp.buf.code_action)
        bufmap('n', 'ge', vim.diagnostic.open_float)
        bufmap('n', '<C-n>', function ()
          vim.diagnostic.goto_next({ float = true })
        end
        )
        bufmap('n', '<C-S-n>', function ()
          vim.diagnostic.goto_prev({ float = true })
        end)

        local has_diagnostics = function()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local row = cursor[1]
          local col = cursor[2]
          local diagnostics = vim.diagnostic.get(0, { lnum = row-1 })
          for _, diagnostic in ipairs(diagnostics) do
            local diagnostic_col = diagnostic['col']
            local diagnostic_end_col = diagnostic['end_col']
            if(diagnostic_col <= col and col < diagnostic_end_col) then
              return true
            end
          end
          return false
        end


        local id = vim.api.nvim_create_augroup(
          'MyLSPAutoGroup',
          { clear = true }
        )
        -- vim.api.nvim_create_autocmd(
        --   { 'CursorMoved', 'CursorMovedI' },
        --   {
        --     group = id,
        --     buffer = bufnr,
        --     callback = function()
        --       if(has_diagnostics()) then
        --         local opts = {
        --           focusable = false,
        --           close_events = {
        --             'BufLeave',
        --             'CursorMoved',
        --             'InsertEnter',
        --             'FocusLost',
        --           },
        --           border = 'rounded',
        --           source = 'always',
        --           prefix = '',
        --         }
        --         vim.diagnostic.open_float(nil, opts)
        --       -- else
        --       --   vim.diagnostic.hide()
        --       end
        --     end,
        --   }
        -- )

        -- disable lsp syntax highliting (use treesitter)
        -- client.server_capabilities.semanticTokensProvider = nil

      end
    }
    require('lspconfig')[server].setup(options)
  end
})

