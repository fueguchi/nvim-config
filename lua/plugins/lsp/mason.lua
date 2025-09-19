return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = function()
			local is_nixos = os.getenv("NIXOS_NEOVIM") ~= nil -- i just see an configuration with a similar soluction and i just ditched for my own use

			local servers = {
				"lua_ls",
				"nil_ls",
				"pyright",
				"html",
				"cssls",
				"emmet_ls",
				"clangd",
				"qmlls",
			}
			return {
				ensure_installed = is_nixos and {} or servers,
				automatic_installation = true,
			}
		end,
	},
}

