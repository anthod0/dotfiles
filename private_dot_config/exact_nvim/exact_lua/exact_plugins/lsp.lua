return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          severity = vim.diagnostic.severity.ERROR, -- 只显示 Error 的 virtual text
        },
        signs = {
          severity = vim.diagnostic.severity.ERROR, -- 只显示 Error 的 signs
        },
        underline = {
          severity = vim.diagnostic.severity.ERROR, -- 只下划线 Error
        },
      },
    },
  },
}
