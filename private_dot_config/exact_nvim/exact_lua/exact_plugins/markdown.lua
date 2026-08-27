return {
  { "iamcco/markdown-preview.nvim", enabled = false },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        enabled = false,
        anti_conceal = { enabled = false },
        render_modes = { "n", "c" },
        max_file_size = 1.5,
        debounce = 100,
        heading = {
          enabled = true,
          sign = true,
          width = "full",
          icons = {},
          foregrounds = {
            "GruvboxOrangeBold",
            "GruvboxYellowBold",
            "GruvboxBlueBold",
            "GruvboxAquaBold",
            "GruvboxAquaBold",
            "GruvboxAquaBold",
          },
          backgrounds = {
            "GruvboxOrangeBold",
            "GruvboxYellowBold",
            "GruvboxBlueBold",
            "GruvboxAquaBold",
            "GruvboxAquaBold",
            "GruvboxAquaBold",
          },
        },
        code = {
          enabled = true,
          sign = true,
          style = "full",
          width = "block",
          left_pad = 2,
          right_pad = 2,
          border = "hide",
          language_left = "| ",
          highlight = "RenderMarkdownCode",
        },
        bullet = {
          enabled = true,
          icons = { "●", "○", "◆", "◇" },
          highlight = "RenderMarkdownBullet",
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set(
            "n",
            "<leader>cp",
            "<cmd>RenderMarkdown toggle<CR>",
            { buffer = true, desc = "Markdown: Toggle render" }
          )
        end,
      })
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "NONE" })
    end,
  },
}
