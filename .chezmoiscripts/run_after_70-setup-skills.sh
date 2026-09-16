#!/bin/bash

set -euo pipefail

for tool in gh jq; do
    command -v "$tool" >/dev/null || {
        echo "$tool is required to manage skills." >&2
        exit 1
    }
done

repo=anthod0/skills
skills_dir=$HOME/.agents/skills
lock_file=$HOME/.agents/.skill-lock.json

# gh only checks flat skill directories, not skills nested inside an old clone.
if [[ -e $skills_dir/.git ]]; then
    echo "$skills_dir is a Git clone. Remove it manually before installing skills with gh." >&2
    exit 1
fi

skill_names=''
if [[ -f $lock_file ]]; then
    skill_names=$(jq -r --arg repo "$repo" '
        .skills // {} | to_entries[] | select(.value.source == $repo) | .key
    ' "$lock_file")
fi

# Never prompt to overwrite existing skills during chezmoi apply.
export GH_PROMPT_DISABLED=1

if [[ -n $skill_names ]]; then
    mapfile -t skills <<< "$skill_names"
    gh skill update --all --dir "$skills_dir" "${skills[@]}"
else
    gh skill install "$repo" --all --agent universal --scope user
fi
