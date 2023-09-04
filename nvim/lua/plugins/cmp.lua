local cmp = require("cmp")
local luasnip = require('luasnip')


local should_complete = function()
  local position = vim.fn.getcharpos('.')
  local row = position[2]
  local col = position[3]
  if col == 0 or col == 1 then
    return false
  else
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
    local cursor_char = line:sub(col-1, col-1)
    local is_white_space = cursor_char:match('%s') ~= nil
    return not is_white_space
  end
end


cmp.setup({
  completion = {
    keyword_length = 1,
  },
  matching = {
    disallow_partial_fuzzy_matching = false,
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<ESC>"] = cmp.mapping.abort(),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if should_complete() then
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          cmp.complete()
        end
      else
        fallback()
      end
    end),
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif should_complete() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.expand_or_jumpable(-1) then
        luasnip.expand_or_jump(-1)
      else
        fallback()
      end
    end)
  }, { 'i', 's' }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "calc" },
  }, {
    { name = "buffer" },
  }),
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     -- You can specify the `cmp_git` source if you were installed it.
--     { name = 'cmp_git' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
