#!/usr/bin/env bash
SHARE="$(tmux show -gqv @CHER )"
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set -g '@METAPHILEROOT' "$LOCAL_ROOT"
tmux set -u @MF_PATH
tmux set -u @MF_NAME
tmux set -u @MF_GIT
source "$METAPHILEROOT/conf/hooks.conf" || fatal "hooks failed to load"
tmux bind M-m run-shell "$LOCAL_ROOT/scripts/metaphile.sh"
tmux run-shell "$LOCAL_ROOT/scripts/metaphile.sh"
