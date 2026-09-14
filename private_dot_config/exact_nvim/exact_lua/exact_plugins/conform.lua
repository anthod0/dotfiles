local oxfmt_filetypes = {
  "astro",
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "json5",
  "jsonc",
  "less",
  "scss",
  "svelte",
  "toml",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxfmt" } },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      for _, filetype in ipairs(oxfmt_filetypes) do
        opts.formatters_by_ft[filetype] = { "oxfmt" }
      end

      -- Keep Markdown lint fixes and TOC generation after formatting.
      opts.formatters_by_ft.markdown = { "oxfmt", "markdownlint-cli2", "markdown-toc" }
      opts.formatters_by_ft["markdown.mdx"] = { "oxfmt", "markdownlint-cli2", "markdown-toc" }

      opts.formatters_by_ft.sql = { "sqlfluff" }
      opts.formatters_by_ft.pgsql = { "sqlfluff" }
      opts.formatters_by_ft.mysql = { "sqlfluff" }

      opts.formatters = opts.formatters or {}
      opts.formatters.sqlfluff = {
        args = { "format", "--dialect=postgres", "-" },
        -- Conform's built-in sqlfluff formatter requires a project config
        -- file by default. We pass the dialect explicitly, so allow formatting
        -- standalone SQL files too.
        require_cwd = false,
      }
    end,
  },
}
