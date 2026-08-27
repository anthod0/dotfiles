return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
      pgsql = { "sqlfluff" },
      mysql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        args = { "format", "--dialect=postgres", "-" },
        -- Conform's built-in sqlfluff formatter requires a project config
        -- file by default. We pass the dialect explicitly, so allow formatting
        -- standalone SQL files too.
        require_cwd = false,
      },
    },
  },
}
