local function autoCloseVisual(key, key2)
  if key2 == nil then
    return 'c' .. key .. '<C-r>"' .. key .. '<Esc>'
  else
    return 'c' .. key .. '<C-r>"' .. key2 .. '<Esc>'
  end
end
local opts = { silent = true, desc = 'Enclose the selected test' }
vim.keymap.set({ 'v' }, '<leader>c"', autoCloseVisual '"', opts)
vim.keymap.set({ 'v' }, "<leader>c'", autoCloseVisual "'", opts)
vim.keymap.set({ 'v' }, '<leader>c`', autoCloseVisual '`', opts)
vim.keymap.set({ 'v' }, '<leader>c(', autoCloseVisual('(', ')'), opts)
vim.keymap.set({ 'v' }, '<leader>c{', autoCloseVisual('{', '}'), opts)
vim.keymap.set({ 'v' }, '<leader>c[', autoCloseVisual('[', ']'), opts)
vim.keymap.set({ 'v' }, '<leader>c<', autoCloseVisual('<', '>'), opts)
