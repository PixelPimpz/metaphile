#!/usr/bin/env bash
main() {
  for orig in "$( tmux list-keys | grep 'next-window' | grep -iv 'wheel' )"; do
    local keystr="$( awk '{printf '%s', $4}' <<< $orig )"
    local cmdstr="$( awk '{printf '%s', $5}' <<< $orig )"
    printf "%s %s\n" "$keystr" "$cmdstr" >> ~/temp-tmux.log
  done
}
main

