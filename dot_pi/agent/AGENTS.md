# Available CLI Tools

- rg (ripgrep)
- fd
- jq

# Package Management

TypeScript/JavaScript 项目使用 **pnpm** 或 **bun** 作为包管理器，**禁止使用 npm**。

- 根据项目中已有的 lockfile 判断：`pnpm-lock.yaml` → pnpm，`bun.lockb` / `bun.lock` → bun。
- 如果没有 lockfile，优先使用 pnpm。
- 添加依赖使用 `pnpm add <pkg>` 或 `bun add <pkg>`，不要手动编辑 `package.json`。
- pnpm monorepo 使用 `pnpm --filter <package_name> add <pkg>`。

# Rules

- Review termination — Run at most one code-review round per implementation task unless the user explicitly requests another. A review round may include multiple parallel review axes or agents.
- After the review, consolidate all findings, fix actionable issues, and rerun the relevant tests and verification. Do not invoke code-review again merely because the review fixes changed the diff.
- If review-driven fixes materially expand the original scope or leave significant uncertainty, stop after verification and report the residual risks to the user instead of starting another review round.
- 不要主动回复Issue, 提交 PR, 除非用户明确要求

# Tips

- 需要构建镜像时, 使用 host network

# Git Worktree

- 需要使用git worktree时, 使用目录 `$HOME/worktrees`
