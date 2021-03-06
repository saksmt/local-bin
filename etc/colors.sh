#!/usr/bin/env bash

esc=`echo -en "\033"`

clr="${esc}[0m"
bright="${esc}[1m"

black="${esc}[30m"
red="${esc}[31m"
green="${esc}[32m"
brown="${esc}[33m"
blue="${esc}[34m"
violet="${esc}[35m"
cyan="${esc}[36m"
gray="${esc}[90m"
white="${esc}[37m"

yellow="${bright}${brown}"

info=" ${cyan}*${clr} "
success=" ${green}*${clr} "
error=" ${red}*${clr} "
warning=" ${yellow}*${clr} "
warn=" ${yellow}*${clr} "

highlight="${bright}${white}"

listItem="  ${highlight}-${clr}"

function codeBlock() {
    echo "  > ${highlight}${@}${clr}"
}
