#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# first gather context info: are we in ther shell, neovim or something else?
#   if not in nvim, gather the current shell command and the pwd with 
#   "tmux pane-current-path" 
#   put the current-command's icon and the cwd into section 1.1
#   put the current-command and it's icon into section 1.2
# if nvim is running and the open buffer is in a directory tree with a ".git"
# folder at its root, then run gitInfo and put the remote repo and a github 
# icon in section 1.1 and the NeoVim logo icon + the file name in section 1.2
# add completed sections to somewhere
# -----------------------------------------------------------------------------
LOCAL_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOCAL_ROOT="${LOCAL_ROOT%/*}"
SHARE=$( tmux show -gqv @CHER )
ICONS=$( tmux show -gqv @ICONS )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
source "$SHARE/yaml2item.fun"

main()
{
  dump ">>> metaphile.sh running..."
  local PANE_PID=$(tmux display -p "#{pane_pid}")
  local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
  local CHILD_PROC="$(ps -o comm= --ppid "${PANE_PID}")"
  local PARENT_PROC="$(ps -q "${PANE_PID}" o comm=)"

  if [[ "${SOCKET}" =~ ${PANE_PID} ]]; then # /tmp/nvim-XXXXX = nvim ... /tmp/ = no nvim socket 
    local ICON="$( yaml2item ".icons.app.Folder" $ICONS )"
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
  else
    local ICON="$( yaml2item ".icons.app.Folder" $ICONS )"
    local BUF_NAME="${PARENT_PROC}"
    local SOCKET="none"
  fi
  local STATUS="${ICON} ${BUF_NAME}"

  tmux set -g '@MF_NAME' "$STATUS"
  report
}

report()
{
  dump ">> ICONS: $ICONS"
  dump ">> PANE_PID: $PANE_PID"
  dump ">> SOCKET: $SOCKET"  
  dump ">> CHILD_PROC: $CHILD_PROC"  
  dump ">> PARENT_PROC: $PARENT_PROC"  
  dump ">> ICON: $ICON"
  dump ">> BUF_NAME: $BUF_NAME"
}

main
