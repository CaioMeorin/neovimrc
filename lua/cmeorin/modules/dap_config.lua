local dap = require "dap"


dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        cb({
            type = 'executable',
            command = 'path/to/virtualenvs/debugpy/bin/python',
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end

vim.api.nvim_create_user_command("RunScriptWithArgs", function(t)
    -- :help nvim_create_user_command
    local args = vim.split(vim.fn.expand(t.args), '\n')
    local approval = vim.fn.confirm(
        "Will try to run:\n    " ..
        vim.bo.filetype .. " " ..
        vim.fn.expand('%') .. " " ..
        t.args .. "\n\n" ..
        "Do you approve? ",
        "&Yes\n&No", 1
    )
    if approval == 1 then
        dap.run({
            type = vim.bo.filetype,
            request = 'launch',
            name = 'Launch file with custom arguments (adhoc)',
            program = '${file}',
            args = args,
        })
    end
end, {
    complete = 'file',
    nargs = '*'
})
vim.keymap.set('n', '<leader>R', ":RunScriptWithArgs ")

local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
        'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
            keymap.buffer,
            keymap.mode,
            keymap.lhs,
            keymap.rhs,
            { silent = keymap.silent == 1 }
        )
    end
    keymap_restore = {}
end
