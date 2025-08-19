#!/bin/bash
. /etc/os-release


source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/linux-setup.lib)

_lang_

source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/languages/${langfile})

echo $langfile

while true; do
    CHOICE=$(zenity --list --title "My linux setup" \
    --column="$msg001"  \
    "$msg002" \
    "" \
    "$msg003" \
    --height=530 --width=360)

    if [ $? -ne 0 ]; then
        exit 0
    fi

    case $CHOICE in
    "$msg002") menu="developer_menu" && _invoke_ ;;
    "$msg003") exit ;;
    *) echo "Invalid option" ;;
    esac
done