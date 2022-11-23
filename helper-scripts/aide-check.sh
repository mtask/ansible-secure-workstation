#!/bin/bash
if [ ! $(id -u) = 0 ]
then
    echo '[!] Run as root'
    exit 1
fi
aide -c /etc/aide/aide.conf
