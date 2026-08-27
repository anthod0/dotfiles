if status is-interactive
    # ==================== Alias ====================
    alias glow="glow --line-numbers"
    alias ls="eza --color=auto --icons=auto"
    alias ll="eza -l --color=auto --icons=auto --group-directories-first --git"
    alias la="eza -la --color=auto --icons=auto --group-directories-first --git"
    alias lt="eza --tree --level=2 --color=auto --icons=auto"
    alias lta="eza --tree --level=2 -a --color=auto --icons=auto"

    # ==================== Abbr ====================
    # tmux
    abbr -a tn 'tmux new-session -A -s "$(basename "$PWD" | tr -dc "[:alnum:]_-")"'
    abbr -a ta 'tmux a'

    # others
    abbr -a n nvim .
    abbr -a c clear
    abbr -a .. 'cd ..'
    abbr -a lg lazygit

    # starship
    starship init fish | source
    # zoxide
    zoxide init fish | source
end

set -gx EDITOR vim
set -gx VISUAL vim

# fish vim key bindings
set -g fish_key_bindings fish_vi_key_bindings
