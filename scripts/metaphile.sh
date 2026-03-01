#!/usr/bin/env bash 
SHARE=$( tmux show -gqv @CHER )
ICONS=$( tmux show -gqv @ICONS )
source "$SHARE/fun/dump.fun"
source "$SHARE/fun/fatal.fun"
source "$SHARE/fun/yaml2item.fun"

main()
{
  IFS=":"; read -r -a mf_info_array <<< "$(mf_info)"
  local icon="${mf_info_array[0]}"
  local file="${mf_info_array[2]}"
  local path="${mf_info_array[1]}"
  local mod="${mf_info_array[3]}"
  tmux set -g '@MF_NAME' "${icon} ${file}"
  if [[ $( git -C "${path%/*}" rev-parse --is-inside-work-tree ) ]]; then
    local git_dir=$(git -C "${path%/*}" rev-parse --show-toplevel )
    tmux set -g '@MF_GIT' "$(mf_git $git_dir)"
  fi
  path="${path%/*}"
  local home="$HOME"
  tmux set -g '@MF_PATH' "${path}"
  [[ ! "$(tmux show -gq @VIRGIN)" ]] && tmux source "~/.tmux/tmux.conf" \; set -g @VIRGIN ""   
  tmux refresh-client
}

mf_info()
{
  local PANE_PID=$(tmux display -p "#{pane_pid}")
  local SOCKET="/tmp/$(ls /tmp | grep -E "${PANE_PID}")"
  local PARENT_PROC="$(ps -q "${PANE_PID}" o comm=)"
  local MFROOT="$( tmux show -gqv @METAPHILEROOT )"

  if [[ "${SOCKET}" =~ ${PANE_PID} ]]; then 
    local FPATH="$( nvim --server ${SOCKET} --remote-expr 'expand("%:p")' )"
    local FNAME="$( nvim --server ${SOCKET} --remote-expr 'expand("%")' )"
    local ICON=$( yaml2item ".icons.sys.Document" $ICONS )
    MODIFIED="$( nvim --server ${SOCKET} --remote-expr '&modified' )"
  else
    local ICON=$( yaml2item ".icons.app.$PARENT_PROC" $ICONS )
    local FNAME="${PARENT_PROC}"
  fi
  
  echo "${ICON}:${FPATH}:${FNAME}:${MODIFIED}"
}

mf_git()
{
  local gitroot=$1
  local repo="$( git -C $gitroot info | grep -E "\(push\)" | sed 's/^.*://;s/\.git .*$//' )"
  local ICON=$( yaml2item ".icons.app.gh" $ICONS )
  echo "${ICON} $repo"
}

main
