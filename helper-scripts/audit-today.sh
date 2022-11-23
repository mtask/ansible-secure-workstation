#!/bin/bash
if [ ! $(id -u) = 0 ]
then
    echo '[!] Run as root'
    exit 1
fi

aureport --start today
aureport -m --start today
aureport -n --start today
echo -e "\nClamAV quarantine"
echo -e "=================\n"
ausearch -k clamav --format text -sc openat |awk '{print $2" "$3" "$10}'
