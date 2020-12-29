#!/usr/bin/env bash

source /usr/local/etc/colors.sh

if [[ n"${EXPECTED_USER}" == "n" ]] && [[ n"${EXPECTED_GROUP}" == "n" ]]; then
    EXPECTED_USER="root"
fi

if [[ n"${EXPECTED_USER}" == "n" ]] && [[ n"$(groups | grep "${EXPECTED_GROUP}")" == "n" ]]; then
    echo "${error}You need to be part of group ${highlight}${EXPECTED_GROUP}${clr} to execute this."
    echo "${info}You may want to execute this command as root or other user using ${highlight}sudo${clr}"
    echo "${info}To do so you can quickly execute previous command as other user:"
    echo "$(codeBlock "sudo -u someUserWithAccessTo${EXPECTED_GROUP} !!")"
    echo "${info}Or just run as root:"
    echo "$(codeBlock "sudo !!")"
    exit 1
fi

if [[ n"${EXPECTED_USER}" != "n" ]] && [[ "${EXPECTED_USER}" != "${USER}" ]]; then
    echo "${error}Not enough priveleges to execute this command!"
    echo "${info}You need to execute this command as user ${highlight}${EXPECTED_USER}${clr}"
    echo "${info}You may want to execute this command as root or other user using ${highlight}sudo${clr}"
    echo "${info}To do so you can quickly execute previous command as other user:"
    echo "$(codeBlock "sudo -u someUserWithAccessTo${EXPECTED_GROUP} !!")"
    echo "${info}Or just run as root:"
    echo "$(codeBlock "sudo !!")"
    exit 1
fi
