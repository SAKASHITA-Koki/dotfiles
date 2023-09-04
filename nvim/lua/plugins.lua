local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({

  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins/colorscheme")
    end,
  },

  -- {
  --   "itchyny/lightline.vim",
  --   dependencies = {
  --     -- 'lambdalisue/nerdfont.vim',
  --   },
  --   config = function()
  --     require("plugins/lightline")
  --   end,
  -- },

  {
    'nvim-lualine/lualine.nvim',
    config = function ()
      require("plugins/lualine")
    end
  },

  {
    "tpope/vim-fugitive",
    lazy = true,
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "BufEnter",
    config = function ()
      require("gitsigns").setup({
        numhl = true,
      })
    end
  },

  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    event = 'BufEnter',
    config = function ()
      require('colorizer').setup()
    end
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "simeji/winresizer",
    lazy = true,
    keys = "<C-e>", -- set to the same value as g:winresizer_start_key
    init = function()
      vim.g.winresizer_start_key = "<C-e>"
    end,
  },

  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = true,
    keys = { "j", "k" },
    config = function()
      require("accelerated-jk").setup({
        mode = "time_driven",
        enable_deceleration = false,
        acceleration_motions = {},
        acceleration_limit = 150,
        -- acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
        acceleration_table = { 2, 10, 29 },
      })
      vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
      vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end
  },

  -- {
  --   "ggandor/leap.nvim",
  --   lazy = true,
  --   keys = { "<LEADER>j", "<LEADER>J" },
  --   config = function ()
  --     require("leap").setup({})
  --     -- vim.api.nvim_set_keymap('n', 's', '<NOP>', {})
  --     -- vim.api.nvim_set_keymap('n', 'S', '<NOP>', {})
  --     -- vim.api.nvim_set_keymap('n', '<LEADER>j', '<Plug>(leap-forward-to)', {})
  --     -- vim.api.nvim_set_keymap('n', '<LEADER>J', '<Plug>(leap-backward-to)', {})
  --     vim.keymap.set('n', '<LEADER>j', function ()
  --       local current_window = vim.fn.win_getid()
  --       require('leap').leap { target_windows = { current_window } }
  --     end)
  --     vim.keymap.set('n', '<LEADER>J', function ()
  --       local focusable_windows_on_tabpage = vim.tbl_filter(
  --         function (win) return vim.api.nvim_win_get_config(win).focusable end,
  --         vim.api.nvim_tabpage_list_wins(0)
  --       )
  --       require('leap').leap { target_windows = focusable_windows_on_tabpage }
  --     end)
  --   end
  -- },

  {
    "yuki-yano/fuzzy-motion.vim",
    lazy = true,
    keys = { "<LEADER>j" },
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function ()
      vim.api.nvim_set_keymap('n', '<LEADER>j', ':FuzzyMotion<CR>', {})
    end
  },

  {
    "kazhala/close-buffers.nvim",
    lazy = true,
    event = "BufEnter",
    config = function ()
      local p = require('close_buffers')
      p.setup({})
      local id = vim.api.nvim_create_augroup('CloseBuffers', { clear = true })
      vim.api.nvim_create_autocmd(
        { "VimLeave" },
        {
          group = id,
          desc = "remove hidden buffers when quit vim",
          callback = function ()
            p.delete({ type = 'hidden' })
          end
        }
      )
    end

  },

  {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("autoclose").setup()
    end,
  },


  {
    "terrortylor/nvim-comment",
    lazy = true,
    keys = {
      { "gc", mode = "n" },
      { "gc", mode = "v" },
      { "gc", mode = "x" },
      { "gb", mode = "n" },
      { "gb", mode = "v" },
      { "gb", mode = "x" },
    },
    config = function()
      require("nvim_comment").setup({})
    end,
  },

  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "BufEnter",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "junegunn/vim-easy-align",
    lazy = true,
    keys = { { "ga", mode = "x" } },
    config = function()
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)",
        { noremap = false, silent = true })
    end,
  },

  {
    'Wansmer/treesj',
    lazy = true,
    keys = { '[]', mode = 'n' },
    config = function ()
      local treesj = require('treesj')
      treesj.setup({
        use_default_keymaps = false
      })
      vim.keymap.set('n', '[]', treesj.toggle,
        { noremap = true, silent = true })
    end
  },

  {
    'gbprod/substitute.nvim',
    lazy = true,
    event = 'BufEnter',
    config = function ()
      require('substitute').setup({})
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "s", require('substitute').operator, opts)
      vim.keymap.set("n", "ss", require('substitute').line, opts)
      vim.keymap.set("n", "S", require('substitute').eol, opts)
      vim.keymap.set("x", "s", require('substitute').visual, opts)
    end
  },

  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   lazy = true,
  --   keys = '\\\\',
  --   config = function()
  --     vim.cmd('highlight! link IndentBlanklineChar Comment')
  --     vim.cmd(':IndentBlanklineDisable')
  --
  --     vim.api.nvim_set_keymap('n', '\\\\', ':IndentBlanklineToggle<CR>', {
  --       noremap = true, silent = true,
  --     })
  --   end,
  -- },

  {
    "Yggdroot/indentLine",
    lazy = true,
    keys = "\\\\",
    config = function()
      vim.g["indentLine_char_list"] = { "│", "┆" }
      vim.api.nvim_set_keymap(
        "n",
        "\\\\",
        ":IndentLinesToggle<CR>",
        { noremap = true, silent = true, nowait = true }
      )
    end,
  },

  -- {
  --   "unblevable/quick-scope",
  --   lazy = true,
  --   event = "BufEnter",
  --   config = function()
  --     vim.cmd([[
  --       highlight! QuickScopePrimary gui=bold,underline
  --     ]])
  --   end,
  -- },

  {
    "mvllow/modes.nvim",
    lazy = true,
    event = "BufEnter",
    config = function ()
      require("modes").setup({
        line_opacity = 0.2,
        colors = {
          insert = '#c6c8d1',
          visual = '#b4be82',
        }
      })
    end
  },

  {
    "kevinhwang91/nvim-hlslens",
    lazy = true,
    event = "BufEnter",
    config = function()
      require("hlslens").setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local lnum, col = unpack(posList[idx])
          local text = ("%d/%d"):format(idx, #posList)
          local chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
      })
      vim.api.nvim_set_hl(0, "HlSearchLens", {
        link = "Comment",
      })
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = true,
    event = "VimEnter",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = {
          "~/",
          "~/Downloads",
          "~/Desktop",
          "/",
        },
      })
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter/#supported-languages
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufEnter",
    dependencies = {
      { "yioneko/nvim-yati" },
    },
    config = function()
      vim.cmd(":silent TSUpdate")
      require("nvim-treesitter.configs").setup({
        ensure_installed = {},
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        yati = {
          enable = true,
          default_lazy = true,
          default_fallback = "auto",
        },
        indent = {
          enable = false,
        },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins/mason")
    end,
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "neovim/nvim-lspconfig" },
      { "ray-x/lsp_signature.nvim" },
      -- { 'kkharji/lspsaga.nvim'},
      -- 'hrsh7th/nvim-cmp',
      "j-hui/fidget.nvim",
      {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        lazy = true,
        config = function ()
          require('lsp_lines').setup()
        end
      },
    },
  },


  {
    "j-hui/fidget.nvim",
    lazy = true,
    config = function()
      require("fidget").setup({})
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },
    build = "make install_jsregexp",
    config = function()
      require("plugins/luasnip")
      vim.cmd([[
        " press <Tab> to expand or jump in a snippet. These can also be mapped separately
        " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

        " For changing choices in choiceNodes (not strictly necessary for a basic setup).
        imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
        smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      ]])
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "BufEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",

      -- snippets (maybe changes later)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins/cmp")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    keys = {
      "<LEADER>f",
      -- '<LEADER>t',
      "<LEADER>g",
      "<LEADER>b",
      "<LEADER>g",
      "<LEADER>r",
    },
    config = function()
      require("plugins/telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- { 'nvim-telescope/telescope-file-browser.nvim', },
    },
  },

  {
    "lambdalisue/nerdfont.vim",
    lazy = true,
  },

  {
    "lambdalisue/fern-renderer-nerdfont.vim",
    lazy = true,
    dependencies = {
      "lambdalisue/nerdfont.vim",
    },
    config = function()
      vim.g["fern#renderer"] = "nerdfont"
    end,
  },

  {
    "lambdalisue/fern.vim",
    lazy = true,
    keys = {
      "<LEADER>t",
      "<LEADER>s",
      "<LEADER>v",
      "<LEADER>d",
    },
    dependencies = {
      "lambdalisue/fern-renderer-nerdfont.vim",
    },
    config = function()
      require("plugins/fern")
    end,
  },

  -- ------------------------------
  -- Denops (ddc)
  -- ------------------------------

  -- {
  --   'Shougo/ddc.vim',
  --   lazy = true,
  --   config = function()

  --     local patch_global = function(key, value)
  --       vim.fn['ddc#custom#patch_global'](key, value)
  --     end
  --     vim.fn['pum#set_option']('padding', true)
  --     patch_global('ui', 'native')
  --     patch_global('sources', {
  --       'around',
  --       'nvim-lsp',
  --     })
  --     patch_global('sourceOptions', {
  --       _ = {
  --         matchers = { 'matcher_head', 'matcher_fuzzy', },
  --         sorters = { 'sorter_rank', 'sorter_fuzzy', },
  --         converters = { 'converter_remove_overlap', 'converter_fuzzy', },
  --       },
  --       around = {
  --         mark = 'around',
  --       },
  --       ['nvim-lsp'] = {
  --         mark = 'lsp'
  --       },
  --     })
  --     vim.cmd([[
  --       inoremap <silent><expr> <TAB>
  --             \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  --             \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  --             \ '<TAB>' : '<Cmd>call ddc#manual_complete()<CR>'
  --       inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  --       inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
  --       inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
  --       inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  --       inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  --     ]])
  --   end,
  --   dependencies = {
  --     -- { 'Shougo/ddc-ui-pum', },
  --     { 'Shougo/ddc-ui-native', },
  --     { 'Shougo/pum.vim', },
  --     { 'Shougo/ddc-around', },
  --     { 'Shougo/ddc-nvim-lsp', },
  --     { 'Shougo/ddc-matcher_head', },
  --     { 'tani/ddc-fuzzy' },
  --     { 'Shougo/ddc-sorter_rank', },
  --     { 'Shougo/ddc-converter_remove_overlap', },
  --     -- 'folke/noice.nvim',
  --   },
  -- },

  {
    'vim-denops/denops.vim',
    lazy = true,
    config = function()
      -- vim.fn['signature_help#enable']()
      -- vim.fn['ddc#enable']()
    end,
    dependencies = {
      -- 'matsui54/denops-signature_help',
      -- 'Shougo/ddc.vim',
      -- "yuki-yano/fuzzy-motion.vim",
    },
  },

  {
    "mattn/emmet-vim",
    lazy = true,
    ft = { "html", "css", "sass", "scss", "javascriptreact", "typescriptreact" },
    config = function()
      require("plugins/emmet")
    end,
  },

  {
    "habamax/vim-godot",
    lazy = true,
    ft = { "gdscript" },
    config = function()
      local id = vim.api.nvim_create_augroup("GDScriptGroup", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = id,
        pattern = { "gdscript" },
        callback = function()
          vim.api.nvim_set_option_value("expandtab", true, {
            scope = "local",
          })
        end,
      })
    end,
  },
})
