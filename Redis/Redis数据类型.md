1. key

   * `keys *`查看当前库所有key（通配符可用于匹配，如 keys uid* ）
   * `exists key`判断某个key是否存在
   * `type key`查看key类型
   * `del key`删除指定的key数据
   * `unlink key`非阻塞删除key数据，先从keyspace元数据中删除，后续异步操作真正删除
   * `expire key n`:为key设置过期时间n秒
   * `ttl key`查看剩余过期秒数，-1永不过期，-2已过期

2. 字符串String

   1. String是redis最基本的数据类型
   2. String是二进制安全的。可以包含任何数据，图片或json对象
   3. 数据结构：简单动态字符串SDS，最大512M；扩容方式：小于1M翻倍，超过1M每次扩容1M。
   4. 常用命令
      * `set key value [参数]`
        * EX seconds：以秒为单位设置过期时间
        * PX milliseconds：以毫秒为单位设置过期时间
        * EXAT timestamp：设置以秒为单位的UNIX时间戳所对应的时间为过期时间
        * PXAT milliseconds-timestamp：设置以毫秒为单位的UNIX时间戳所对应的时间为过期时间
        * NX：键不存在的时候设置键值
        * XX：键存在的时候设置键值
        * KEEPTTL：保留设置前指定键的生存时间
        * GET：返回指定键原本的值，若键不存在时返回nil
      * `mset`同时设置一个或多个k-v；`msetnx`所有k都不存在，同时设置一个或多个k-v
      * `setrange key i value`覆盖索引位置的值，i不能为-1
      * `get key`查询键值
      * `mget`同时获取一个或多个v
      * `getrange key i j`按索引取值，前包后包，0 -1为整个string
      * `getset key value`设置新值同时返回旧值
      * `append key v2`将给定的v2追加到原值末尾，key不存在则新增key且值是v2
      * `strlen key`获得值的长度，key不存在返回0
      * `incr/decr key`对key存储的数字自增/自减，key不存在新增值1/-1，如果key存在且不是数字error
      * `incrby/decrby key n`对key存储的数字增/减，n为步长，key不存在新增值n，如果key存在且不是数字error

3. 列表List

   1. 单键多值；值是字符串列表，按照插入顺序排序；可以插入一个元素到列表的头部或尾部；底层为双向链表，操作两端结点性能高，通过索引操作中间结点性能差
   2. 常用命令
      * `lpush/rpush key v1 v2 v3 ...`从左边(头插法)/右边(尾插法)插入一个或多个值
      * `lpop/rpop key`从左边/右边吐出一个值，值在键在，值空键亡
      * `rpoplpush k1 k2`从k1右边吐出一个值，插入到k2左边
      * `lrange key i j`索引获取元素，从左到右，前包后包，0 -1为整个list
      * `lindex key n`按索引获取元素,-1为最后一个
      * `llen key`获取list长度
      * `linsert key before/after v newv`在首个匹配到的v的左边/右边插入newv
      * `lrem key n v`从左边删除n个v
      * `lset key i v`按索引赋值，-1为最后一个
   3. 数据结构：快速链表(QuickList)，元素较少时使用连续内存ziplist，多个ziplist以链表形式组成quicklist，减少空间冗余

4. 集合Set

   1. set是string的无序集合，自动去重，底层为hash表，增删查改的复杂度O(1)。
   2. 常用命令
      * `sadd key v1 v2...`将一个或者多个member元素加入到集合key中，已存在的member被忽略
      * `smembers key`取出集合key所有的值
      * `sismember key value`判断集合key是否含有value值，返回值1/0
      * `scard key` 返回集合key的元素个数
      * `srem key v1 v2...`删除集合key中的某些元素
      * `spop key`随机从集合中吐出一个元素，从集合中删除，值在键在，值空键亡
      * `srandmember key n`随机从集合中获取n个值，不会从集合中删除这些元素
      * `smove k1 k2 v`把集合k1中的v移动到集合k2，返回值1/0
      * `sinter/sunion/sdiff k1 k2`返回两个集合的交集/并集/差集
   3. 数据结构：字典dict，hash表实现

5. 哈希Hash

   1. field-value的集合，哈希图。适合用于存储对象。
   2. 常用命令
      * `hset key field value`向哈希图key中增加键值对field-value
      * `hmset key f1 v1 f2 v2...`批量设置哈系统key的值
      * `hget key field`从哈希图key中取出field映射的value
      * `hexists key field`查看哈希图key中，键field是否存在
      * `hkeys key`获取key中所有的field；`hvals key`获取key中所有的value
      * `hincrby key field n`对key中field对应的value增/减 n，只对数字字符串生效，返回修改后的数据
      * `hsetnx key field value`当key中filed不存在时，增加filed-value对，返回值1/0
   3. 数据结构：field-value长度较短且个数较少，使用ziplist，否则使用hashtable

6. 有序集合Zset

   1. 没有重复元素的string集合，每个成员关联一个评分(score)，评分由低到高排序集合中的元素；集合的元素是唯一的，但评分可以相同；可以很快的根据评分或次序获取一个范围内的元素；访问集合内的元素快
   2. 常用命令
      * `zadd key s1 v1 s2 v2...`将一个或多个元素及其评分加入到有序集合key中
      * `zrange key i j [WITHSCORES]`返回有序集合key中下标i j之间的元素，0 -1为整个zset，j可超出最大下标，WITHSCORES同时返回元素对应的评分
      * `zrangebyscore key min max [WITHSCORES]`返回有序集合key中评分min max之间的元素，增序排列
      * `zrangebylex key min max`此指令适用于分数相同的有序集合中 ，根据v特征取值
      * `zrevrangebyscore key max min [WITHSCORES]`返回有序集合key中评分max min之间的元素，降序排列
      * `zincrby key n v`为元素v的评分加n
      * `zrem key v`删除有序集合key中值为v的元素
      * `zcount key min max`统计评分区间内的元素个数
      * `zrank key v`返回v在集合中的排名
      * 在min max前可用的特殊符号 ：[包含  (不包含  +正无穷  -负无穷 
   3. 数据结构：底层使用两个数据结构
      * hash：关联元素value和评分score，保障元素value的唯一性，可以通过元素value找到对应的score
      * 跳跃表：给元素value排序，根据score的范围取元素列表 [面试官：讲讲Redis跳跃表 - 掘金 (juejin.cn)](https://juejin.cn/post/6998323950539243533)

   