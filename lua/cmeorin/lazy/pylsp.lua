return { require 'lspconfig'.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391' },
                    maxLineLength = 88,

                },
                autopep8 = { enabled = false },
                pydocstyle = { enabled = true },
                black = { enabled = true, maxLineLength = 88 },
                isort = { enabled = true, profile = "black" },
                djlint = { enabled = true },
                mypy = { enabled = true, maxLineLength = 88 },
                jedi_completion = { fuzzy = true },
                mojo = { enabled = true, maxLineLength = 88 },
            }
        }
    }
}
}
