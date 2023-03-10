1. 位图Bitmaps 
   * bitmaps本身不是一种数据类型，实际上是string，实现位操作
   * 每个单元只能存储0/1，索引下标在bitmaps中叫做偏移量
   * 适合数据量很大时使用(1亿)，可节省内存空间
   * 命令
     * `setbit key offset value`设置位图key中偏移量offset位置的值value，offset从0开始
     * `getbit key offset`获取位图key中偏移量offset的值
     * `bitcount key [i j]`统计位图key中1的数量，可用i j 来取范围
     * `bitop and/or/not/xor destkey k1,k2...`对多个位图做and(交集)/or(并集)/not(非)/xor(异或)操作，将结果保存在destkey
2. HyperLogLog
   * 基数：集合中不重复元素的个数
   * hyperloglog用来做基数统计，优点是在元素数量或体积很大时，计算基数所需空间是固定的，redis中每个hyperloglog键12KB内存可计算2^64个元素的基数。
   * hyperloglog只会根据输入元素来计算基数，不会储存元素本身，不能返回输入的各个元素
   * 命令
     * `pfadd key v1 v2...`添加元素到HLL
     * `pfcount k1 k2 ...`计算HLL的基数，多个key为合并后HLL的基数
     * `pfmerge destkey k1 k2...`一个或多个HLL合并后保存在HLL destkey中
3. Geospatial
   * 地理信息；元素附带二维坐标，地图的经纬度，提供了经纬度设置，查询，范围查询，距离查询，经纬度hash等操作
   * 命令
     * `geoadd key lon1 lat1 member1 ...`
       * 两极无法直接添加；有效lon -180\~180，有效lat -85.05\~85.05；坐标超出范围时返回error
       * 不会再次添加已有数据
     * `geopos key m1 m2...`获取指定地区的坐标值
     * `geodist key m1 m2 [m/km/ft/mi]`获取两个位置之间的直线距离，默认单位m
     * `georadius key lon lat radius m/km/ft/mi`以给定的经纬度为中心，找出半径ra dius内的元素