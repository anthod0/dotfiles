-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- require("config.im")

-- 关闭保存时自动格式化
vim.g.autoformat = false

vim.opt.swapfile = false
vim.opt.undofile = true

-- 所有 markdown 文件强制不 conceal
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.conceallevel = 0
  end,
})

-- 禁用q:
vim.keymap.set("n", "q:", "<Nop>", { noremap = true, silent = true })

--wrap
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

-- 剪贴板配置包含平台相关判断，单独放在模板文件里，避免 options.lua 变成模板导致 chezmoi re-add 失效
require("config.clipboard")
