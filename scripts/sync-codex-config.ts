import { mkdir, open, readFile, rename, stat, unlink } from "node:fs/promises";
import { homedir } from "node:os";
import { dirname, join } from "node:path";

const rootSettings = {
  sandbox_mode: "danger-full-access",
  approval_policy: "never",
};
const tuiSettings = {
  animations: false,
  terminal_title: [],
  status_line: [
    "model-with-reasoning",
    "current-dir",
    "git-branch",
    "context-used",
    "weekly-limit",
  ],
};

export function sync(source: string): string {
  const config = Bun.TOML.parse(source) as Record<string, unknown>;
  const tui = (config.tui ??= {});
  if (typeof tui !== "object" || Array.isArray(tui)) {
    throw new Error("Expected a [tui] table in Codex config");
  }
  const features = (config.features ??= {});
  if (typeof features !== "object" || Array.isArray(features)) {
    throw new Error("Expected a [features] table in Codex config");
  }
  Object.assign(config, rootSettings);
  Object.assign(tui, tuiSettings);
  Object.assign(features, { worktrees: false });
  const updated = Bun.TOML.stringify(config);
  if (updated === undefined)
    throw new Error("Could not serialize Codex config");
  return updated;
}

async function main() {
  const path = join(
    process.env.CODEX_HOME || join(homedir(), ".codex"),
    "config.toml",
  );
  let source = "";
  let mode = 0o600;
  try {
    source = await readFile(path, "utf8");
    mode = (await stat(path)).mode & 0o777;
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;
  }
  const updated = sync(source);
  if (updated === source) return;
  await mkdir(dirname(path), { recursive: true, mode: 0o700 });
  const temporary = `${path}.${crypto.randomUUID()}.tmp`;
  const file = await open(temporary, "wx", mode);
  try {
    try {
      await file.writeFile(updated);
      await file.chmod(mode);
      await file.sync();
    } finally {
      await file.close();
    }
    await rename(temporary, path);
  } finally {
    await unlink(temporary).catch((error: NodeJS.ErrnoException) => {
      if (error.code !== "ENOENT") throw error;
    });
  }
  console.log(`updated ${path}`);
}

if (import.meta.main) await main();
