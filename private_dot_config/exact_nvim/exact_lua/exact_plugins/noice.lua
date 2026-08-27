return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })

    opts.views = opts.views or {}
    opts.views.hover = {
      border = {
        -- 可选: "single", "double", "rounded", "solid", "shadow"
        style = "rounded",
        padding = { 0, 1 },
      },
      -- 稍微偏移一点，避免挡住光标
      position = { row = 2, col = 2 },
    }
  end,
}
