#!/bin/bash
set -e  # 遇到错误立即退出

# ==============================================================================
# Script Name: zsh_builder.sh
# Description: Automated installation of Zsh, Oh My Zsh, Starship, and plugins.
# Usage:
#   wget -O ./zsh_builder.sh https://raw.githubusercontent.com/Godyu97/vege9Notes/master/tools/terminal/zsh_builder.sh
#   chmod +x ./zsh_builder.sh
#   ./zsh_builder.sh
# ==============================================================================

# 1. 变量定义
INSTALL_CMD=""
OH_MY_ZSH_DIR="${HOME}/.oh-my-zsh"
ZSHRC_URL="https://raw.githubusercontent.com/Godyu97/vege9Notes/master/tools/conf/.zshrc"
DEPENDENCIES=(wget curl git zsh)

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_err() { echo -e "${RED}[ERROR]${NC} $1"; }

# 2. 系统检测与初始化
detect_os() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        log_info "Detected macOS"
        if command -v brew >/dev/null 2>&1; then
            INSTALL_CMD="brew install"
        else
            log_err "Homebrew not found. Please install Homebrew first."
            exit 1
        fi
    elif [[ "$(uname -s)" == "Linux" ]]; then
        log_info "Detected Linux"
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            case "$ID" in
                debian|ubuntu|kali|raspbian)
                    INSTALL_CMD="sudo apt update && sudo apt install -y"
                    ;;
                centos|rhel|fedora|rocky|almalinux)
                    if command -v dnf >/dev/null 2>&1; then
                        INSTALL_CMD="sudo dnf install -y"
                    else
                        INSTALL_CMD="sudo yum install -y"
                    fi
                    ;;
                arch|manjaro)
                    INSTALL_CMD="sudo pacman -S --noconfirm"
                    ;;
                alpine)
                    INSTALL_CMD="sudo apk add"
                    ;;
                *)
                    log_err "Unsupported Linux distribution: $ID"
                    exit 1
                    ;;
            esac
        else
            log_err "Cannot detect Linux distribution."
            exit 1
        fi
    else
        log_err "Unsupported Operating System."
        exit 1
    fi
}

# 3. 依赖检查与安装
install_dependencies() {
    for pkg in "${DEPENDENCIES[@]}"; do
        if ! command -v "$pkg" >/dev/null 2>&1; then
            log_info "Installing $pkg..."
            $INSTALL_CMD "$pkg"
        else
            log_info "$pkg is already installed."
        fi
    done
}

# 4. 配置默认 Shell
configure_shell() {
    local zsh_path
    zsh_path=$(command -v zsh)
    
    if [[ "$SHELL" != "$zsh_path" ]]; then
        log_warn "Changing default shell to zsh..."
        if ! chsh -s "$zsh_path"; then
            log_err "Failed to change shell. You may need to run 'chsh -s $(which zsh)' manually."
        else
            log_info "Shell changed successfully. Please log out and log back in later."
        fi
    else
        log_info "Default shell is already zsh."
    fi
}

# 5. 安装 Oh My Zsh
install_oh_my_zsh() {
    if [ -d "$OH_MY_ZSH_DIR" ]; then
        log_warn "Removing existing Oh My Zsh directory..."
        rm -rf "$OH_MY_ZSH_DIR"
    fi
    
    log_info "Installing Oh My Zsh..."
    # 使用 --unattended 避免安装后直接进入 zsh 导致脚本中断
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# 6. 安装 Starship
install_starship() {
    if ! command -v starship >/dev/null 2>&1; then
        log_info "Installing Starship..."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
    else
        log_info "Starship is already installed."
    fi
}

# 7. 配置 .zshrc
configure_zshrc() {
    log_info "Downloading custom .zshrc..."
    if ! wget -O "${HOME}/.zshrc" "$ZSHRC_URL"; then
        log_err "Failed to download .zshrc. Keeping the default one."
    fi
    
    # 创建历史记录目录（如果配置中有用到）
    mkdir -p "${HOME}/.cache/.zsh_history/"
}

# 8. 安装插件
install_plugins() {
    local plugins_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    
    local plugins=(
        "https://github.com/zsh-users/zsh-completions zsh-completions"
        "https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions"
        "https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting"
    )

    for entry in "${plugins[@]}"; do
        # 拆分 URL 和 目录名
        set -- $entry
        local url=$1
        local dir_name=$2
        local target_dir="$plugins_path/$dir_name"

        if [ -d "$target_dir" ]; then
            log_warn "Plugin $dir_name already exists. Updating..."
            git -C "$target_dir" pull
        else
            log_info "Cloning $dir_name..."
            git clone --depth 1 "$url" "$target_dir"
        fi
    done

    # 修复 compinit 警告
    rm -f "${HOME}/.zcompdump"
}

# 9. 主流程
main() {
    log_info "Starting Zsh Builder..."
    
    detect_os
    install_dependencies
    configure_shell
    install_oh_my_zsh
    install_starship
    configure_zshrc
    install_plugins
    
    log_info "Installation complete! Please restart your terminal or run 'zsh'."
}

# 执行主函数
main
