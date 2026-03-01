#!/usr/bin/env bash
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set -g '@MF_ROOT' "$LOCAL_ROOT"
SHARE="$(tmux show -gqv @CHER )"
source "$SHARE/fun/dump.fun"
source "$SHARE/fun/fatal.fun"
"$LOCAL_ROOT/scripts/hooks $LOCAL_ROOT" 
tmux set -gu @MF_PATH
tmux set -gu @MF_NAME
tmux set -gu @MF_GIT
tmux bind M-m run-shell "$LOCAL_ROOT/scripts/metaphile.sh"
tmux run-shell "$LOCAL_ROOT/scripts/metaphile.sh"
