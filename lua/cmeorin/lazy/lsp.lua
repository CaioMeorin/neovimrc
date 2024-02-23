return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("cmeorin.modules.neodev")
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
                "tailwindcss",
                "volar",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ['pylsp'] = function()
                    local lineWidth = 90

                    require 'lspconfig'.pylsp.setup {
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = {
                                        enabled = true,
                                        maxLineLength = lineWidth,
                                        hangClosing = true,
                                        indentSize = 4,
                                    },
                                    rope_autoimport = { enabled = true },
                                    autopep8 = { enabled = true, maxLineLength = lineWidth },
                                    flake8 = { enabled = true, maxLineLength = lineWidth },
                                    pylint = { enabled = false, maxLineLength = lineWidth },
                                    mccabe = { enabled = true },
                                    pydocstyle = { enabled = false },
                                    isort = { enabled = true, profile = "autopep8" },
                                    mypy = { enabled = true, maxLineLength = lineWidth },
                                    jedi_completion = { fuzzy = true },
                                    pyflakes = { enabled = false },
                                }
                            }
                        }
                    }
                end,
                ["html"] = function()
                    capabilities.textDocument.completion.completionItem.snippetSupport = true

                    require("lspconfig").html.setup({
                        capabilities = capabilities,
                    })
                end,
                ["tailwindcss"] = function()
                    require("lspconfig").tailwindcss.setup({
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
