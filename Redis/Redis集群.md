1. 针对问题：
   * 容量不够，水平扩容
   * 分摊并发写操作
2. 无中心化集群：任何结点可以作为连接入口，节点之间可以互相访问
3. 搭建：
   1. 修改配置文件，开启集群功能，启动多个redis服务；redis集群至少3个master结点
   2. redis-cli --cluster create --cluster-replicas x ip:port...  ；x为每个master的slave数量
   3. 尽量保证每个master运行在不同的ip上，每个slave和master不在同一ip上
4. 命令
   * `cluster nodes`：查看集群结点信息
   * `cluster keyslot key`：计算key插槽值
   * `cluster countkeysinslot n`：计算插槽n有几个key，只能查看当前redis结点的插槽
   * `cluster getkeysinslot slot n`：返回n个slot插槽中的key
5. slot：一个redis集群有16384个插槽，数据库中每个key都使用CRC16(key)%16384来计算属于哪个插槽，存放在哪个结点
6. 不在一个slot下的key，不能用mget，mset等多键操作，通过key{group}定义组的概念，对group计算slot，放入同一插槽
7. 故障：cluster-require-full-coverage yse/no 某段插槽主从都宕机，整个集群不可用/插槽段数据不可用
8. 缺点：
   * 不支持多键操作，多键事务，lua脚本