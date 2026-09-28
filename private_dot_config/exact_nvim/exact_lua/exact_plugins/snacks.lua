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
            explorer_paste = function(picker)
              local files = vim.split(vim.fn.getreg(vim.v.register or "+") or "", "\n", { plain = true })
              files = vim.tbl_filter(function(file)
                return file ~= "" and vim.uv.fs_stat(file) ~= nil
              end, files)

              if #files == 0 then
                return Snacks.notify.warn(
                  ("The `%s` register does not contain any files or directories"):format(vim.v.register or "+")
                )
              end

              local dir = picker:dir()
              Snacks.picker.util.copy(files, dir)

              local Tree = require("snacks.explorer.tree")
              Tree:refresh(dir)
              Tree:open(dir)
              picker:update({ target = dir })
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
