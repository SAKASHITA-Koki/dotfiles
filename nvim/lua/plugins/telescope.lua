local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

-- require('telescope').load_extension('file_browser')

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules" },
    mappings = {
      n = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-q>"] = actions.close,
        ["<c-v>"] = actions.select_vertical,
        ["<c-s>"] = actions.select_horizontal,
      },
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-q>"] = actions.close,
        ["jj"] = actions.close,
        ["<c-v>"] = actions.select_vertical,
        ["<c-s>"] = actions.select_horizontal,
      },
    },
  },
})
local options = { noremap = true, silent = true }
vim.keymap.set("n", "<LEADER>f", builtin.find_files, options)
vim.keymap.set("n", "<LEADER>g", builtin.live_grep, options)
vim.keymap.set("n", "<LEADER>b", builtin.buffers, options)
vim.keymap.set("n", "<LEADER>h", builtin.help_tags, options)
vim.keymap.set("n", "<LEADER>r", builtin.registers, options)
-- vim.api.nvim_set_keymap(
--   'n', '<LEADER>t', ':Telescope file_browser initial_mode=normal<CR>',
--   { noremap = true, silent = true }
-- )
