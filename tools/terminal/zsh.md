* apt install zsh
* sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
* win 失败 
  * git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  * cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

plugs:

1.   git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

   * rm -f ~/.zcompdump; compinit

2.   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

3.   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

     

