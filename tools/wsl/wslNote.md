1. wsl2 Ubuntu占位程序错误：

   ````bash
   netsh winsock reset
   ````

2. wsl2 系统迁移到其他盘符


* 软连接方式：通过软连接的方式修改VHDX 文件的存放磁盘，达到缓解C盘存储压力的问题
	```bash
	$newLocation = "E:\WSL\Ubuntu-WSL2\"
	cd ~\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState
	wsl --shutdown
	
	Optimize-VHD .\ext4.vhdx -Mode Full
	mkdir $newLocation -Force
	mv ext4.vhdx $newLocation
	cd ..
	rm LocalState
	New-Item -ItemType SymbolicLink -Path "LocalState" -Target $newLocation
	```

* 导出导入方式

	* 查看系统信息 ```wsl -l -v```

	* 关闭wsl  ```wsl --shutdown```

	* 导出系统 ```wsl --export <DistroName> <PathToTarArchive>```  eg:wsl --export Ubuntu-20.04  E:\WSL\Ubuntu20.04-WSL2\ubuntu.tar
	* 删除系统 ```wsl --unregister <DistroName>```
	* 导入系统 指定新的位置 ```wsl --import <DistroName> <PathToDistroNewDirectory> <PathToTarArchive>```wsl --import Ubuntu-20.04 E:\WSL\Ubuntu-WSL2 E:\WSL\Ubuntu20.04-WSL2\ubuntu.tar
	* 设置默认用户 ```ubuntu2004.exe config --default-user root```



