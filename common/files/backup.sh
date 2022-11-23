#!/bin/bash

if [ ! $(id -u) = 0 ]
then
   echo "[!] Run as root"
   exit 1
fi

mkdir -p rsnapshot
rsnapshot -c ./rsnapshot.conf -v backup

