# MongoDB 使用指南

> 版本：v6.0.1 | 许可证：SSPL-1.0 | 官网：https://www.mongodb.org

---

## 简介

MongoDB 是一款面向文档的 NoSQL 数据库，以其出色的可扩展性和灵活性著称。与传统的关系型数据库不同，MongoDB 使用类似 JSON 的 BSON（Binary JSON）格式存储数据，使得数据模型更加灵活，能够轻松处理各种复杂的数据结构。

MongoDB 采用分布式架构设计，原生支持水平扩展、高可用性和数据分片，非常适合需要处理海量数据、要求高性能读写操作的现代应用场景。

### 核心特性

- **文档模型**：使用 BSON 文档存储数据，支持嵌套文档和数组
- **动态 Schema**：无需预先定义表结构，字段可以随时添加或修改
- **高性能**：支持索引、嵌入式文档，优化查询性能
- **高可用性**：副本集（Replica Set）提供自动故障转移
- **水平扩展**：通过分片（Sharding）实现数据的水平分布
- **丰富的查询语言**：支持 CRUD 操作、聚合管道、文本搜索、地理空间查询

### 适用场景

- 内容管理系统（CMS）
- 移动应用后端
- 物联网（IoT）数据存储
- 实时分析平台
- 电商平台产品目录
- 社交网络应用

---

## 主要功能

### 1. 数据库管理

MongoDB 使用数据库（Database）→ 集合（Collection）→ 文档（Document）的层级结构组织数据，类似于关系型数据库中的数据库 → 表 → 行。

### 2. 索引支持

支持多种索引类型：

- 单字段索引
- 复合索引
- 多键索引（数组字段）
- 文本索引
- 哈希索引
- 地理空间索引
- TTL 索引（自动过期数据）

### 3. 聚合管道

强大的数据处理管道，支持多阶段数据转换：

- `$match` - 过滤文档
- `$group` - 分组统计
- `$sort` - 排序
- `$project` - 字段投影
- `$lookup` - 关联查询
- `$unwind` - 数组展开

### 4. 副本集

提供数据冗余和高可用性：

- 自动故障转移
- 读写分离
- 数据同步

### 5. 分片

支持水平扩展，将数据分布到多个服务器：

- 范围分片
- 哈希分片
- Zone 分片

### 6. GridFS

用于存储和检索超过 BSON 文档大小限制（16MB）的文件。

---

## 常用命令

### 服务端命令

#### mongod.exe - 数据库服务进程

```powershell
# 使用默认配置启动 MongoDB 服务
mongod

# 指定配置文件启动
mongod --config "C:\path\to\mongod.cfg"

# 指定数据目录启动
mongod --dbpath "C:\data\db"

# 指定端口启动（默认 27017）
mongod --port 27017

# 指定日志文件路径
mongod --logpath "C:\data\log\mongod.log"

# 以后台服务方式运行（Windows 服务）
mongod --install --config "C:\path\to\mongod.cfg"

# 移除 Windows 服务
mongod --remove

# 启动已安装的 Windows 服务
net start MongoDB

# 停止 Windows 服务
net stop MongoDB
```

#### mongos.exe - 分片路由进程

```powershell
# 启动分片路由器
mongos --config "C:\path\to\mongos.cfg"

# 指定配置服务器
mongos --configdb "configReplSet/cfg1:27019,cfg2:27019,cfg3:27019"

# 指定监听端口
mongos --port 27017
```

### 客户端命令

#### mongo / mongosh - Shell 交互工具

```powershell
# 连接本地 MongoDB
mongosh

# 连接指定主机和端口
mongosh --host localhost --port 27017

# 连接并指定数据库
mongosh --db mydb

# 使用连接字符串
mongosh "mongodb://localhost:27017/mydb"

# 使用认证连接
mongosh "mongodb://username:password@localhost:27017/mydb"

# 执行 JavaScript 脚本
mongosh --file "script.js"
```

### Shell 常用操作

#### 数据库操作

```javascript
// 显示所有数据库
show dbs

// 切换/创建数据库
use mydb

// 显示当前数据库
db

// 删除当前数据库
db.dropDatabase()

// 显示当前数据库的集合
show collections

// 创建集合并插入文档
db.users.insertOne({ name: "张三", age: 25 })

// 查询所有文档
db.users.find()

// 条件查询
db.users.find({ age: { $gt: 20 } })

// 更新文档
db.users.updateOne({ name: "张三" }, { $set: { age: 26 } })

// 删除文档
db.users.deleteOne({ name: "张三" })

// 创建索引
db.users.createIndex({ name: 1 })

// 查看集合统计
db.users.stats()

// 查看执行计划
db.users.find({ name: "张三" }).explain()
```

#### 用户管理

```javascript
// 创建管理员用户
use admin
db.createUser({
  user: "admin",
  pwd: "password",
  roles: [{ role: "root", db: "admin" }]
})

// 创建数据库用户
use mydb
db.createUser({
  user: "myuser",
  pwd: "mypassword",
  roles: [{ role: "readWrite", db: "mydb" }]
})

// 查看用户
show users

// 删除用户
db.dropUser("myuser")
```

#### 副本集管理

```javascript
// 初始化副本集
rs.initiate()

// 添加成员
rs.add("mongodb2:27017")

// 查看副本集状态
rs.status()

// 查看副本集配置
rs.conf()
```

### 数据备份与恢复

```powershell
# 备份整个数据库
mongodump --db mydb --out C:\backup

# 备份指定集合
mongodump --db mydb --collection users --out C:\backup

# 使用连接字符串备份
mongodump --uri "mongodb://localhost:27017/mydb" --out C:\backup

# 恢复数据库
mongorestore --db mydb C:\backup\mydb

# 恢复指定集合
mongorestore --db mydb --collection users C:\backup\mydb\users.bson

# 导出集合为 JSON
mongoexport --db mydb --collection users --out users.json

# 导入 JSON 到集合
mongoimport --db mydb --collection users --file users.json

# 导出为 CSV
mongoexport --db mydb --collection users --type=csv --fields name,age --out users.csv
```

### 配置文件 (mongod.cfg)

```yaml
storage:
  dbPath: C:\data\db
  journal:
    enabled: true

systemLog:
  destination: file
  path: C:\data\log\mongod.log
  logAppend: true

net:
  port: 27017
  bindIp: 127.0.0.1

security:
  authorization: enabled

replication:
  replSetName: "rs0"

setParameter:
  enableLocalhostAuthBypass: true
```

---

## 常见问题

### Q1: MongoDB 服务无法启动怎么办？

**可能原因及解决方案：**

1. **数据目录不存在**：确保 `dbPath` 指定的目录已创建
   ```powershell
   New-Item -ItemType Directory -Path "C:\data\db"
   ```

2. **端口被占用**：检查 27017 端口是否被其他程序占用
   ```powershell
   netstat -ano | findstr :27017
   ```

3. **锁文件异常**：删除数据目录中的 `mongod.lock` 文件后重启
   ```powershell
   Remove-Item "C:\data\db\mongod.lock"
   mongod --repair --dbpath "C:\data\db"
   ```

4. **权限不足**：以管理员身份运行命令提示符

### Q2: 如何启用用户认证？

1. 在配置文件中启用安全认证：
   ```yaml
   security:
     authorization: enabled
   ```

2. 创建管理员用户后重启服务

3. 使用认证方式连接：
   ```powershell
   mongosh -u admin -p password --authenticationDatabase admin
   ```

### Q3: MongoDB 数据库文件占用空间过大怎么办？

- 执行 `db.repairDatabase()` 压缩数据库
- 使用 `compact` 命令压缩集合：`db.runCommand({ compact: "collectionName" })`
- 考虑使用 WiredTiger 存储引擎的压缩功能
- 定期清理过期数据或设置 TTL 索引

### Q4: 如何查看 MongoDB 的运行状态？

```javascript
// 在 mongosh 中查看服务器状态
db.serverStatus()

// 查看当前操作
db.currentOp()

// 查看慢查询日志
db.getProfilingStatus()
db.setProfilingLevel(1, { slowms: 100 })
db.system.profile.find().sort({ ts: -1 }).limit(5)
```

### Q5: 如何优化查询性能？

- 为常用查询字段创建合适的索引
- 使用 `explain()` 分析查询计划
- 避免返回不必要的字段（使用投影）
- 合理设计文档结构，避免过度嵌套
- 使用聚合管道替代多次查询

### Q6: MongoDB 与其他数据库的区别是什么？

- **vs MySQL**：无固定 Schema，更好的水平扩展，JSON 原生支持
- **vs PostgreSQL**：更简单的数据模型，更好的分布式支持
- **vs Redis**：持久化存储，支持复杂查询，适合更大的数据集
- **vs Elasticsearch**：通用数据库 vs 搜索引擎，MongoDB 适合通用场景

---

## 相关资源

### 官方资源

- MongoDB 官网：https://www.mongodb.org
- MongoDB 官方文档：https://www.mongodb.com/docs/
- MongoDB University（免费课程）：https://university.mongodb.com/
- MongoDB GitHub：https://github.com/mongodb

### 驱动程序

- Node.js 驱动：https://www.mongodb.com/docs/drivers/node/current/
- Python 驱动（PyMongo）：https://www.mongodb.com/docs/drivers/pymongo/
- Java 驱动：https://www.mongodb.com/docs/drivers/java/
- C# 驱动：https://www.mongodb.com/docs/drivers/csharp/

### GUI 工具

- MongoDB Compass（官方 GUI）：https://www.mongodb.com/products/compass
- Studio 3T：https://studio3t.com/
- Navicat for MongoDB：https://www.navicat.com/

### 社区资源

- MongoDB 社区论坛：https://www.mongodb.com/community/forums/
- Stack Overflow MongoDB 标签：https://stackoverflow.com/questions/tagged/mongodb
- MongoDB 中文社区：https://mongoing.com/

### 学习资源

- MongoDB 菜鸟教程：https://www.runoob.com/mongodb/mongodb-tutorial.html
- MongoDB 实战教程：https://www.mongodb.com/docs/manual/tutorial/
