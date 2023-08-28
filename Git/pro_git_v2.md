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
  * 从一个服务器克隆一个现有的 Git 仓库：`git clone [url] <defname>`
	* 在当前目录创建项目demo文件夹
	* 从远程仓库克隆所有数据放入 ./demo/.git 文件夹
	* 从 .git 中读取当前版本的文件内容到 ./demo
	* defname 一般缺省为默认值，远程库的目录名


2. 检查当前文件状态：`git status`，比较工作区，暂存区，本地库的文件
  * 显示索引文件和当前HEAD提交有差异的路径(已暂存)；工作树和索引文件有差异的路径(已修改)；工作树中不被Git追踪的路径(未跟踪)

3. 差异比较：`git diff`，工作区和暂存区快照之间的差异，尚未暂存的改动

	* `git diff --staged`：暂存区和最后一次提交的差异

4. 忽略文件：无需纳入git管理的文件类型列表，在项目目录编写`.gitignore`文件。#注释

	* ```
		# .idea config dir
		.idea/
		
		# log file
		*.log
		```

5. `git add [file]`：跟踪新文件、暂存已修改文件。总结来说就是将文件obj放到暂存区

6. `git commit`：提交更新，提交的是放在暂存区域的快照。

  * `git commit -m [comment]`
  * `git commit -a -m [comment]`：自动将已修改的文件 git add，并 git commit
  * ` git commit --amend`：重新提交，代替上一次提交结果，最终只有一次commit
  * 在完成可描述的子模块、自认为可能出现问题的地方勤于commit

6. `git rm`：移除文件

  * `git rm [file]`：删除工作区文件、暂存区快照，并将此次删除放入暂存区，删除的文件要求未修改(已提交)
  * `git rm -f [file]`：删除工作区文件、暂存区快照，并将此次删除放入暂存区
  * `git rm --cache [file]`：删除暂存区快照但**保留工作区文件**，并将此次删除放入暂存区

7. `git mv`：移动文件，改名

  * 等价于

  	```bash
  	mv f1 f2
  	git rm f1
  	git add f2
  	```

8. `git log`：查看提交历史
  * `git log -p`：显示每次提交的内容差异
  * `git log --stat`：简略的统计信息

9. `git reset [--mixed(默认) | --hard | soft] [HEAD] <file>`：重置当前HEAD版本号到指定状态，版本号可以为HEAD(当前已提交committed)，HEAD^(上个版本)，commit版本号

  * --soft：撤回到指定版本保留暂存区修改(移动HEAD)
  * --mixed：撤回到指定版本清空暂存区修改，保留工作区(更新存储库)，取消暂存文件的效果
  * --hard：撤回到指定版本并清空工作区、暂存区所有修改(更新工作区)

10. `git clean`：git clean 一般在git reset --hard之后使用:

	* git clean 影响没有被 track 过的文件（清除未被 add 或被 commit 的本地修改）；git reset 影响被 track 过的文件 （回退到上一个 commit）

	* ```
		-n：列出将要被删除的文件
		
		-d ：删除未被添加到 git 路径中的文件，将 .gitignore 标记的文件全部删除
		
		-x ：删除没有被 track 的文件，无论是否是.gitignore 标记的文件
		
		-f ：强制删除没有被 track 的文件，但不删除.gitignore 标记的文件
		```

## 远程仓库

1. 查看远程库：`git remote -v`，origin url

	* `git remote`：origin
	* `git remote show [origin_name]`

2. 添加远程库：`git remote add [origin_name] [url]`

3. 远程库移除、重命名：`git remote rm [origin_name]`、`git remote rename [o_name] [n_name]`

4. 拉取远程库：`git fetch [origin_name]`，不会自动合并

	* `git merge [origin_name/branch]`：手动合并origin_name/branch到当前分支

	* `git pull [origin_name]`：拉取并自动合并

5. 推送到远程库：`git push [origin_name] [branch_name]`，必须先拉取并将其合并后才能推送

## 标签Tag

1. Git 可以给历史中的某一个提交打上标签，以示重要
2. 列出标签：`git tag -l "pattern"`
3. 查看标签：`git show [tag_name]`
4. 创建标签：`git tag -a [tag_name] <c_id> -m [comment]`//可以给历史commit打标签；轻量标签：`git tag [tag_name]`
5. 删除标签：`git tag -d [tag_name]`
6. 推送远程标签：`git push [origin_name] --tags`
7. 删除远程标签：`git push origin -d [tagname]`

## 分支模型

1. 分支：本质上仅仅是指向提交对象的可变指针，可以理解为平行的独立开发线，用于多个任务的同时进行

2. 默认分支：master，git init 默认创建

3. 分支创建：`git branch [b_name] `

4. 分支切换：`git checkout [b_name]`；-b 参数新建并切换；-d 参数删除分支

5. 分支合并：`git merge [b_name]`，把b_name分支的内容合并到当前分支，保留全部的commit，分叉的commit记录，非破坏性操作

6. 合并冲突：在两个不同的分支中，对同一个文件的同一个部分进行了不同的修改，Git 就没法干净的合并它们。即，产生了冲突

  * 解决冲突：冲突后文件像下面这样，被======分割的两部分为两分支在该位置的内容，删除掉多余的符号，然后将src改为你期望的内容，最后做一次commit，就成功的解决了冲突

    ```
    <<<<<<< HEAD:index.html
    src1
    =======
    src2
    >>>>>>> b_name:index.html
    ```

  * 中断合并：`git merge --abort`，恢复到你运行合并前的状态

7. 分支列表：`git branch`；显示各分支最后一次commit：`git branch -v`

8. 变基：`git rebase [b_name]`：合并分支，并将基地移动到目标的顶端，整合目标分支的commit，线性commit记录

	* 黄金法则：永远不要在**公共**分支上使用它

## 传输协议

* 本地协议
* 智能http协议
* 哑http协议
* ssh协议
* git协议

## 凭证存储

- 默认所有都不缓存。 每一次连接都会询问你的用户名和密码。
	- ``cache'' 模式会将凭证存放在内存中一段时间。 密码永远不会被存储在磁盘中，并且在15分钟后从内存中清除。
	- ``store'' 模式会将凭证用明文的形式存放在磁盘中，并且永不过期。 这意味着除非你修改了你在 Git 服务器上的密码，否则你永远不需要再次输入你的凭证信息。 这种方式的缺点是你的密码是用明文的方式存放在你的 home 目录下。
	- `git config --global credential.helper [cache | store]`
- ssl 凭证：将.ssh公钥上传到远程仓库，可以进行无密码操作
