#!/bin/bash

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
white="${esc}[37m"

yellow="${bright}${brown}"

info=" ${cyan}*${clr} "
success=" ${green}*${clr} "
error=" ${red}*${clr} "
warning=" ${yellow}*${clr} "

listItem="  ${bright}${white}-${clr}"
