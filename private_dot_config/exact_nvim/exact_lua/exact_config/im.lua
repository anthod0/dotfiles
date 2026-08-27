local im_switch = "toen"

local function set_english()
  vim.system({ im_switch }, { text = true }):wait()
end

local group = vim.api.nvim_create_augroup("IMSwitch", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
  group = group,
  pattern = "*",
  callback = set_english,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  pattern = "*",
  once = true,
  callback = set_english,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = group,
  pattern = "[/?:]",
  callback = set_english,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = group,
  pattern = "[/?:]",
  callback = set_english,
})
