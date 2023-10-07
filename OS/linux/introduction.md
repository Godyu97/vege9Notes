[TOC]

### linux 安装

* 官网：[Linux.org](https://www.linux.org/)
* 磁盘分区
	* boot：1g，引导分区。文件系统：ext4
	* swap：2g、同memory大小。文件系统：swap
	* 根分区(/)：文件目录。文件系统：ext4
* KDUMP：内存崩溃转储机制，占用一部分memory。生产环境使用
* /selinux：security enhanced linux，一种安全子系统，控制程序只能访问特定文件，三种工作模式
* 网络连接
	* 桥接：同一网段，虚拟机可以直接和外部通信
	* NAT：网络地址转换
	* 主机：不和外部网络通信

### linux 目录结构

* linux文件系统：级层式树状目录结构。**linux一切皆文件**
* /：根目录
* /bin、/usr/bin、/usr/local/bin：binary 可执行程序存放的目录
	* /sbin、/usr/sbin、/usr/local/sbin：super bin的意思，存放超级管理员使用的系统管理程序
* /home：存放普通用户的主目录，每个用户都在/home下有一个自己的目录，默认为用户账号名 `/home/vege9`
* /root：超级管理员主目录
* /lib：系统开机所需要最基本的动态链接共享库
* /etc：系统管理所需要的配置文件和子目录
* /usr：用户安装的应用程序和文件
* /tmp：存放一些临时文件
* /dev：设备管理，linux把计算机硬件映射成文件来管理；cpu等
* /media：自动识别的一些设备，u盘、光驱等
* /mnt：外部存储挂载
* /opt：主机额外安装软件包存放的目录
* /usr/local：主机额外安装软件，以源码方式安装的程序存放目录
* /var：存放不断变化扩充、经常被修改的文件的目录，如log
* /boot：引导启动linux使用的核心文件，连接文件，镜像文件
* /proc：虚拟的目录，系统内存的映射，访问这个目录来获取系统信息
* /srv：service，存放一些服务启动后需要提取的数据
* /sys：安装了文件系统sysfs
* /lost+found：一般为空目录，系统非法关机后存放一些文件

