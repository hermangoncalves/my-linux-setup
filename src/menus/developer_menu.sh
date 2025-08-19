#!/bin/bash

run_installation() {
    local app_name="$1"
    local url="https://raw.githubusercontent.com/hermangoncalves/my-linux-setup/main/src/apps/${app_name}.sh"


    if ! curl -fsSL "$url" >/dev/null 2>&1; then
        fatal "Could not fetch app script '$app_name' from $url"
    fi

    source <(curl -fsSL "$url")
    sleep 1

    # if [ -f "$app_path" ]; then
    #     source "$app_path"
    #     install_app
    #     sleep 1
    # else
    #     zenity --error --text="App $app_name não encontrado"
    # fi
}

developer_menu() {
    local checklist
    checklist=$(get_apps)
    
    local selections
    selections=$(zenity --list \
        --title="Developer Menu" \
        --checklist \
        --column="" --column="Apps" \
        FALSE "All apps" \
        FALSE "VS Code" \
        FALSE "Insomnia" \
        FALSE "Golang" \
        FALSE "NodeJS + NVM" \
        FALSE "Python + Pyenv" \
        --width=360 --height=400 \
        --separator="|")
    
    if [ -n "$selections" ]; then
        IFS="|" read -r -a apps <<< "$selections"
        for app in "${apps[@]}"; do
            run_installation "$app"
        done
    fi
}

# Executa o menu
developer_menu
