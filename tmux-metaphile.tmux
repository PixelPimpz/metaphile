#!/usr/bin/env bash
echo "Welcome, adventurer!"
tmux setenv '@PLUG_ROOT' "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
$ICONSf="$(tmux display -p "#{@LIB_ICON}")"
