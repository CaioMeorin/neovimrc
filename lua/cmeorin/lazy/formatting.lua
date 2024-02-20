return {

    "stevearc/conform.nvim",

    config = function()
        local conform = require("conform")
        conform.setup({
            ensure_installed = {
                "black",
                "isort",
                "prettierd",
                "prettier",
                "stylua",
            },
            automatic_installation = true,
            lsp_fallback = true,
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { { "isort", "black" } },
                mojo = { "black" },
                -- Use a sub-list to run only the first available formatter
                javascript = { { "prettierd", "prettier" } },
            },
            ["*"] = { "trim_whitespace" },
            format_after_save = { lsp_fallback = true, timeout = 500 },
            condition = function(ctx)
                return vim.fs.basename(ctx.filename) ~= "README.md"
            end,
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            }),
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = true, lsp_fallback = true, range = range })
            end, { range = true }),
        })
    end,
}
