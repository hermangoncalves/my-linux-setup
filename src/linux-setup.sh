#!/bin/bash
. /etc/os-release

echo "Detecting: $NAME ($ID $VERSION_ID)"

fatal() {
    zenity --error --title "Fatal Error" --text "$1" --width=300 --height=150
    exit 1
}

ping -c1 google.com &>/dev/null || fatal "No internet connection. Please connect and retry."

sudo_request() {
    zenity --password | sudo -Sv || fatal "Wrong password. Do you have sudo"
}

source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/linux-setup.lib)
sleep 1
_lang_

source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/languages/${langfile})
sleep 1

sudo_request

while true; do
    CHOICE=$(zenity --list --title="$msg001" \
        --column="Opções" \
        "$msg002" \
        "$msg004" \
        "$msg005" \
        "$msg003" \
        --height=400 --width=300)

    if [ $? -ne 0 ]; then
        echo "Sayonara!!"
        exit 0
    fi

    case $CHOICE in
        "$msg002") menu="developer_menu" && _invoke_ ;;
        "$msg003") menu="browser_menu" && _not_implemented_yet ;;
        "$msg004") menu="entertainment_menu" && _not_implemented_yet ;;
        "$msg005") menu="productivity_menu" && _not_implemented_yet ;;
        "$msg006") echo "Sayonara!!" && exit 0 ;;
        *) echo "Invalid option" ;;
    esac
done