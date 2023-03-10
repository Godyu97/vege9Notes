```
#更新系统
apt update -y
apt install -y curl
apt install -y socat
yum install -y curl  #CentOS
sudo apt install -y curl  #Ubuntu/Debian

#Trojan一键代码
bash <(curl -sSL "https://raw.githubusercontent.com/veip007/hj/main/trojan-go.sh") 

#放行端口
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
-------------------------------------------------------------
```