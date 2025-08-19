#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

APPS_DIR="$PROJECT_DIR/apps"

echo $APPS_DIR

get_apps() {
    for app in "$APPS_DIR"/*.sh; do
        [ -f "$app" ] && source "$app" && echo "FALSE $(basename "$app" .sh)"
    done
}

run_installation() {
    local app_name="$1"
    local app_path="$APPS_DIR/$app_name.sh"

    if [ -f "$app_path" ]; then
        source "$app_path"
        install_app
        sleep 1
    else
        zenity --error --text="App $app_name não encontrado"
    fi
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
        $checklist \
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
