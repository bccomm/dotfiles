#!/bin/bash

systemctl --user import-environment DISPLAY XAUTHORITY

if which dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

myhost=$(hostname -s)

if [ $myhost == "topd0g" ]; then
    xrandr --output HDMI1 --left-of HDMI2 --auto
elif [ $myhost == "underd0g" ]; then
    xrandr --output HDMI1 --right-of eDP1 --auto
fi

if [ $myhost == "topd0g" -o $myhost == "underd0g" ]; then
    MPD_HOST=/home/sh0e/.mpd/socket
    devmon &
    mpd ~/dotfiles/mpd.conf && export MPD_HOST
fi

start-pulseaudio-x11

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

/usr/local/bin/stumpwm

