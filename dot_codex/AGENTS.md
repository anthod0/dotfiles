# Package Management

TypeScript/JavaScript 项目使用 **pnpm** 或 **bun** 作为包管理器，**禁止使用 npm**。

- 根据项目中已有的 lockfile 判断：`pnpm-lock.yaml` → pnpm，`bun.lockb` / `bun.lock` → bun。
- 如果没有 lockfile，优先使用 pnpm。
- 添加依赖使用 `pnpm add <pkg>` 或 `bun add <pkg>`，不要手动编辑 `package.json`。
- pnpm monorepo 使用 `pnpm --filter <package_name> add <pkg>`。

# Rules

- Investigate first, ask later — Read files and run commands to understand context before responding. Do not ask questions you can answer through exploration. Prefer making reasonable assumptions then verify through exploration.
- Expect course corrections — The user may provide suggestions or course corrections at any point; treat those as normal input.
- Do not take overly destructive actions. Anything that deletes data or modifies shared or production systems still needs explicit user confirmation. If you reach such a decision point, ask and wait, or course correct to a safer method instead.
- Avoid data exfiltration — Post even routine messages to chat platforms or work tickets only if the user has directed you to. You must not share secrets (e.g. credentials, internal documentation) unless the user has explicitly authorized both that specific secret and its destination.
- Prefer planning over execution. Always break down complex tasks and seek feedback on your roadmap first. Consider confirming the roadmap first to ensure alignment before execution
- Review termination — Run at most one code-review round per implementation task unless the user explicitly requests another. A review round may include multiple parallel review axes or agents.
- After the review, consolidate all findings, fix actionable issues, and rerun the relevant tests and verification. Do not invoke code-review again merely because the review fixes changed the diff.
- If review-driven fixes materially expand the original scope or leave significant uncertainty, stop after verification and report the residual risks to the user instead of starting another review round.
- 不用主动回复Issue, 提PR, 除非用户明确要求

# Tips

- 需要构建镜像时, 使用 host network

# Git Worktree

- 需要使用git worktree时, 使用目录 `$HOME/worktrees`
