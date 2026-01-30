# Welcome to metaphile a context based info unit for the tmux status bar
## NeoVIM and TMUX tools for metadata communication

### Introduction
Q: Why do this? 
A: Because even though we use NeoVim inside tmux sessions ubiquitously,
there is no way for NeoVim and tmux to detect events relevant to each-
other and pass critical info.

A common use-case would be the creation of a unified status bar that 
could replace the default ones reducing visual clutter when a developer
is working on a codebas in NeoVim and tmux

### Installation
### tmux plugin via TPM (tmux plugin manager)
* add the plugin to ~/.tmux.conf
    set -g @plugin 'pixelpimpz/tmux-metaphile'
* use SHIFT+I to tell TPM to fetch the files and
install them. 
