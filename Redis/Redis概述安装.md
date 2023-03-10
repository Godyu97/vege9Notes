1. Redis概述
   1. 开源的k-v存储系统
   2. 支持存储的数据类型：string，list，set，zset，hash
   3. 支持push/pop，add/remove，交集并集差集等操作，且是原子性操作
   4. 支持不同方式的排序
   5. 数据缓存在mem中
   6. 周期性把更新的数据写入磁盘或把修改操作写入记录文件
   7. 实现了master-slave主从同步
2. Redis安装
   1. 目前只支持linux
   2. Port：6379
   2. 停止redis服务：`redis-cli shutdown`；进入redis-cli终端执行`shutdown`；kill redis-server进程
3. 相关知识
   1. 默认16个数据库，0-15，初始默认使用0号数据库。`select [dbid]`切换数据库。所有数据库统一密码管理。
   2. `auth pwd`：密码认证
   3. `dbsize`查看当前数据库key数量
   4. `flushdb`清空当前库。`flushall`清空全部库。
   5. 单线程+多路IO复用
   6. redis单命令的原子性主要得益于redis的单线程
4. 配置文件详解 [Redis配置文件详解 - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1947475)