local header = [[
 ██╗   ██╗ ███████╗  ██████╗  ██████╗  ██████╗  ███████╗
 ██║   ██║ ██╔════╝ ██╔════╝ ██╔═══██╗ ██╔══██╗ ██╔════╝
 ██║   ██║ ███████╗ ██║      ██║   ██║ ██║  ██║ █████╗  
 ╚██╗ ██╔╝ ╚════██║ ██║      ██║   ██║ ██║  ██║ ██╔══╝  
  ╚████╔╝  ███████║ ╚██████╗ ╚██████╔╝ ██████╔╝ ███████╗
   ╚═══╝   ╚══════╝  ╚═════╝  ╚═════╝  ╚═════╝  ╚══════╝

]]
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- picker
    picker = {
      sources = {
        explorer = {
          diagnostics = false,
          hidden = true,
          ignored = true,
          exclude = {
            ".git",
            "node_modules",
          },
          actions = {
            confirm_and_clear = function(picker)
              picker:action("confirm")
              if picker.list then
                picker.list:set_selected()
                picker.list:update()
              end
            end,
          },
          win = {
            list = {
              keys = {
                ["o"] = "confirm_and_clear",
                ["<CR>"] = "confirm_and_clear",
              },
            },
          },
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = {
            ".git",
            "node_modules",
          },
        },
        grep = {
          hidden = true,
          ignored = true,
          exclude = {
            ".git",
            "node_modules",
          },
        },
      },
    },

    --dashboard
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = header,
      },
      width = 80,
      sections = {
        {
          section = "header",
        },
        { section = "keys", gap = 1, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", padding = { 1, 1 }, indent = 1 },
        { icon = " ", title = "Projects", section = "projects", padding = { 1, 1 }, indent = 1 },
      },
    },
  },
}
