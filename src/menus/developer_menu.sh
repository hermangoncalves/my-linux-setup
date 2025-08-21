#!/bin/bash

declare -A APPS
APPS=(
    ["Visual Studio Code"]="com.visualstudio.code"
    ["Insomnia"]="rest.insomnia.Insomnia"
    ["VLC"]="org.videolan.VLC"
)

ARG_LIST=()
for app_name in "${!APPS[@]}"; do
    ARG_LIST+=(FALSE "$app_name")
done

source <(curl -s https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/refs/heads/main/src/linux-setup.lib)
sleep 1

_check_flatpak_

run_installation() {
    flatpak install --or-update -u -y "$1" 2>&1 | while IFS= read -r line; do
        echo "# ($2) $line"
    done

    FLATPAK_PID=$!
}

developer_menu() {
    local selections

    while true; do
        selections=$(zenity --list \
            --title="Developer Menu" \
            --checklist \
            --column="" --column="Apps" \
            "${ARG_LIST[@]}" \
            --width=360 --height=400 \
            --separator="|")

        IFS="|" read -r -a apps <<< "$selections"

        if [ ${#apps[@]} -eq 0 ]; then
            zenity --info --text="Nenhum app selecionado."
            continue
        fi

        total=${#apps[@]}
        count=0

        {
            for app in "${apps[@]}"; do
                ID_FLATHUB=${APPS[$app]}
                count=$((count+1))
                percent=$((count*100/total))
                echo "$percent"
                echo "# ($count/$total) Instalando $app..."
                sleep 2
                run_installation "$ID_FLATHUB" "$app"
            done
                echo "# Instalação concluida!"

        } | zenity --progress \
            --title="Instalando aplicativos" \
            --width=400 \
            --height=150 \
            --percentage=0

        if [ ${PIPESTATUS[1]} -ne 0 ]; then
            echo "Instalação cancelada pelo usuário!"
            kill $FLATPAK_PID 2>/dev/null  # interrompe o Flatpak em execução
            exit 1
        fi
    done
}

developer_menu
