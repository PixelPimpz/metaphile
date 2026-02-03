#!/usr/bin/env bash
mf_name()
{
  local PANE_PID=$(tmux display -p "#{pane_pid}")
  local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
  local PARENT_PROC="$(ps -q "${PANE_PID}" o comm=)"

  if [[ "${SOCKET}" =~ ${PANE_PID} ]]; then # /tmp/nvim-XXXXX = nvim ... /tmp/ = no nvim socket 
    local ICON="$( yaml2item ".icons.sys.Document" $ICONS )"
    local BUF_NAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%:t")' )"
  else
    local ICON="$( yaml2item ".icons.app.$PARENT_PROC" $ICONS )"
    local BUF_NAME="${PARENT_PROC}"
  fi

  echo "${ICON} ${BUF_NAME}"
}
