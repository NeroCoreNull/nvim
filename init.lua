vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set guicursor=i-v:block")
vim.cmd("syntax=on")
vim.cmd("set number")
vim.g.mapleader = " "
vim.cmd("nnoremap j k")
vim.cmd("nnoremap k j")
vim.cmd("set whichwrap+=h,l")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require 'nordic' .load()
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim"
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    },
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        "m4xshen/autoclose.nvim"
    },
    {
        "williamboman/mason.nvim"
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
    {
        "neovim/nvim-lspconfig"
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp"
    },
    {
        'arnamak/stay-centered.nvim'
    }
}
local opts = {}

-- Lazy init
require("lazy").setup(plugins, opts)

-- Telescope init
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {

            }
        }
    }
})
require("telescope").load_extension("ui-select")

-- Neotree config
require("neo-tree").setup({
    popup_border_style = "rounded",
    enable_git_status = true,
    icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon"
    },
    name = {
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
    },
    git_status = {
        symbols = {
            added     = "",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
        }
    },
    window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = false,
          },
          mappings = {
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          }
        },
})
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

-- nvim treesitter
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua", "python", "rust", "odin"},
    highlight = { enable = true },
    indent = { enable = true },
})

-- LSP library <--
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.jedi_language_server.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.ols.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.taplo.setup({ capabilities = capabilities })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "jedi_language_server", "tsserver", "ols", "rust_analyzer", "taplo" }
})

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

-- Theme and autoclose brackets
require("autoclose").setup()
require("nordic").setup()
require('stay-centered').setup()
