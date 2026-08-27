local is_ssh = vim.env.SSH_CONNECTION and vim.env.SSH_CONNECTION ~= ""

-- 本地环境：保留 yanky 的 yank 历史，但让 p/P 从系统剪贴板粘贴。
-- SSH 环境：Windows Terminal 不支持 OSC52 读取剪贴板，保留 yanky 默认 p/P，避免读取超时。
if is_ssh then
  return {}
end

return {
  {
    "gbprod/yanky.nvim",
    keys = {
      { "p", '"+p', mode = { "n", "x" }, desc = "Paste from system clipboard" },
      { "P", '"+P', mode = { "n", "x" }, desc = "Paste before from system clipboard" },
    },
  },
}
