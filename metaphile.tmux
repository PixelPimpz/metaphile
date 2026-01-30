#!/usr/bin/env bash
echo "Welcome, adventurer!"
tmux setenv -u @PLUG_ROOT
tmux setenv '@PLUG_ROOT' "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
ICONS="$(tmux display -p "#{@LIB_ICON}")"
tmux bind M-m run "$PLUG_ROOT/tmux-metaphile"

## run main plugin script
$PLUG_ROOT/scripts/tmux-metaphile.sh
