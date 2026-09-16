#!/bin/bash

set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
    echo "git not found. Skipping."
    exit 0
fi

git config --global init.defaultBranch "main"
git config --global pull.rebase true
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light true
git config --global merge.conflictStyle zdiff3
