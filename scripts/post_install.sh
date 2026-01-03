#!/usr/bin/env bash
set -e

# A script to help with setup after fresh OS installation

# === Colors ===
RED='\e[0;31m'
CYAN='\e[0;36m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
TXTRST='\e[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# === Helper functions ===
confirm() {
    read -rp "$1 [y/N]: " ans
    [[ "$ans" =~ ^[Yy]$ ]]
}

run_if_exists() {
    local script="$1"
    if [ -x "$script" ]; then
        bash "$script"
    else
        echo -e "${YELLOW}Skipping: $script (not found or not executable)${TXTRST}"
    fi
}

run_with_feedback() {
    local label="$1"
    shift
    if "$@"; then
        echo -e "${GREEN} $label finished successfully${TXTRST}"
    else
        echo -e "${RED} $label failed${TXTRST}"
    fi
}

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# === Extracted helpers ===
setup_path() {
    PATH_DIRS=(
        "/usr/share/dotnet/sdk"
        "$HOME/.dotnet/tools"
    )

    for dir in "${PATH_DIRS[@]}"; do
        [[ ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
    done

    export PATH
}

set_default_shell() {
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        echo -e "Setting zsh as default shell..."
        chsh -s "$(command -v zsh)"
    fi
}

# === Tasks ===
install_packages() {
    distro=$(detect_distro)
    case "$distro" in
        opensuse*)
            run_if_exists "$SCRIPT_DIR/install_pkgs_opensuse.sh" ;;
        arch)
            run_if_exists "$SCRIPT_DIR/install_pkgs_arch.sh" ;;
        *)
            echo -e "${YELLOW}Unsupported distro: $distro${TXTRST}" ;;
    esac
}

stow_dotfiles() {
    run_if_exists "$SCRIPT_DIR/stow_dotfiles.sh"
}

install_manual_tools() {
    set_default_shell

    echo -e "Installing Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        RUNZSH=no CHSH=no sh -c \
          "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh already installed."
    fi

    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    clone_if_missing() {
        local repo="$1"
        local target="$2"
        [ -d "$target" ] || git clone --depth=1 "$repo" "$target"
    }

    clone_if_missing \
        https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

    clone_if_missing \
        https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    clone_if_missing \
        https://github.com/romkatv/powerlevel10k \
        "$ZSH_CUSTOM/themes/powerlevel10k"

    echo -e "Installing Pokemon-colorscripts..."
    tmpdir="$(mktemp -d)"
    git clone --depth=1 https://gitlab.com/phoneybadger/pokemon-colorscripts.git "$tmpdir"
    sudo "$tmpdir/install.sh" || return 1
    rm -rf "$tmpdir"
}

install_vscode_extensions() {
    EXT_LIST="$ROOT_DIR/dots/vscode/extensions-list.txt"
    if command -v code >/dev/null 2>&1 && [ -f "$EXT_LIST" ]; then
        cat "$EXT_LIST" | xargs -n 1 code --install-extension
    else
        echo -e "${YELLOW}VSCode or extensions list not found.${TXTRST}"
        return 1
    fi
}

full_install() {
    setup_path
    install_packages
    install_manual_tools
    stow_dotfiles
    install_vscode_extensions
}

# === Main menu loop ===
while true; do
    echo -e "\n${CYAN}=== Post-install Menu ===${TXTRST}"
    echo "0) Full install"
    echo "1) Install packages via package manager"
    echo "2) Stow dotfiles"
    echo "3) Install other packages (Oh My Zsh, pokemon-colorscripts, ...)"
    echo "4) Install VSCode extensions"
    echo "5) Quit"

    read -rp "Choose an option: " choice

    case "$choice" in
        0) run_with_feedback "Full install" full_install ;;
        1) run_with_feedback "Install packages via package manager" install_packages ;;
        2) run_with_feedback "Stow dotfiles" stow_dotfiles ;;
        3) run_with_feedback "Install other packages" install_manual_tools ;;
        4) run_with_feedback "Install VSCode extensions" install_vscode_extensions ;;
        5) echo "Exiting."; break ;;
        *) echo -e "${YELLOW}Invalid option.${TXTRST}" ;;
    esac
done

echo -e "${GREEN}Post-install finished.${TXTRST}"

