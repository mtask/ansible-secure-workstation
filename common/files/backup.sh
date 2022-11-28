#!/bin/bash

if [ ! $(id -u) = 0 ]
then
   echo "[!] Run as root"
   exit 1
fi

rsnapshot -c /opt/rsnapshot/rsnapshot.conf -v backup

