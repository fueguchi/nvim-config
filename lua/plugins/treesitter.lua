return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
    	highlight = {
    		enable = true,
    	},
    
    	indent = {
    		enable = true,
    	},
    
    	autotag = {
    		enable = true,
    	},
    
    	ensure_installed = {
    		"lua",
    		"json",
    		"css",
    		"bash",
    		"regex",
    		"c",
    		"markdown",
    		"markdown_inline",
    		"yaml",
    		"html",
    		"cpp",
    		"c_sharp",
    		"java",
    		"nix",
    		"python",
    		"scss",
    		"javascript",
    		"latex",
    		"norg",
    		"typst",
    		"svelte",
    		"tsx",
    		"vue",
    	},
    })
  end,
}
