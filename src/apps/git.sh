#!/bin/bash
# Plugin: VSCode Installer

install_app() {
    if ! command -v git &>/dev/null; then
        log "Instalando Git..."
        sudo apt install -y git
        echo "Git instalado!"
    else
        echo "Git já está instalado: $(git --version)"
    fi
}