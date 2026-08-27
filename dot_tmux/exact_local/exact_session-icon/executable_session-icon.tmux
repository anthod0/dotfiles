#!/usr/bin/env bash
# tmux session icon plugin
# Interpolates #{session_icon} in status-left/status-right

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

session_icon_interpolation="\#{session_icon}"
session_icon_command="#($CURRENT_DIR/session-icon.sh \"#{session_path}\")"

do_interpolation() {
  local result="$1"
  result=${result//$session_icon_interpolation/$session_icon_command}
  echo "$result"
}

update_tmux_option() {
  local option=$1
  local value
  value=$(tmux show-option -gqv "$option")
  local new_value
  new_value=$(do_interpolation "$value")
  tmux set-option -gq "$option" "$new_value"
}

update_tmux_option "status-left"
update_tmux_option "status-right"
