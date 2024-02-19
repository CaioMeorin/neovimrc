return {

    "elentok/format-on-save.nvim",
    config = function()
        local format_on_save = require("format-on-save")
        local formatters = require("format-on-save.formatters")
        format_on_save.setup({

            experiments = {
                partial_update = 'diff', -- or 'line-by-line'
            },
            formatter_by_ft = {
                css = formatters.lsp,
                html = formatters.lsp,
                java = formatters.lsp,
                javascript = formatters.lsp,
                json = formatters.lsp,
                lua = formatters.lsp,
                markdown = formatters.prettierd,
                openscad = formatters.lsp,
                python = {
                    formatters.lsp,
                    formatters.remove_trailing_whitespace,
                    formatters.remove_trailing_newlines,
                },
                mojo = {
                    formatters.black,
                },
                rust = formatters.lsp,
                scad = formatters.lsp,
                scss = formatters.lsp,
                sh = formatters.shfmt,
                terraform = formatters.lsp,
                typescript = formatters.prettierd,
                typescriptreact = formatters.prettierd,
                yaml = formatters.lsp,

                -- Add your own shell formatters:
                -- myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }),
                -- Add lazy formatter that will only run when formatting:
                my_custom_formatter = function()
                    if vim.api.nvim_buf_get_name(0):match("/README.md$") then
                        return formatters.prettierd
                    else
                        return formatters.lsp()
                    end
                end,
            },

            fallback_formatter = {
                formatters.remove_trailing_whitespace,
                formatters.remove_trailing_newlines,
                formatters.lsp,
            },

        })
    end,
}
