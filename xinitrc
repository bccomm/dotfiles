#!/bin/bash
xrandr --output HDMI1 --left-of HDMI2 --auto

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


devmon &

devmon --mount /dev/sdb1 

start-pulseaudio-x11  #BASZD MEG

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

/usr/local/bin/stumpwm --no-userinit > ~/stumpwmlog 2>&1

