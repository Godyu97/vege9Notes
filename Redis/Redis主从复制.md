1. 主从复制：主机数据更新后根据策略和配置，自动同步到备机的master/slave机制，master以写为主，slave以读为主

2. 读写分离，性能扩展；容灾快速恢复

3. 命令：

   * `info replication`：打印主从复制的相关信息

   * `slaveof ip port`：使当前redis服务成为目标master的slave；也可以修改conf文件配置主从配置
   * `slaveof no one`：slave可升级成新master

4. 原理：

   * slave连接master，发送sync命令
   * master接到sync命令，进行rdb持久化，将rdb文件发送给slave，进行全量同步
   * 后续master的写命令，依次发给slave，增量同步
   * 重新连接master，自动执行一次全量同步

5. 注意：

   * slave连接master，会全量同步master数据；变更master，会清空之前的数据重新建立拷贝
   * slave只读
   * slave shutdown重启后，slaveof命令配置的主从配置无效，配置文件中配置有效
   * master shutdown后，slave不会自动成为新的master(需要执行slaveof no one)。master重启后，slave重新连接
   * 主从关系可以多层继承，风险是某个中间slave宕机，后续的slave无法继续备份

6. 哨兵模式：后台监控master是否故障，并根据投票自动将slave升级为master

   * sentinel.conf：`sentinel monitor mymaster ip port n`；mymaster主机名称，ip port主机服务地址，n至少有多少个哨兵同意迁移的数量
   * `redis-sentinel sentinel.conf `启动哨兵，可以启动多个哨兵进程
   * replica-priority，值越小优先级越高。redis.conf中默认100
   * 原master宕机重启后会变为slave
   * 投票条件：
     1. replica-priority优先级最高，值越小优先级越高
     2. 偏移量大，与原master数据同步最全的
     3. runid最小，redis服务启动后会随机生成一个40位的runid
   
   