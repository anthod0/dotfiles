#!/bin/bash

set -euo pipefail

fish_path=$(command -v fish) || {
    echo "fish is required to set the login shell." >&2
    exit 1
}

# SHELL can still refer to the previous login shell until the next login.
current_shell=$(getent passwd "$(id -un)" | cut -d: -f7)
if [[ $current_shell == "$fish_path" ]]; then
    echo "fish is already the login shell."
    exit 0
fi

if ! grep -Fxq "$fish_path" /etc/shells; then
    echo "$fish_path is not listed in /etc/shells. Register it before running chsh." >&2
    exit 1
fi

chsh -s "$fish_path"
echo "Login shell changed to fish. Log out and back in to use it."
