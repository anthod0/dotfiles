import { mkdir, open, readFile, rename, stat, unlink } from "node:fs/promises";
import { homedir } from "node:os";
import { dirname, join } from "node:path";

const settings = {
  agentMode: "accept-edits",
  allowNonWorkspaceAccess: true,
  runningLightSpeed: "off",
  toolPermission: "always-proceed",
};

export function sync(source: string): string {
  const parsed: unknown = source.trim() === "" ? {} : JSON.parse(source);
  if (typeof parsed !== "object" || parsed === null || Array.isArray(parsed)) {
    throw new Error("Expected a JSON object in Antigravity CLI settings");
  }
  const config = parsed as Record<string, unknown>;
  if (
    source !== "" &&
    Object.entries(settings).every(([key, value]) => config[key] === value)
  ) {
    return source;
  }
  const updated = Object.fromEntries(
    Object.entries({ ...config, ...settings }).sort(([a], [b]) =>
      a < b ? -1 : a > b ? 1 : 0,
    ),
  );
  return `${JSON.stringify(updated, null, 2)}\n`;
}

async function main() {
  const path = join(homedir(), ".gemini", "antigravity-cli", "settings.json");
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
  await mkdir(dirname(path), { recursive: true, mode: 0o755 });
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
