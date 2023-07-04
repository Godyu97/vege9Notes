# pro git v2 notes

[TOC]

## 版本控制

1. 版本控制：一种记录一个或若干文件**内容变化**，以便将来查阅**特定版本**修订情况的系统。你可以对任何类型的文件进行版本控制。
2. 发展
	* 本地版本控制系统 RCS
	* 集中式版本控制系统 SVN
	* 分布式版本控制系统 GIT

## git 基础概念

1. 特点

	* git对待数据是一个快照流，直接记录快照，而非差异比较。Blob 对象(即一段二进制数据)，每次提交的文件的修改都会生成新的object，每次commit都会对当前commit生成文件索引的快照。
	* 几乎所有的操作都是本地执行
	* 数据完整性
	* git一般只添加数据

2. 三种状态

  * 未追踪 untracked：在git仓库中没有快照，不属于git管理的文件，一般为新建的文件
  * 已追踪
  	* 已修改 modified
  	* 已暂存 staged：已暂存表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中。
  	* 已提交 committed

3. 三个工作区域

	* 工作区：磁盘上的目录文件，当前版本的内容。从 Git 仓库的压缩数据库中提取出来的文件，放在磁盘上供你使用或修改。
	* 暂存区：保存了下次将提交的文件列表索引
	* Git仓库(本地库/远程库)：`.git`目录，保存项目的元数据和对象数据库的地方。 这是 Git 中最重要的部分，克隆仓库时，拷贝的就是这里的数据。

4. 基本的 Git 工作流程如下：

	* 在工作目录中修改文件。

	* 暂存文件，将文件的快照放入暂存区域。

	* 提交更新，找到暂存区域的文件，将快照永久性存储到 Git 仓库目录。

5. 三级配置文件

	* Git 自带一个 `git config` 的工具来帮助设置控制 Git 外观和行为的配置变量。

		1. `/etc/gitconfig` 文件: 包含系统上每一个用户及他们仓库的通用配置。 如果使用带有 `--system` 选项的 `git config` 时，它会从此文件读写配置变量。

		2. `~/.gitconfig` 或 `~/.config/git/config` 文件：只针对当前用户。 可以传递 `--global` 选项让 Git 读写此文件。

		3. 当前使用仓库的 Git 目录中的 `config` 文件（就是 `.git/config`）：针对该仓库。

	* 每一个级别覆盖上一级别的相同配置变量，所以 `.git/config` 的配置变量会覆盖 `/etc/gitconfig` 中的配置变量。最后生效的配置是它们的集合

	* 常用配置

		* ```bash
			git config --global user.name "vege9"
			git config --global user.email lhy429581492@gmail.com
			```

		* ```bash
			git config --list  //命令来列出所有 Git 当时能找到的配置
			```

6. help

	* ```bash
		git help <verb>
		git <verb> --help
		```

## git 基础操作

1. 获取git仓库
  * 在现有目录中初始化仓库：`git init`
  * 从一个服务器克隆一个现有的 Git 仓库：`git clone [url] [defname]`
  	* 在当前目录创建项目demo文件夹
  	* 从远程仓库克隆所有数据放入 ./demo/.git 文件夹
  	* 从 .git 中读取当前版本的文件内容到 ./demo
  	* defname 一般缺省为默认值，远程库的目录名

2. 检查当前文件状态：`git status`
  * 显示索引文件和当前HEAD提交有差异的路径(已暂存)；工作树和索引文件有差异的路径(已修改)；工作树中不被Git追踪的路径(未跟踪)

3. 忽略文件：无需纳入git管理的文件类型列表，在项目目录编写`.gitignore`文件。#注释

	* ```
		# .idea config dir
		.idea/
		
		# log file
		*.log
		```

4. `git add [file]`：跟踪新文件、暂存已修改文件。总结来说就是将文件obj放到暂存区

5. `git commit`：提交更新，提交的是放在暂存区域的快照。

	* `git commit -m [docs:msg]`
	* `git commit -a -m [docs:msg]`：自动将已修改的文件 git add，并 git commit

6. `git rm`：移除文件

	* `git rm [file]`：删除工作区文件，并将此次删除放入暂存区，删除的文件要求未修改
	* `git rm -f [file]`：删除工作区和暂存区文件，并将此次删除放入暂存区，删除的文件要求已修改
	* `git rm --cache [file]`：删除暂存区快照但**保留工作区文件**，并将此次删除放入暂存区

7. `git mv`：移动文件，改名

	* 等价于

		```bash
		mv README.md README
		git rm README.md
		git add README
		```

		
