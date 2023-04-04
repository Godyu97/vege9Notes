1. 设置用户签名：签名的作用是区分不同操作者身份，用户的签名信息在每一个版本的提交信息中能够看到。

   * git首次安装必须设置一下用户签名，否则无法提交代码。
   * 用户签名和代码托管中心(github)的账号没有任何关系。

   * ```git config --global user.name xxx```

   * ```git config --global user.email xxx@mail.com```

2. 初始化本地库

   * ```git init```
   * 生成隐藏的文件夹```.git/```

3. 查看本地库状态：```git status```

4. 暂存区
   * 添加至暂存区：```git add file```
   * 从暂存区移除：```git rm --cached file```（不会影响工作区的文件）

5. 本地库
   * 提交本地库：```git commit -m "log" file```
   * 提交后生成当前提交的版本号（短7，长40）
   * 提交后暂存区清空

6. log：```git reflog``` / ```git log```

7. 切换版本：```git reset --hard 版本号```
   * Git 切换版本，实际是底层移动HEAD指针。

8. 分支操作
   * 分支：从开发主线上分离开来，本质上仅仅是指向提交对象的可变指针。
   * 优点：并行推进多个功能开发；各个分支互不影响
   * 创建分支：```git branch 分支名```
   * 查看分支：```git branch -v```
   * 切换分支：```git checkout 分支名```
   * 合并分支：```git merge 分支名```（把指定的分支合并到当前分支上）
   * 冲突：两个分支文件在同一位置有两套不同的修改(行)，git无法判断使用哪一个，必须人为决定新代码内容。（分支状态MERGING，git status查看冲突）
     * <<<<<<< HEAD  当前分支代码
     * \=\=\=\=\=\=\=
     * \>\>\>\>\>\>\>master  合并过来的冲突代码
     * 解决冲突后git commit不能带文件名

9. 远程仓库
   * 克隆：```git clone address```（拉取代码，初始化本地库，创建别名）
   * 别名：```git remote -v```(查看别名)        ```git remote add 别名 address ```(创建别名)
   * 推送：```git push 别名/地址 分支名```
   * 拉取：```git pull 别名/地址 分支名```

10. 储存https帐号密码：

    ```bash
    git config --global credential.helper store
    git config credential.helper store
    ```
