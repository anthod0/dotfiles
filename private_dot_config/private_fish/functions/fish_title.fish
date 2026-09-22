function fish_title
    set -l ssh
    set -q SSH_TTY
    and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"

    if set -q argv[1]
        echo -- $ssh (string sub -l 20 -- $argv[1])
    else
        set -l command (status current-command)
        echo -- $ssh (string sub -l 20 -- $command)
    end
end
