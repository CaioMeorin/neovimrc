return {require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100,

        },
        autopep8 = {enabled = false},
        black = {enabled = true},
        pylsp_mypy = { enabled = true },
        pyls_isort = { enabled = false },
        mypy = {enabled = true},
        jedi_completion = { fuzzy = true },
      }
    }
  }
}
}
