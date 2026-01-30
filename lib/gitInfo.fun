#!/usr/bin/env bash
FPATH=$1
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
source "$SHARE/yaml2item.fun"

main() 
{
  dump ">>> git_info.fun running..."
}
main "$FPATH"
