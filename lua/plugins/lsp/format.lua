return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.alejandra,
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          nix = { "alejandra" },
          c = { "clang-format" },
          cpp = { "clang-format" },
        },
      }),
    },
  },
}
