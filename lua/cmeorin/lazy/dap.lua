return {

    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap",
            "LiadOz/nvim-dap-repl-highlights",
            "folke/neodev.nvim",
        },
        config = function()
            require "cmeorin.modules.dap_config"
            require "cmeorin.modules.dap_python"
            require "cmeorin.modules.dapui_config"
            require('telescope').load_extension('dap')
            require "cmeorin.modules.cmp_dap"
        end
    },

}
