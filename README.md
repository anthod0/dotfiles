# dotfiles

My personal development environment configuration, managed with [chezmoi](https://www.chezmoi.io/). Supports **Arch Linux** and **Fedora**.

## What's Included

- **Shell**: Fish, Starship, Zoxide, and commonly used aliases and abbreviations
- **Editor**: Neovim configuration based on [LazyVim](https://www.lazyvim.org/)
- **Terminal multiplexer**: tmux configuration, TPM plugins, and keybindings
- **Git**: Default branch, rebase behavior, Delta diffs, global ignore rules, and more
- **CLI tools**: fzf, ripgrep, fd, eza, bat, lazygit, yazi, glow, btop, and more
- **AI tools**: AGENTS.md files for Pi and Codex, plus my personal [skills](https://github.com/anthod0/skills)
- **Supply chain security**: A seven-day package release-age cooldown for npm, pnpm, and Bun
- **System setup**: Automatic package installation based on the Linux distribution

## Quick Start

### Prerequisites

- Arch Linux or Fedora
- `chezmoi`
- `git`

### Installation

See the [chezmoi quick start guide](https://www.chezmoi.io/quick-start/) for installation instructions.

Based on the current system, chezmoi automatically runs setup scripts that:

1. Install packages;
2. Configure global Git settings;
3. Install TPM and tmux plugins;
4. Install Neovim plugins;
5. Configure dependency release-age policies for any installed npm, pnpm, and Bun package managers.

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
    ├── private_fish/      # Fish
    ├── private_glow/      # Glow
    └── starship.toml      # Starship prompt
```
