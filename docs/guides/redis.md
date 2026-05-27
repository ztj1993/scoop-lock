# Redis v7.0.11 使用指南

## 简介

Redis（Remote Dictionary Server）是一个开源的、高性能的内存数据结构存储系统，可以用作数据库、缓存和消息代理。版本 v7.0.11 提供了最新的功能和性能优化，是现代应用程序中不可或缺的组件。

Redis 由 Salvatore Sanfilippo 创建，现在由 Redis Ltd. 维护。它使用 ANSI C 编写，支持多种操作系统，包括 Linux、macOS 和 Windows（通过第三方移植）。

该系统支持丰富的数据结构，包括字符串、哈希、列表、集合、有序集合、位图、超日志、地理空间索引等。这些数据结构使得 Redis 能够解决各种复杂的问题。

Redis 以其极高的性能而闻名，单实例可以处理每秒数十万次的读写操作。它采用内存存储，数据访问延迟极低，非常适合需要快速响应的应用场景。

本指南将详细介绍 Redis 的安装、配置和使用方法，帮助开发者充分利用这个强大的内存数据存储系统。

## 主要功能

### 数据结构支持

Redis 提供了丰富的数据结构，每种数据结构都有专门的操作命令。字符串是最基本的数据类型，支持设置、获取、追加、自增等操作。

哈希数据结构适合存储对象，支持字段级别的操作。可以方便地获取、设置、删除对象的属性，而无需获取整个对象。

列表数据结构支持在两端添加和弹出元素，适合实现队列和栈。支持阻塞操作，可以实现生产者-消费者模式。

集合数据结构存储无序的唯一元素，支持交集、并集、差集等集合运算。适合实现标签、共同好友等功能。

有序集合在集合的基础上为每个元素关联一个分数，支持按分数范围查询。适合实现排行榜、优先级队列等功能。

### 持久化机制

Redis 提供了两种持久化机制：RDB（Redis Database）和 AOF（Append Only File）。RDB 通过定期将内存中的数据快照保存到磁盘来实现持久化。

AOF 通过记录每个写操作来实现持久化，可以提供更好的数据安全性。支持多种同步策略，包括每次写入、每秒同步和不主动同步。

Redis 4.0 引入了混合持久化，结合了 RDB 和 AOF 的优点。在 AOF 重写时，先以 RDB 格式保存当前数据，然后以 AOF 格式记录增量修改。

支持数据备份和恢复，可以通过 BGSAVE 命令创建快照，通过复制快照文件来备份数据。

### 高可用性

Redis 提供了主从复制功能，可以将数据从主节点复制到一个或多个从节点。从节点可以处理读请求，实现读写分离。

Redis Sentinel 提供了高可用性解决方案，可以监控主从节点的状态，在主节点故障时自动进行故障转移。

Redis Cluster 提供了分布式解决方案，支持数据分片和自动故障转移。数据分布在多个节点上，可以水平扩展存储容量和处理能力。

支持客户端分片，应用程序可以在客户端实现数据分片逻辑，将数据分布到多个 Redis 实例。

### 发布/订阅

Redis 提供了发布/订阅消息传递模式，支持频道和模式订阅。发布者可以将消息发送到频道，订阅者可以接收频道上的消息。

支持模式匹配订阅，可以订阅匹配特定模式的频道。这使得可以实现灵活的消息路由。

提供了键空间通知功能，可以监控键的创建、删除、过期等事件。适合实现缓存失效通知、实时监控等功能。

### 事务支持

Redis 提供了事务功能，可以将多个命令打包执行。事务中的命令会按顺序执行，不会被其他客户端的命令打断。

支持乐观锁机制，可以通过 WATCH 命令监视键，在事务执行前检查键是否被修改。

提供了 Lua 脚本支持，可以在服务器端执行复杂的逻辑。Lua 脚本可以访问 Redis 的所有数据结构和命令，提供原子性执行。

### 性能优化

Redis 采用单线程模型，避免了多线程的上下文切换和锁竞争问题。配合 I/O 多路复用技术，可以高效处理大量并发连接。

支持管道技术，可以批量发送多个命令，减少网络往返时间。特别适合需要执行大量命令的场景。

提供了内存优化功能，包括数据压缩、共享对象池等。可以有效减少内存使用，提高系统性能。

支持 Lua 脚本缓存，可以将常用的脚本缓存到服务器端，减少脚本传输和编译的开销。

### 地理空间支持

Redis 提供了地理空间索引功能，支持存储和查询地理位置信息。可以计算两点之间的距离、查找指定范围内的地点等。

支持多种地理空间操作，包括添加位置、删除位置、计算距离、范围查询、附近查询等。

适合实现附近的人、位置服务、地理围栏等功能。

### 流数据处理

Redis 5.0 引入了流数据结构，支持消息队列和事件溯源。流数据结构支持消费者组、消息确认、消息回溯等功能。

提供了丰富的流操作命令，包括添加消息、读取消息、确认消息、删除消息等。支持阻塞读取，可以实现实时消息处理。

适合实现事件驱动架构、实时数据处理、消息队列等功能。

## 常用命令/操作

### 安装和启动

通过 Scoop 安装 Redis：
```bash
scoop install redis
```

启动 Redis 服务器：
```bash
redis-server.exe
```

启动 Redis 客户端：
```bash
redis-cli.exe
```

查看 Redis 版本：
```bash
redis-server.exe --version
```

### 基本操作

**字符串操作**：
```bash
# 设置键值
SET mykey "Hello"

# 获取值
GET mykey

# 设置带过期时间的键值
SETEX mykey 60 "Hello"

# 自增操作
INCR counter

# 批量设置
MSET key1 "value1" key2 "value2"

# 批量获取
MGET key1 key2
```

**哈希操作**：
```bash
# 设置哈希字段
HSET user:1 name "John"
HSET user:1 age 30

# 获取哈希字段
HGET user:1 name

# 获取所有字段
HGETALL user:1

# 删除字段
HDEL user:1 age

# 检查字段是否存在
HEXISTS user:1 name
```

**列表操作**：
```bash
# 左推入
LPUSH mylist "world"
LPUSH mylist "hello"

# 右推入
RPUSH mylist "!"

# 弹出元素
LPOP mylist
RPOP mylist

# 获取列表范围
LRANGE mylist 0 -1

# 获取列表长度
LLEN mylist
```

**集合操作**：
```bash
# 添加元素
SADD myset "Hello"
SADD myset "World"

# 获取所有元素
SMEMBERS myset

# 检查元素是否存在
SISMEMBER myset "Hello"

# 集合运算
SINTER set1 set2
SUNION set1 set2
SDIFF set1 set2
```

**有序集合操作**：
```bash
# 添加元素
ZADD leaderboard 100 "Alice"
ZADD leaderboard 200 "Bob"

# 获取排名
ZRANK leaderboard "Alice"

# 获取分数
ZSCORE leaderboard "Alice"

# 范围查询
ZRANGE leaderboard 0 -1 WITHSCORES

# 按分数范围查询
ZRANGEBYSCORE leaderboard 100 200
```

### 键管理

**键操作**：
```bash
# 检查键是否存在
EXISTS mykey

# 删除键
DEL mykey

# 设置过期时间
EXPIRE mykey 60

# 查看剩余时间
TTL mykey

# 重命名键
RENAME mykey newkey

# 查看键类型
TYPE mykey

# 查找键
KEYS pattern
SCAN cursor MATCH pattern
```

### 事务操作

**基本事务**：
```bash
# 开始事务
MULTI

# 执行命令
SET key1 "value1"
SET key2 "value2"

# 执行事务
EXEC
```

**乐观锁**：
```bash
# 监视键
WATCH mykey

# 开始事务
MULTI

# 执行命令
SET mykey "newvalue"

# 执行事务
EXEC
```

### 发布/订阅

**订阅频道**：
```bash
SUBSCRIBE channel1
```

**发布消息**：
```bash
PUBLISH channel1 "Hello World"
```

**模式订阅**：
```bash
PSUBSCRIBE channel*
```

### 服务器管理

**查看服务器信息**：
```bash
INFO
INFO memory
INFO clients
INFO stats
```

**查看配置**：
```bash
CONFIG GET *
CONFIG GET maxmemory
```

**修改配置**：
```bash
CONFIG SET maxmemory 256mb
```

**持久化操作**：
```bash
# 后台保存
BGSAVE

# 同步保存
SAVE

# 后台重写 AOF
BGREWRITEAOF
```

**客户端管理**：
```bash
# 查看客户端列表
CLIENT LIST

# 关闭客户端
CLIENT KILL ip:port
```

### 性能监控

**慢查询日志**：
```bash
# 获取慢查询日志
SLOWLOG GET 10

# 获取慢查询日志长度
SLOWLOG LEN

# 清空慢查询日志
SLOWLOG RESET
```

**实时监控**：
```bash
# 监控命令
MONITOR

# 查看内存使用
MEMORY USAGE key
MEMORY DOCTOR
```

## 常见问题

### 内存问题

**问题描述**：Redis 使用过多内存或内存不足。

**解决方案**：
1. 设置最大内存限制
2. 配置内存淘汰策略
3. 监控内存使用情况
4. 优化数据结构

**内存配置**：
```bash
# 设置最大内存
CONFIG SET maxmemory 256mb

# 设置淘汰策略
CONFIG SET maxmemory-policy allkeys-lru
```

### 持久化问题

**问题描述**：数据丢失或持久化失败。

**解决方案**：
1. 检查持久化配置
2. 验证磁盘空间
3. 监控持久化进程
4. 调整持久化策略

**持久化配置**：
```bash
# 启用 AOF
CONFIG SET appendonly yes

# 设置 AOF 同步策略
CONFIG SET appendfsync everysec
```

### 性能问题

**问题描述**：Redis 响应缓慢或吞吐量低。

**解决方案**：
1. 使用管道技术
2. 优化数据结构
3. 避免大键操作
4. 监控慢查询

**性能优化**：
```bash
# 使用管道
redis-cli --pipe

# 监控慢查询
SLOWLOG GET 10
```

### 连接问题

**问题描述**：客户端无法连接到 Redis。

**解决方案**：
1. 检查 Redis 服务状态
2. 验证端口配置
3. 检查防火墙设置
4. 验证密码配置

**连接配置**：
```bash
# 绑定地址
CONFIG SET bind 0.0.0.0

# 设置密码
CONFIG SET requirepass "mypassword"
```

### 复制问题

**问题描述**：主从复制延迟或失败。

**解决方案**：
1. 检查网络连接
2. 验证复制配置
3. 监控复制状态
4. 调整复制缓冲区

**复制状态**：
```bash
# 查看复制信息
INFO replication
```

### 集群问题

**问题描述**：集群节点无法同步或故障转移失败。

**解决方案**：
1. 检查集群状态
2. 验证节点配置
3. 修复集群故障
4. 重新分配槽位

**集群管理**：
```bash
# 查看集群信息
CLUSTER INFO

# 查看集群节点
CLUSTER NODES

# 修复集群
CLUSTER FIX
```

### 安全问题

**问题描述**：Redis 安全配置不当。

**解决方案**：
1. 设置密码认证
2. 限制网络访问
3. 禁用危险命令
4. 使用 TLS 加密

**安全配置**：
```bash
# 设置密码
CONFIG SET requirepass "strongpassword"

# 禁用危险命令
CONFIG SET rename-command "FLUSHDB" ""
CONFIG SET rename-command "FLUSHALL" ""
CONFIG SET rename-command "CONFIG" ""
```

## 相关资源

### 官方资源

- **官方网站**：https://redis.io
- **文档**：https://redis.io/documentation
- **下载页面**：https://redis.io/download
- **版本历史**：https://redis.io/download#release-notes

### 学习资源

- **官方教程**：https://redis.io/docs/getting-started/
- **命令参考**：https://redis.io/commands
- **数据类型**：https://redis.io/docs/data-types/
- **最佳实践**：https://redis.io/docs/management/

### 社区资源

- **GitHub**：https://github.com/redis/redis
- **Stack Overflow**：https://stackoverflow.com/questions/tagged/redis
- **Google Groups**：https://groups.google.com/g/redis-db

### 客户端库

- **Python**：https://pypi.org/project/redis/
- **Java**：https://github.com/redis/jedis
- **PHP**：https://github.com/phpredis/phpredis
- **JavaScript**：https://www.npmjs.com/package/redis
- **C#**：https://github.com/StackExchange/StackExchange.Redis
- **Go**：https://github.com/go-redis/redis

### 许可信息

- **许可证**：BSD-3-Clause
- **版权声明**：Copyright 2009-2014, Salvatore Sanfilippo
- **分发条款**：可以自由使用、修改和分发

### 技术支持

- **帮助中心**：https://redis.io/support
- **问题跟踪**：https://github.com/redis/redis/issues
- **社区论坛**：https://redis.io/community

### 版本信息

- **当前版本**：v7.0.11
- **发布日期**：2023 年
- **更新频率**：定期发布
- **支持平台**：Linux、macOS、Windows（第三方）

### 系统要求

**Linux**：
- Linux 2.6 或更高版本
- 2GB RAM（推荐 4GB）
- 1GB 磁盘空间

**macOS**：
- macOS 10.13 或更高版本
- 2GB RAM（推荐 4GB）

**Windows**：
- Windows 10/11
- 通过 WSL 或第三方移植
- 2GB RAM（推荐 4GB）

### 功能对比

| 数据类型 | 存储结构 | 适用场景 | 大小限制 |
|----------|----------|----------|----------|
| String | 字符串 | 缓存、计数器 | 512MB |
| Hash | 哈希表 | 对象存储 | 2^32-1 字段 |
| List | 链表 | 队列、栈 | 2^32-1 元素 |
| Set | 哈希表 | 标签、集合运算 | 2^32-1 元素 |
| Sorted Set | 跳表+哈希 | 排行榜 | 2^32-1 元素 |

### 最佳实践

**键设计**：
1. 使用有意义的键名
2. 避免过长的键名
3. 使用冒号分隔命名空间
4. 避免热点键

**数据结构选择**：
1. 根据使用场景选择数据结构
2. 避免大键操作
3. 使用合适的数据类型
4. 考虑内存使用效率

**性能优化**：
1. 使用管道技术
2. 避免阻塞操作
3. 监控慢查询
4. 合理设置过期时间

### 故障排除清单

- [ ] 检查 Redis 服务状态
- [ ] 验证连接配置
- [ ] 检查内存使用情况
- [ ] 验证持久化配置
- [ ] 查看错误日志
- [ ] 监控性能指标
- [ ] 检查网络连接
- [ ] 验证安全配置

### 快速入门示例

**Python 示例**：
```python
import redis

# 连接 Redis
r = redis.Redis(host='localhost', port=6379, db=0)

# 字符串操作
r.set('name', 'Redis')
print(r.get('name'))

# 哈希操作
r.hset('user:1', 'name', 'John')
r.hset('user:1', 'age', 30)
print(r.hgetall('user:1'))

# 列表操作
r.lpush('tasks', 'task1')
r.lpush('tasks', 'task2')
print(r.lrange('tasks', 0, -1))

# 集合操作
r.sadd('tags', 'python')
r.sadd('tags', 'redis')
print(r.smembers('tags'))

# 有序集合操作
r.zadd('leaderboard', {'Alice': 100, 'Bob': 200})
print(r.zrange('leaderboard', 0, -1, withscores=True))
```

**PHP 示例**：
```php
<?php
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);

// 字符串操作
$redis->set('name', 'Redis');
echo $redis->get('name');

// 哈希操作
$redis->hSet('user:1', 'name', 'John');
$redis->hSet('user:1', 'age', 30);
print_r($redis->hGetAll('user:1'));

// 列表操作
$redis->lPush('tasks', 'task1');
$redis->lPush('tasks', 'task2');
print_r($redis->lRange('tasks', 0, -1));

// 集合操作
$redis->sAdd('tags', 'python');
$redis->sAdd('tags', 'redis');
print_r($redis->sMembers('tags'));

// 有序集合操作
$redis->zAdd('leaderboard', 100, 'Alice');
$redis->zAdd('leaderboard', 200, 'Bob');
print_r($redis->zRange('leaderboard', 0, -1, true));
?>
```

### 高级配置

**内存配置**：
```bash
# 设置最大内存
maxmemory 256mb

# 设置淘汰策略
maxmemory-policy allkeys-lru

# 设置样本数量
maxmemory-samples 10
```

**持久化配置**：
```bash
# RDB 配置
save 900 1
save 300 10
save 60 10000

# AOF 配置
appendonly yes
appendfsync everysec

# 混合持久化
aof-use-rdb-preamble yes
```

**网络配置**：
```bash
# 绑定地址
bind 0.0.0.0

# 保护模式
protected-mode yes

# 端口
port 6379

# 超时时间
timeout 300

# TCP backlog
tcp-backlog 511
```

### 复制配置

**主从配置**：
```bash
# 从节点配置
replicaof 127.0.0.1 6379

# 主节点密码
masterauth mypassword

# 只读从节点
replica-read-only yes
```

**哨兵配置**：
```bash
sentinel monitor mymaster 127.0.0.1 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 60000
sentinel parallel-syncs mymaster 1
```

### 集群配置

**集群创建**：
```bash
redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 --cluster-replicas 1
```

**集群管理**：
```bash
# 查看集群信息
redis-cli -c -h 127.0.0.1 -p 7000 cluster info

# 查看集群节点
redis-cli -c -h 127.0.0.1 -p 7000 cluster nodes

# 添加节点
redis-cli --cluster add-node 127.0.0.1:7003 127.0.0.1:7000

# 删除节点
redis-cli --cluster del-node 127.0.0.1:7000 <node-id>

# 重新分片
redis-cli --cluster reshard 127.0.0.1:7000
```

### 监控和调试

**性能监控**：
```bash
# 实时监控命令
redis-cli monitor

# 查看慢查询
redis-cli slowlog get 10

# 查看内存使用
redis-cli info memory

# 查看客户端信息
redis-cli info clients
```

**调试工具**：
```bash
# 分析内存使用
redis-cli memory usage key

# 分析键空间
redis-cli --bigkeys

# 分析延迟
redis-cli --latency
redis-cli --latency-history
```

### 安全配置

**密码认证**：
```bash
# 设置密码
requirepass mypassword

# 客户端认证
AUTH mypassword
```

**网络安全**：
```bash
# 绑定地址
bind 127.0.0.1

# 保护模式
protected-mode yes

# 禁用危险命令
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command CONFIG "CONFIG_b82e4e0a"
```

**TLS 配置**：
```bash
# 启用 TLS
tls-port 6380
tls-cert-file /path/to/redis.crt
tls-key-file /path/to/redis.key
tls-ca-cert-file /path/to/ca.crt
```

### 客户端使用

**连接池配置**：
```python
import redis

pool = redis.ConnectionPool(
    host='localhost',
    port=6379,
    db=0,
    max_connections=20,
    password='mypassword'
)

r = redis.Redis(connection_pool=pool)
```

**管道使用**：
```python
pipe = r.pipeline()
for i in range(1000):
    pipe.set(f'key:{i}', f'value:{i}')
pipe.execute()
```

**Lua 脚本**：
```python
script = """
local current = redis.call('GET', KEYS[1])
if current == ARGV[1] then
    redis.call('SET', KEYS[1], ARGV[2])
    return 1
end
return 0
"""

r.register_script(script)(keys=['mykey'], args=['old_value', 'new_value'])
```

### 测试策略

**单元测试**：
```python
import unittest
import redis

class TestRedis(unittest.TestCase):
    def setUp(self):
        self.r = redis.Redis(host='localhost', port=6379, db=0)
        self.r.flushdb()
    
    def test_set_get(self):
        self.r.set('key', 'value')
        self.assertEqual(self.r.get('key'), b'value')
    
    def test_hash(self):
        self.r.hset('user', 'name', 'John')
        self.assertEqual(self.r.hget('user', 'name'), b'John')
    
    def tearDown(self):
        self.r.flushdb()
```

**集成测试**：
```python
def test_pipeline():
    r = redis.Redis(host='localhost', port=6379, db=0)
    pipe = r.pipeline()
    
    pipe.set('key1', 'value1')
    pipe.set('key2', 'value2')
    pipe.get('key1')
    pipe.get('key2')
    
    results = pipe.execute()
    assert results == [True, True, b'value1', b'value2']
```