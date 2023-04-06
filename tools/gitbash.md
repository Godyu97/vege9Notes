* vim bash.bashrc

```bash

# 设置windows terminal 打开bash时支持显示中文目录
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"
# 让ls和dir命令显示中文和颜色 
alias ls='ls --show-control-chars --color' 
alias dir='dir -N --color' 
# 设置为中文环境，使提示成为中文 
export LANG="zh_CN" 
# 输出为中文编码 
export OUTPUT_CHARSET="utf-8"
# 设置 windows terminal打开bash时支持ll命令
alias ll='ls -l'

# Launch Zsh
if [ -t 1 ]; then
exec zsh
fi
```

