return {
    "williamboman/mason.nvim",
    "rshkarin/mason-nvim-lint",
    "mfussenegger/nvim-lint",
    dependencies = {
        "williamboman/mason.nvim",
        "rshkarin/mason-nvim-lint",
    },
    config = function()
        require("mason-nvim-lint").setup({
            ensure_installed = {
                "ktlint",
                "mypy",
                "djlint",
                "eslint",
                "pylint"
            },
            automatic_installation = true,
        })
        local lint = require("lint")
        lint.setup({
            linters_by_ft = {
                mojo = { "mojo" },
                python = { { "mypy", "pylint" } },
                kotlin = { "ktlint" },
                js = { { "eslint", "babel-eslint" } },
                json = { "jsonlint" },
                html = { "tailwindcss" },
            },
            vim.api.nvim_create_autocmd({ "ModeChanged", "BufRead", "BufWrite" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            }),
        })
    end,
}
