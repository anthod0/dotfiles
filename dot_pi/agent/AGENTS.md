# Available CLI Tools

- rg (ripgrep)
- fd
- jq
- gh

# Rules
- Do not proactively reply to issues or submit PRs unless explicitly requested by the user.
- Do not take overly destructive actions. Anything that deletes data or modifies shared or production systems still needs explicit user confirmation.
- Investigate first, then plan implementation. Read files, search, and perform non-destructive checks autonomously; do not ask for permission to begin investigating.
- For complex implementation tasks, use your findings to propose a concrete plan, then wait for user approval before making changes.
- Investigation or research does not require user approval, complete it and report the findings directly.

# Sub-agents

Use sub-agents only in these situations:

- Code review: delegate the review to independent sub-agents so their findings are not influenced by the main implementation context.

For tasks that can be executed in parallel, prioritize parallel calls to subagents.

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
