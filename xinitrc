#! /bin/bash
exec dbus-launch --exit-with-session i3
exec xbindkeys

exec xrdb ~/.Xresources
