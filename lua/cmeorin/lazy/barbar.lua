return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	config = function()
		require("barbar").setup({
			auto_hide = false,
			focus_on_close = "left",
			highlight_alternate = false,
			highlight_visible = true,
			icons_diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
				[vim.diagnostic.severity.WARN] = { enabled = true },
				[vim.diagnostic.severity.INFO] = { enabled = true },
				[vim.diagnostic.severity.HINT] = { enabled = true },
			},
			gitsigns = {
				added = { enabled = true, icon = "+" },
				changed = { enabled = true, icon = "~" },
				deleted = { enabled = true, icon = "-" },
			},
			modified = { button = "●" },
			pinned = { button = "", filename = true },
			preset = "slanted",
		})
	end,
}
