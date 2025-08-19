#!/bin/bash

fatal() {
    zenity --error --title "Fatal Error" --text "$1" --width=300 --height=150
    exit 1
}

source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/linux-setup.lib)

_lang_

source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/languages/${langfile})

while true; do
    CHOICE=$(zenity --list --title "My linux setup" \
    --column="$msg001"  \
    "$msg002" \
    "$msg003" \
    --height=530 --width=360)

    if [ $? -ne 0 ]; then
        echo "Sayonara!!"
        exit 0
    fi

    case $CHOICE in
    "$msg002") menu="developer_menu" && _invoke_ ;;
    "$msg003") echo "Sayonara!!" && exit 0 ;;
    *) echo "Invalid option" ;;
    esac
done