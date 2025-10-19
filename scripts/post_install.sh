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

# === PATH setup ===
PATH_DIRS=(
    "/usr/share/dotnet/sdk"
    "$HOME/.dotnet/tools"
)
for dir in "${PATH_DIRS[@]}"; do
    [[ ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
done
export PATH

# === Tasks ===
install_packages() {
    distro=$(detect_distro)
    case "$distro" in
      opensuse*)
        run_if_exists "$SCRIPT_DIR/install_packages_opensuse.sh" ;;
      arch)
        run_if_exists "$SCRIPT_DIR/install_packages_arch.sh" ;;
      *)
        echo -e "${YELLOW}Unsupported distro: $distro${TXTRST}" ;;
    esac
}

stow_dotfiles() {
    run_if_exists "$SCRIPT_DIR/stow_dotfiles.sh"
}

install_manual_tools() {
    echo -e "Installing Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh already installed."
    fi

    echo -e "Installing Pokemon-colorscripts..."
    tmpdir="$(mktemp -d)"
    git clone --depth=1 https://gitlab.com/phoneybadger/pokemon-colorscripts.git "$tmpdir"
    cd "$tmpdir" || return 1
    sudo ./install.sh || return 1
    cd - >/dev/null
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

# === Main menu loop ===
while true; do
    echo -e "\n${CYAN}=== Post-install Menu ===${TXTRST}"
    echo "1) Install packages via package manager"
    echo "2) Stow dotfiles"
    echo "3) Install other packages (Oh My Zsh, pokemon-colorscripts, ...)"
    echo "4) Install VSCode extensions"
    echo "5) Quit"
    read -rp "Choose an option: " choice

    case "$choice" in
        1) run_with_feedback "Install packages via package manager" install_packages ;;
        2) run_with_feedback "Stow dotfiles" stow_dotfiles ;;
        3) run_with_feedback "Install other packages" install_manual_tools ;;
        4) run_with_feedback "Install VSCode extensions" install_vscode_extensions ;;
        5) echo "Exiting."; break ;;
        *) echo -e "${YELLOW}Invalid option.${TXTRST}" ;;
    esac
done

echo -e "${GREEN}Post-install finished.${TXTRST}"

