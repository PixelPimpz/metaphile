#!/usr/bin/env bash
tmux set-hook -g client-focus-out[0] 'run-shell "#{@NVIM_INFO_ROOT}/tmux-nvim-info.tmux"' 
tmux set-hook -g client-focus-in[0] 'run-shell "#{@NVIM_INFO_ROOT}/tmux-nvim-info.tmux"'
tmux set-hook -g pane-focus-in[0] 'run-shell "#{@NVIM_INFO_ROOT}/tmux-nvim-info.tmux"' 
tmux set-hook -g pane-exited[0] 'run-shell "#{@NVIM_INFO_ROOT}/tmux-nvim-info.tmux"'
tmux set-hook -g session-window-changed[0] 'run-shell "#{@NVIM_INFO_ROOT}/tmux-nvim-info.tmux"'
