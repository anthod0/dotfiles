import { execFileSync } from "node:child_process";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import { homedir } from "node:os";
import { dirname, join } from "node:path";

const [hoursArgument, excludesArgument] = process.argv.slice(2);
const hours = Number(hoursArgument);
const excludes = JSON.parse(excludesArgument ?? "null");
if (
  !Number.isSafeInteger(hours) ||
  hours <= 0 ||
  hours % 24 !== 0 ||
  !Array.isArray(excludes) ||
  !excludes.every((name) => typeof name === "string")
) {
  throw new Error(
    "Expected release age in whole days (hours) and a JSON array of exclusions",
  );
}
const excludesJSON = JSON.stringify(excludes);

if (Bun.which("npm")) {
  execFileSync(
    "npm",
    ["config", "set", "min-release-age", String(hours / 24), "--location=user"],
    {
      stdio: "inherit",
    },
  );
  const path = execFileSync("npm", ["config", "get", "userconfig"], {
    encoding: "utf8",
  }).trim();
  // npm config set accepts scalars; array exclusions require separate entries.
  const source = await readFile(path, "utf8");
  const lines = source
    .split(/\r?\n/)
    .filter((line) => !/^\s*min-release-age-exclude(?:\[\])?\s*=/.test(line));
  while (lines.at(-1) === "") lines.pop();
  for (const name of excludes)
    lines.push(`min-release-age-exclude[]=${JSON.stringify(name)}`);
  const updated = lines.join("\n") + "\n";
  if (updated !== source) await writeFile(path, updated, { mode: 0o600 });
} else {
  console.log("npm not found. Skipping.");
}

if (Bun.which("pnpm")) {
  execFileSync(
    "pnpm",
    ["config", "set", "minimumReleaseAge", String(hours * 60), "--global"],
    {
      stdio: "inherit",
    },
  );
  execFileSync(
    "pnpm",
    [
      "config",
      "set",
      "minimumReleaseAgeExclude",
      excludesJSON,
      "--json",
      "--global",
    ],
    {
      stdio: "inherit",
    },
  );
} else {
  console.log("pnpm not found. Skipping.");
}

const path = join(process.env.XDG_CONFIG_HOME || homedir(), ".bunfig.toml");
let source = "";
try {
  source = await readFile(path, "utf8");
} catch (error) {
  if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;
}
// As before, serialization preserves settings but removes TOML comments.
const config = Bun.TOML.parse(source) as Record<string, unknown>;
config.install ??= {};
if (typeof config.install !== "object" || Array.isArray(config.install)) {
  throw new Error(`Expected an [install] table in ${path}`);
}
const install = config.install as Record<string, unknown>;
if (
  install.minimumReleaseAge !== hours * 60 * 60 ||
  JSON.stringify(install.minimumReleaseAgeExcludes) !== excludesJSON
) {
  install.minimumReleaseAge = hours * 60 * 60;
  install.minimumReleaseAgeExcludes = excludes;
  const updated = Bun.TOML.stringify(config);
  if (updated === undefined) throw new Error(`Could not serialize ${path}`);
  await mkdir(dirname(path), { recursive: true });
  await writeFile(path, updated, { mode: 0o600 });
}
