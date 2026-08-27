#!/bin/bash

set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
    echo "git not found. Skipping."
    exit 0
fi

git config --global init.defaultBranch "main"
git config --global pull.rebase true
git config --global core.excludesfile "$HOME/.gitignore_global"
