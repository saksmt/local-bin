#!/bin/bash

source /usr/local/etc/colors.sh

if [[ "$USER" != "root" ]]; then
    echo ""$error"You need root privileges to perform this task!"
    echo ""$info'Use "dosu" to quickly run previous command prepended with "sudo"'
    exit
fi 

