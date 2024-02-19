return {
    {
        "czheo/mojo.vim",
        ft = { "mojo" },
        init = function()
            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = { "*.🔥" },
                callback = function()
                    if vim.bo.filetype ~= "mojo" then
                        vim.bo.filetype = "mojo"
                    end
                end,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "mojo",
                callback = function()
                    vim.bo.expandtab = true
                    vim.bo.shiftwidth = 4
                    vim.bo.softtabstop = 4
                end,

            })
        end,

        config = function()
            local mojolsp = require('lspconfig').mojo
            mojolsp.setup({
                filetype = { "mojo" },

            })
        end,
    },
}
