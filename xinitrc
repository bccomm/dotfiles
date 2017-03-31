#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ $(hostname -s) == "topd0g" ]; then
    xrandr --output HDMI1 --left-of HDMI2 --auto
    devmon &
    devmon --mount /dev/sdb1

    offlineimap 2>&1 > /dev/null &
    MPD_HOST=/home/sh0e/.mpd/socket
    mpd ~/dotfiles/mpd.conf && export MPD_HOST
fi

start-pulseaudio-x11

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

/usr/local/bin/stumpwm

