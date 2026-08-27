local palette = {
  fg0 = "#fbf1c7",
  dark = "#3c3836",
  bg3 = "#7c6f64",
  blue = "#458588",
  green = "#98971a",
  orange = "#d65d0e",
  red = "#cc241d",
  yellow = "#d79921",
}

local function colors(accent)
  return {
    a = { fg = palette.fg0, bg = accent, gui = "bold" },
    b = { fg = palette.fg0, bg = palette.blue },
    c = { fg = palette.dark, bg = "NONE" },
    x = { fg = palette.fg0, bg = "NONE" },
    y = { fg = palette.fg0, bg = palette.orange },
    z = { fg = palette.fg0, bg = palette.orange, gui = "bold" },
  }
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = {
        normal = colors(palette.orange),
        insert = colors(palette.green),
        visual = colors(palette.blue),
        replace = colors(palette.red),
        command = colors(palette.yellow),
        terminal = colors(palette.orange),
        inactive = {
          a = { fg = palette.fg0, bg = palette.bg3 },
          b = { fg = palette.fg0, bg = palette.bg3 },
          c = { fg = palette.fg0, bg = "NONE" },
        },
      }
      opts.options.component_separators = ""
      opts.options.section_separators = ""

      -- Match tmux's block-shaped outer edges while keeping the middle transparent.
      table.insert(opts.sections.lualine_a, 1, {
        function()
          return "▒▓"
        end,
        color = { fg = palette.orange, bg = "NONE" },
        padding = 0,
        separator = "",
      })
      opts.sections.lualine_z = {}
      table.insert(opts.sections.lualine_y, {
        function()
          return "▓▒"
        end,
        color = { fg = palette.orange, bg = "NONE" },
        padding = 0,
        separator = "",
      })
    end,
  },
}
