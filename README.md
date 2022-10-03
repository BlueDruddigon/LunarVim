![lunarvim_logo_dark](https://user-images.githubusercontent.com/59826753/159940098-54284f26-f1da-4481-8b03-1deb34c57533.png)

## Showcase
![intro1](https://user-images.githubusercontent.com/29136904/191624232-a7b13f11-cc9f-495e-879e-67ea0444c568.png)
![info](https://user-images.githubusercontent.com/29136904/191624942-3d75ef87-35cf-434d-850e-3e7cd5ce2ad0.png)

![demo1](https://user-images.githubusercontent.com/29136904/191625579-ce9efb1f-1e23-4a05-aebc-915a0f614d72.png)
![demo2](https://user-images.githubusercontent.com/29136904/191626018-2e9ee682-043c-4ce5-a5dd-c11b94759782.png)
![demo3](https://user-images.githubusercontent.com/29136904/191626246-ce0cc0c5-4b41-49e3-9cb7-4b1867ab0dcb.png)

## Install In One Command!

Make sure you have the release version of Neovim (0.7+).

### Linux/MacOS:

If you are running Neovim 0.7+

```bash
bash <(curl -s https://raw.githubusercontent.com/BlueDruddigon/LunarVim/rolling/utils/installer/install.sh)
```

If you are running Neovim 0.8+

```bash
export LV_BRANCH="rolling"; bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

To run the install script without any interaction you can pass the `-y` flag to automatically install all dependencies and have no prompts. This is particularly useful in automated installations.

In the same way, you can use `--no-install-dependencies` to skip the dependency installation.

### Windows (Powershell 7+):

Powershell v7+ is required for this script. For instructions on how to install, [click here.](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2)

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/BlueDruddigon/LunarVim/rolling/utils/installer/install.ps1 -UseBasicParsing | Invoke-Expression
```

## Automatic LSP support

By default, most supported language servers will get automatically installed once you open the supported file type, e.g, opening a Python file for the first time will install `Pyright` and configure it automatically for you.

## Configuration file

To install plugins configure LunarVim use the `config.lua` located here: `~/.config/lvim/config.lua`

Example:

```lua
-- general
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"

lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- set keymap with custom opts
-- lvim.keys.insert_mode["po"] = {'<ESC>', { noremap = true }}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Configure builtin plugins
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- Treesitter parsers change this to a table of the languages you want i.e. {"java", "python", javascript}
lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "haskell" }

-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false

-- Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black" },
  {
    command = "prettier",
    ---@usage specify which filetypes to enable. By default, providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default, providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact" },
  },
}

-- Additional Plugins
lvim.plugins = {
    {"lunarvim/colorschemes"},
    {
        "ray-x/lsp_signature.nvim",
        config = function() require"lsp_signature".on_attach() end,
        event = "BufRead"
    }
}
```

## Updating LunarVim

- inside LunarVim `:LvimUpdate`
- from the command-line `lvim +LvimUpdate +q`

### Update the plugins

- inside LunarVim `:PackerUpdate`

## Resources

- [Documentation](https://www.lunarvim.org)

- [YouTube](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)

- [Discord](https://discord.gg/Xb9B4Ny)

- [Twitter](https://twitter.com/chrisatmachine)

- [LunarVim](https://github.com/LunarVim/LunarVim)

</div>
