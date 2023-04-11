#!/bin/bash

# 根据系统获取安装命令
installCmd=""
function OSInit() {
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "Detected macOS"
        # 在此处执行macOS上的安装命令
        installCmd="brew install"
    else
        echo "Detected Linux"
        # 在此处执行Linux上的安装命令
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
                echo "Detected Debian-based distribution"
                # 在此处执行Debian上的安装命令
                installCmd="apt install"
            elif [ "$ID" = "centos" ] || [ "$ID_LIKE" = "rhel fedora" ]; then
                echo "Detected Red Hat-based distribution"
                # 在此处执行Red Hat上的安装命令
                installCmd="yum install"
            else
                echo "Unsupported distribution: $NAME"
                exit 1
            fi
        fi
    fi
}

# rm old "~/.oh-my-zsh/"
ohmyzshDir="$HOME/.oh-my-zsh/"
function rmOldDir() {
    if [ -d "$ohmyzshDir" ]; then
        echo "has oh-my-zsh DELETEING"
        rm -rf "$ohmyzshDir"
    else
        echo "installing oh-my-zsh"
    fi
}

# judge cmd exist
function isCmdExist() {
    local cmd="$1"
    if [ -z "$cmd" ]; then
        echo "Usage isCmdExist yourCmd"
        return 1
    fi

    which "$cmd" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    fi

    return 2
}

# install rely cmd
function relyInstall() {
    local cmd="$1"
    if isCmdExist "$cmd"; then
        echo "has installed $cmd"
    else
        echo "installing $cmd"
        $installCmd install "$cmd"
    fi
}

# rely cmd
relyArr=(
    wget
    curl
    git
)
# main process
OSInit
for item in "${relyArr[@]}"; do
    relyInstall "$item"
done
rmOldDir
$installCmd install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
wait
echo "Child script has completed."
curl -sS https://starship.rs/install.sh | sh
wget -O ~/.zshrc https://raw.githubusercontent.com/Godyu97/vege9Notes/master/tools/conf/.zshrc

pluginsPath=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins
git clone https://github.com/zsh-users/zsh-completions "$pluginsPath/zsh-completions"
rm -f ~/.zcompdump
compinit
git clone https://github.com/zsh-users/zsh-autosuggestions "$pluginsPath/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$pluginsPath/zsh-syntax-highlighting"
source ~/.zshrc

# exec commond for install zsh starship and .zshrc
# wget -O ~/zsh_builder.sh https://raw.githubusercontent.com/Godyu97/vege9Notes/master/tools/zsh_builder.sh
# sudo source zsh_builder.sh
