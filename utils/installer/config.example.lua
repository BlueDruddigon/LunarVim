--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

vim.cmd [[ let &fcs='eob: ' ]]
vim.cmd [[ set relativenumber ]]

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["sm"] = { "<cmd>:Telescope media_files<CR>", "Media Files" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<CR>", "Trouble References" },
  f = { "<cmd>Trouble lsp_definitions<CR>", "Trouble LSP Definitions" },
  d = { "<cmd>Trouble document_diagnostics<CR>", "Trouble Document Diagnostics" },
  q = { "<cmd>Trouble quickfix<CR>", "Trouble QuickFix" },
  l = { "<cmd>Trouble loclist<CR>", "Trouble LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<CR>", "Trouble Workspace Diagnostics" },
  t = { "<cmd>TroubleToggle<CR>", "TroubleToggle" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.open_on_setup = true
lvim.builtin.nvimtree.setup.view.width = 23
lvim.builtin.nvimtree.setup.actions.open_file.window_picker.enable = false
lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.enable = false

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "manage.py",
  "pyrightconfig.json",
  ".git",
  ".gitignore",
}

local opts = {
  root_dir = require("lspconfig.util").root_pattern(unpack(root_files)),
  single_file_support = true,
  filetypes = { "python" },
  cmd = { "pyright-langserver", "--stdio" },
  settings = {
    pyright = {
      disableOrganizeImports = false,
      disableLanguageServices = false,
    },
    python = {
      venvPath = "/home/beo/.env",
      pythonPath = "/home/beo/.env/bin/python3",
      analysis = {
        logLevel = "Information",
        stubPath = "/home/beo/Documents/typings",
        extraPaths = {},
        typeshedPaths = {},
        diagnosticMode = "workspace",
        autoSearchPaths = true,
        typeCheckingMode = "off",
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {},
      }
    },
  }
}

require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
lvim.lsp.on_attach_callback = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    name = "yapf",
    filetypes = { "python" },
    args = { "--style", "/home/beo/.config/yapf/style" }
  },
})

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }


-- Additional Plugins
lvim.plugins = {
  {
    "github/copilot.vim",
    config = function()
      -- maps for github copilot
      vim.api.nvim_set_keymap("n", "<A-[>", "copilot#Accept('<CR>')", { noremap = true, expr = true, silent = true })
      vim.api.nvim_set_keymap("i", "<A-[>", "copilot#Accept('<CR>')", { noremap = true, expr = true, silent = true })
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_filetypes = {
        ['*'] = false,
        ['python'] = true,
      }
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufWinEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
        },
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
        }
      })
    end
  },
  -- {
  --   "tzachar/cmp-tabnine",
  --   run = "./install.sh",
  --   requres = "hrsh7th/nvim-cmp",
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        char = "▏",
        space_char_blankline = " ",
        indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" },
        indent_blankline_buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
      })
    end
  },
  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    event = "BufWinEnter",
    config = function()
      require("telescope").load_extension("media_files")
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        auto_close = true,
        auto_open = false,
        auto_preview = false,
        use_diagnostic_signs = true,
        mode = "document_diagnostics",
        action_keys = {
          jump_close = { "<CR>", "o", "<TAB>" },
          jump = {},
        },
      })
    end,
  },
  {
    "ekickx/clipboard-image.nvim",
    config = function()
      require("clipboard-image").setup({})
    end
  },
  {
    "ellisonleao/glow.nvim",
    config = function()
      vim.g.glow_border = "rounded"
      vim.g.glow_use_pager = true
    end
  },
}

-- key mappings for commenters
local expr = { noremap = true, silent = true, expr = true }
local map_opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", ",,", [[v:count == 0 ? '<CMD>lua require("Comment.api").call("toggle_current_linewise_op")<CR>g@$' : '<CMD>lua require("Comment.api").locked.toggle_linewise_count()<CR>']], expr)
vim.api.nvim_set_keymap("x", ",,", '<ESC><CMD>lua require("Comment.api").locked.toggle_linewise_op(vim.fn.visualmode())<CR>', map_opt)
vim.api.nvim_set_keymap("n", "ge", "<cmd>TroubleToggle<CR>", map_opt)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", map_opt)
vim.api.nvim_set_keymap("i", "<C-k>", "<C-w>k", map_opt)
vim.api.nvim_set_keymap("x", "<C-k>", "<C-w>k", map_opt)

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
