#!/bin/bash
# .xinitrc
# aoneill - 02/08/16

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && source "$f"
  done
fi

export BROWSER=google-chrome-stable
export STEAM_RUNTIME=0

exec i3
