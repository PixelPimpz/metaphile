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
  tmux set -g '@MF_NAME' "$(mf_name)"
  tmux set -g '@MF_GIT' "$(mf_git)"
  ps -q $(tmux display -p "#{pane_pid}") o comm=
}

mf_git()
{
  local ICON=$(yaml2item ".icons.app.gh" $ICONS )
  echo "${ICON} author/plugin"
}

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

main
