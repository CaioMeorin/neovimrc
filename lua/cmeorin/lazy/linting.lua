return {
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
            },
            automatic_installation = true,
        })
        local lint = require("lint")
        lint.setup({
            linters_by_ft = {
                mojo = { "mojo", },
                python = { "mypy", },
                kotlin = { "ktlint", },
                html = { "djlint", },
            },
            vim.api.nvim_create_autocmd({ "ModeChanged", "BufRead", "BufWrite" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        })
    end
}
