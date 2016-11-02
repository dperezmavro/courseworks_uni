#!/bin/bash

if [ "$(pidof firefox)" ]
then
	killall firefox 
fi
make applet &
make appletjar &
make move &
firefox &
