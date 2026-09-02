# Available CLI Tools

- rg (ripgrep)
- fd
- jq

# Rules
- Do not proactively reply to issues or submit PRs unless explicitly requested by the user.
- Do not take overly destructive actions. Anything that deletes data or modifies shared or production systems still needs explicit user confirmation.
- Prefer planning over execution. Always break down complex tasks and seek feedback on your roadmap first. Consider confirming the roadmap first to ensure alignment before execution.

# Coding style
- Grow the system in layers. Start from the smallest version that works end to end, and add each new capability on top of a product that already works.
- Choose the simplest implementation that fully meets the current requirements. Avoid speculative abstractions, configuration, and indirection.
- Make architectural decisions for the long term. Do not accept a stopgap that only works for now and is meant to be replaced later.
- Keep components modular and concerns clearly separated.
- Do not preserve backward compatibility unless the task or an existing public contract requires it. Remove obsolete paths instead of adding compatibility layers, fallbacks, or migrations.

# TypeScript/JavaScript projects
- Determine the package manager based on the existing lockfile, if no lockfile exists, use `bun` by default.
- Do not manually edit `package.json`. Add dependencies using `pnpm add <pkg>` or `bun add <pkg>` or `npm install <pkg>`.
- For pnpm monorepos, use `pnpm --filter <package_name> add <pkg>`.
- For bun monorepos, use `bun add <pkg> --filter <package_name>`.

# Environment
- When using `git worktree`, use the directory `$HOME/worktrees`.
- Use the host network when building docker images.
