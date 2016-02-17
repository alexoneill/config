#!/bin/bash
# .xinitrc
# aoneill - 02/08/16

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && source "$f"
  done
fi

exec i3
