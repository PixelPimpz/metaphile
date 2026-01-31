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
LOCAL_ROOT="$( tmux show -gqv pane-current-path )
SHARE=$( tmux show -gqv @CHER )
source "$SHARE/dump.fun"
source "$SHARE/fatal.fun"
dump ">>> metaphile.sh running..."
dump ">> $LOCAL_ROOT"
