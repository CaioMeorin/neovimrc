require("cmeorin")

local function MyHighlights()
    vim.cmd("highlight ColorColumn guibg=#aa2f2f guifg=#d70000")
end

vim.api.nvim_create_augroup("MyColors", {})
vim.api.nvim_create_autocmd("ColorScheme", {
    group = "MyColors",
    callback = function()
        MyHighlights()
    end,
})

vim.cmd("TransparentEnable")
vim.cmd.colorscheme("tokyonight")
require("cmeorin.visualclose")
