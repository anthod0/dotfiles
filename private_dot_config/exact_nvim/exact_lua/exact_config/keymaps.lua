-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>e", function()
  local explorer = Snacks.picker.get({ source = "explorer" })[1]
  if explorer then
    Snacks.explorer.reveal()
    explorer:focus()
  else
    Snacks.explorer()
  end
end, {
  desc = "Explorer Reveal",
})

map("n", "<leader>E", function()
  Snacks.explorer()
end, {
  desc = "Explorer Toggle",
})

map("n", "q", "<Nop>", { noremap = true, silent = true })
map("n", "qq", "q", { noremap = true, silent = true })
