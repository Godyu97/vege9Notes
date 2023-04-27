```bash
echo -e "[boot]\nsystemd=true" | sudo tee -a /etc/wsl.conf
```

判断wsl是否已启用systemd，可通过以下命令查看：

```bash
ps --no-headers -o comm 1
```

### 查看已启用的systemd service

通过systemctl的list-units、list-unit-files命令，都可以很好的查看目前的systemd状态，命令如下：

```bash
systemctl list-units --type=service
systemctl list-unit-files --type=service --state=enabled
```