return {
    {
        "williamboman/mason.nvim",
        config = function()
            -- LSP library <--
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            -- mason --
            require("mason").setup({
                lspconfig.lua_ls.setup({ capabilities = capabilities }),
                lspconfig.jedi_language_server.setup({ capabilities = capabilities }),
                lspconfig.tsserver.setup({ capabilities = capabilities }),
                lspconfig.ols.setup({ capabilities = capabilities }),
                lspconfig.rust_analyzer.setup({ capabilities = capabilities }),
                lspconfig.taplo.setup({ capabilities = capabilities }),
                vim.keymap.set("n", "K", vim.lsp.buf.hover, {}),
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}),
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}),
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jedi_language_server",
                    "tsserver",
                    "ols",
                    "rust_analyzer",
                    "taplo",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
