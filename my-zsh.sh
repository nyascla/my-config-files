#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
# Pipelines return the exit status of the last command to fail.
set -euo pipefail

# Get the directory of the currently executing script
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

info() {
    echo "INFO: $1"
}

check_dependencies() {
    info "Verificando dependencias..."
    for cmd in git curl sudo; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "ERROR: El comando '$cmd' no está instalado. Por favor, instálalo para continuar." >&2
            exit 1
        fi
    done
}

install_zsh() {
    info "Instalando zsh..."
    if ! command -v zsh &> /dev/null; then
        sudo apt update && sudo apt install -y zsh
        info "zsh instalado correctamente."
    else
        info "zsh ya está instalado."
    fi

    if [[ "${SHELL}" != *"zsh"* ]]; then
        info "Cambiando el shell por defecto a zsh..."
        chsh -s "$(which zsh)"
    else
        info "zsh ya es el shell por defecto."
    fi
}

install_ohmyzsh() {
    info "Instalando Oh My Zsh..."
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        # Ejecuta la instalación de forma no interactiva
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        info "Oh My Zsh ya está instalado."
    fi

    # Definir la ruta de plugins personalizados
    local ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

    info "Instalando plugins de zsh..."
    # zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
    else
        info "Plugin 'zsh-syntax-highlighting' ya existe."
    fi

    # zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
    else
        info "Plugin 'zsh-autosuggestions' ya existe."
    fi

    info "Instalando tema 'powerlevel10k'..."
    # powerlevel10k theme
    if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
    else
        info "Tema 'powerlevel10k' ya existe."
    fi
}

install_fzf() {
    info "Instalando fzf..."
    if [ ! -d "${HOME}/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all # --all para instalación no interactiva
    else
        info "fzf ya está instalado."
    fi
}

copy_config_files() {
    info "Copiando archivos de configuración..."
    cp "${script_dir}/config-files/.zshrc" "${HOME}/"
    cp "${script_dir}/config-files/.tmux.conf" "${HOME}/"
    info "Archivos de configuración copiados."
}

configure_git() {
    info "Configurando alias de Git 'acp'..."
    # Comprueba si el alias ya existe para que el script sea idempotente.
    if ! git config --get alias.acp > /dev/null 2>&1; then
        git config --global alias.acp '!f() { git add -A && git commit -m "$@" && git push; }; f'
        info "Alias 'acp' de Git creado correctamente."
    else
        info "El alias 'acp' de Git ya existe."
    fi
}

install_xclip() {
    info "Instalando xclip..."
    if ! command -v xclip &> /dev/null; then
        sudo apt update && sudo apt install -y xclip
        info "xclip instalado correctamente."
    else
        info "xclip ya está instalado."
    fi
}

install_eza() {
    info "Instalando eza..."
    if ! command -v eza &> /dev/null; then
        sudo apt update && sudo apt install -y eza
        info "eza instalado correctamente."
    else
        info "eza ya está instalado."
    fi
}

main() {
    check_dependencies
    install_zsh
    install_xclip
    install_ohmyzsh
    install_fzf
    install_eza
    copy_config_files
    configure_git
    info "¡Instalación completada! Por favor, reinicia tu terminal o inicia una nueva sesión de zsh."
}

main "$@"
