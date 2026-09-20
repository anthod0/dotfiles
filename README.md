# dotfiles

My personal development environment configuration, managed with [chezmoi](https://www.chezmoi.io/). Supports **Arch Linux** and **Fedora**.

## What's Included

- **Shell**: Fish, Starship, Zoxide, and commonly used aliases and abbreviations
- **Editor**: Neovim configuration based on [LazyVim](https://www.lazyvim.org/)
- **AI**: AGENTS.md and personal [skills](https://github.com/anthod0/skills)
- **Tmux**: tmux configuration, TPM plugins, and keybindings
- **Niri**: Shared keybindings and window/layer rules; machine-specific settings remain local
- **Git**: Default branch, rebase behavior, global ignore rules, etc.
- **CLI tools**: fzf, ripgrep, fd, eza, bat, lazygit, yazi, glow, btop, etc.
- **Supply chain security**: Release-age cooldown for npm, pnpm, and Bun
- **System setup**: Automatic package installation based on the Linux distribution

## Quick Start

### Prerequisites

- Arch Linux or Fedora
- `chezmoi`
- `git`

### Installation

See the [chezmoi quick start guide](https://www.chezmoi.io/quick-start/) for installation instructions.

## Repository Structure

```text
.
├── .chezmoidata/          # Package lists and package release-age exclusions
├── .chezmoiscripts/       # System setup and configuration scripts
│   ├── arch/              # Arch Linux-specific scripts
│   └── fedora/            # Fedora-specific scripts
├── dot_local/bin/         # User-level commands
├── dot_pi/                # Pi AGENTS.md
├── dot_codex/             # Codex AGENTS.md
├── dot_tmux.conf          # Main tmux configuration
└── private_dot_config/    # Application configuration under ~/.config
    ├── exact_nvim/        # Neovim / LazyVim
    ├── niri/              # Shared keybindings and window/layer rules
    ├── private_fish/      # Fish
    ├── private_glow/      # Glow
    └── starship.toml      # Starship prompt
```
