#!/bin/bash

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

function relyInstall() {
    if isCmdExist wget; then
        echo "has installed wget"
    else
        echo "installing wget"
        apt install wget
    fi
}

relyInstall
rmOldDir
apt install zsh
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
