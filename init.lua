require("config.lazy")
setup_lazy({
  { "itchyny/lightline.vim" },
  { "neovim/nvim-lspconfig" },
  { "nvim-telescope/telescope.nvim" },
  { 
      "nvim-treesitter/nvim-treesitter",
      opts = { highlight = { enable = true } },
  },
  { 
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  { "lewis6991/gitsigns.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "echasnovski/mini.nvim", version = "*" },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
})

require("mini.ai").setup({})
require("mini.operators").setup({})
require("mini.surround").setup({})
require("mini.completion").setup({})

vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("clangd")

require("telescope").load_extension("fzf")
require("ibl").setup()

vim.g.python3_host_prog = ".venv/bin/python3"

-- vim.cmd("colorscheme vim")
-- vim.opt.termguicolors = false

-- Key mappings for moving lines/blocks
vim.keymap.set("n", "<C-Up>", ":m -2<CR>")
vim.keymap.set("n", "<C-K>", ":m -2<CR>")
vim.keymap.set("n", "<C-Down>", ":m +1<CR>")
vim.keymap.set("n", "<C-J>", ":m +1<CR>")

vim.keymap.set("x", "<C-Up>", ":m -2<CR>gv=gv")
vim.keymap.set("x", "<C-K>", ":m -2<CR>gv=gv")
vim.keymap.set("x", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<C-J>", ":m '>+1<CR>gv=gv")

-- Ctrl+Backspace and Ctrl+Del in insert and command mode
vim.keymap.set("i", "<C-H>", "<C-W>")
vim.keymap.set("i", "<C-Del>", "<C-O>cw")
vim.keymap.set("c", "<C-Del>", "<C-F>cw<C-C>")

-- Faster save with Ctrl+S
vim.keymap.set("n", "<C-S>", ":w<CR>")
vim.keymap.set("i", "<C-S>", "<C-O>:w<CR>")
vim.keymap.set("v", "<C-S>", "<C-C>:w<CR>gv")

-- Editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("syntax enable")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.formatoptions:append("r")
vim.opt.wrap = false
vim.opt.hlsearch = false

vim.opt.laststatus = 2
vim.opt.showmode = false

-- Lightline config
-- Lightline config
vim.g.lightline = {
  colorscheme = 'wombat',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    }
  },
  component_function = {
    gitbranch = 'fugitive#head'
  }
}

-- Git commit formatting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "+1"
  end
})

