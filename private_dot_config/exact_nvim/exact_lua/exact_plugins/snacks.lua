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
          { icon = " ", key = "i", desc = "Issues", action = ":lua Snacks.picker.gh_issue()" },
          { icon = " ", key = "p", desc = "Pull Requests", action = ":lua Snacks.picker.gh_pr()" },
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
        {
          icon = " ",
          title = "Open Issues",
          section = "terminal",
          cmd = "gh issue list --limit 5",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          height = 7,
          ttl = 300,
          padding = { 1, 1 },
          indent = 1,
        },
        {
          icon = " ",
          title = "Open PRs",
          section = "terminal",
          cmd = "gh pr list --limit 5",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          height = 7,
          ttl = 300,
          padding = { 1, 1 },
          indent = 1,
        },
      },
    },
  },
}
