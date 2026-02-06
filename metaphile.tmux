#!/usr/bin/env bash
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set -g '@MF_ROOT' "$LOCAL_ROOT"
SHARE="$(tmux show -gqv @CHER )"
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
tmux run-shell "#{@MF_ROOT}/conf/hooks #{@MF_ROOT}" 
tmux set -u @MF_PATH
tmux set -u @MF_NAME
tmux set -u @MF_GIT
tmux bind M-m run-shell "$LOCAL_ROOT/scripts/metaphile.sh"
tmux run-shell "$LOCAL_ROOT/scripts/metaphile.sh"
