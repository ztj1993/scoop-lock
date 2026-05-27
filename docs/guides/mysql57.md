# MySQL 5.7 使用指南

> 版本：v5.7.41 | 许可证：GPL-2.0 | 官网：https://dev.mysql.com/downloads/mysql/5.7.html

---

## 简介

MySQL 是世界上最流行的开源关系型数据库管理系统（RDBMS），由 Oracle 公司维护和开发。MySQL 5.7 是一个成熟的版本，具有出色的性能、可靠性和易用性，被广泛应用于 Web 应用、企业级系统和数据仓库等场景。

MySQL 使用结构化查询语言（SQL）进行数据管理，支持标准的 ACID（原子性、一致性、隔离性、持久性）事务特性，确保数据的完整性和可靠性。

### 核心特性

- **高性能**：优化的查询执行引擎，支持查询缓存和索引优化
- **高可靠性**：支持事务处理、外键约束和崩溃恢复
- **丰富的存储引擎**：InnoDB（默认）、MyISAM、Memory 等
- **复制功能**：主从复制、半同步复制、GTID 复制
- **分区表**：支持水平分区，提升大数据量查询性能
- **JSON 支持**：原生 JSON 数据类型和相关函数
- **安全特性**：密码策略、审计插件、数据加密
- **地理空间支持**：GIS 数据类型和空间索引

### 默认配置

- 默认用户：`root`
- 默认密码：无（空密码）
- 默认端口：`3306`

### 适用场景

- Web 应用后端数据库
- 电子商务平台
- 内容管理系统（CMS）
- 日志和数据分析
- 在线事务处理（OLTP）
- 中小型企业应用

---

## 主要功能

### 1. 存储引擎

#### InnoDB（默认引擎）

- 支持 ACID 事务
- 行级锁定
- 外键约束
- 崩溃恢复
- MVCC（多版本并发控制）

#### MyISAM

- 不支持事务
- 表级锁定
- 全文索引
- 较高的读取性能
- 较小的存储空间

### 2. 索引类型

- **B-Tree 索引**：最常用的索引类型
- **全文索引**：用于全文搜索
- **哈希索引**：Memory 引擎支持
- **空间索引**：用于 GIS 数据

### 3. 数据类型

- **数值类型**：INT、BIGINT、DECIMAL、FLOAT 等
- **字符串类型**：VARCHAR、TEXT、BLOB、ENUM 等
- **日期时间类型**：DATE、TIME、DATETIME、TIMESTAMP 等
- **JSON 类型**：原生 JSON 文档支持

### 4. 复制功能

- 异步复制
- 半同步复制
- GTID 复制
- 多源复制
- 延迟复制

### 5. 分区

- 范围分区（RANGE）
- 列表分区（LIST）
- 哈希分区（HASH）
- 键分区（KEY）

### 6. 安全功能

- 用户权限管理
- 密码过期策略
- 连接加密（SSL/TLS）
- 审计日志
- 数据加密

---

## 常用命令

### mysql.exe - MySQL 客户端工具

```powershell
# 连接本地 MySQL（root 用户，无密码）
mysql -u root

# 连接并指定密码
mysql -u root -p

# 连接指定主机和端口
mysql -h localhost -P 3306 -u root -p

# 连接指定数据库
mysql -u root -p database_name

# 使用连接字符串
mysql --protocol=tcp --host=localhost --port=3306 --user=root --password

# 执行 SQL 文件
mysql -u root -p database_name < script.sql

# 执行单条 SQL 语句
mysql -u root -p -e "SELECT * FROM users"

# 导出查询结果到文件
mysql -u root -p -e "SELECT * FROM users" > output.txt

# 指定字符集连接
mysql -u root -p --default-character-set=utf8mb4
```

### mysqld.exe - MySQL 服务进程

```powershell
# 安装为 Windows 服务
mysqld --install MySQL57

# 指定配置文件安装服务
mysqld --install MySQL57 --defaults-file="C:\mysql\my.ini"

# 初始化数据库（首次安装）
mysqld --initialize --user=mysql

# 初始化数据库（无密码）
mysqld --initialize-insecure --user=mysql

# 启动服务（命令行方式）
mysqld --console

# 指定配置文件启动
mysqld --defaults-file="C:\mysql\my.ini" --console

# 以安全模式启动（跳过权限检查）
mysqld --skip-grant-tables --skip-networking

# 移除 Windows 服务
mysqld --remove MySQL57

# 启动已安装的服务
net start MySQL57

# 停止服务
net stop MySQL57
```

### mysqladmin.exe - 管理工具

```powershell
# 检查服务器状态
mysqladmin -u root -p status

# 查看服务器版本
mysqladmin -u root -p version

# 查看服务器进程列表
mysqladmin -u root -p processlist

# 查看服务器变量
mysqladmin -u root -p variables

# 创建数据库
mysqladmin -u root -p create newdb

# 删除数据库
mysqladmin -u root -p drop newdb

# 修改 root 密码
mysqladmin -u root -p password "newpassword"

# 刷新权限
mysqladmin -u root -p flush-privileges

# 刷新日志
mysqladmin -u root -p flush-logs

# 关闭 MySQL 服务
mysqladmin -u root -p shutdown

# 查看服务器状态变量
mysqladmin -u root -p extended-status

# 检查表
mysqladmin -u root -p check table tablename

# 优化表
mysqladmin -u root -p optimize table tablename
```

### mysqldump.exe - 数据备份工具

```powershell
# 备份单个数据库
mysqldump -u root -p database_name > backup.sql

# 备份多个数据库
mysqldump -u root -p --databases db1 db2 > backup.sql

# 备份所有数据库
mysqldump -u root -p --all-databases > backup.sql

# 备份指定表
mysqldump -u root -p database_name table1 table2 > backup.sql

# 备份表结构（不包含数据）
mysqldump -u root -p --no-data database_name > schema.sql

# 备份数据（不包含结构）
mysqldump -u root -p --no-create-info database_name > data.sql

# 备份包含存储过程和函数
mysqldump -u root -p --routines --triggers database_name > backup.sql

# 带压缩备份
mysqldump -u root -p database_name | gzip > backup.sql.gz

# 备份时使用事务一致性
mysqldump -u root -p --single-transaction database_name > backup.sql

# 备份时忽略指定表
mysqldump -u root -p --ignore-table=database_name.table_name database_name > backup.sql

# 恢复数据库
mysql -u root -p database_name < backup.sql

# 恢复所有数据库
mysql -u root -p < all_backup.sql
```

### mysqlimport.exe - 数据导入工具

```powershell
# 从 CSV 文件导入数据
mysqlimport -u root -p database_name data.txt

# 指定分隔符
mysqlimport -u root -p --fields-terminated-by=',' database_name data.csv

# 忽略前 N 行
mysqlimport -u root -p --ignore-lines=1 database_name data.csv

# 指定字符集
mysqlimport -u root -p --default-character-set=utf8mb4 database_name data.csv

# 替换已有数据
mysqlimport -u root -p --replace database_name data.txt

# 忽略重复数据
mysqlimport -u root -p --ignore database_name data.txt
```

### mysqlcheck.exe - 表检查修复工具

```powershell
# 检查所有表
mysqlcheck -u root -p --all-databases

# 检查指定数据库
mysqlcheck -u root -p database_name

# 检查指定表
mysqlcheck -u root -p database_name table_name

# 修复表
mysqlcheck -u root -p --repair database_name

# 优化表
mysqlcheck -u root -p --optimize database_name

# 分析表
mysqlcheck -u root -p --analyze database_name

# 自动修复
mysqlcheck -u root -p --auto-repair database_name
```

### mysqlshow.exe - 数据库信息查看

```powershell
# 显示所有数据库
mysqlshow -u root -p

# 显示数据库中的所有表
mysqlshow -u root -p database_name

# 显示表结构
mysqlshow -u root -p database_name table_name

# 显示表状态
mysqlshow -u root -p --status database_name

# 显示列信息
mysqlshow -u root -p --keys database_name table_name

# 使用通配符
mysqlshow -u root -p "test%"
```

### mysqlpump.exe - 并行备份工具（MySQL 5.7+）

```powershell
# 并行备份所有数据库
mysqlpump -u root -p --all-databases > backup.sql

# 备份指定数据库
mysqlpump -u root -p --databases database_name > backup.sql

# 指定并行线程数
mysqlpump -u root -p --default-parallelism=4 --all-databases > backup.sql

# 备份表结构
mysqlpump -u root -p --no-data database_name > schema.sql

# 排除指定数据库
mysqlpump -u root -p --exclude-databases=information_schema,mysql > backup.sql
```

### SQL 常用操作

```sql
-- 创建数据库
CREATE DATABASE mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE mydb;

-- 创建表
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 插入数据
INSERT INTO users (username, email, password) VALUES ('zhangsan', 'zhangsan@example.com', 'hashed_password');

-- 批量插入
INSERT INTO users (username, email, password) VALUES
('lisi', 'lisi@example.com', 'pass1'),
('wangwu', 'wangwu@example.com', 'pass2');

-- 查询数据
SELECT * FROM users WHERE id = 1;

-- 分页查询
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET 0;

-- 更新数据
UPDATE users SET email = 'new@example.com' WHERE id = 1;

-- 删除数据
DELETE FROM users WHERE id = 1;

-- 创建索引
CREATE INDEX idx_email ON users(email);

-- 创建复合索引
CREATE INDEX idx_name_email ON users(username, email);

-- 查看表结构
DESCRIBE users;
SHOW CREATE TABLE users;

-- 修改表结构
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
ALTER TABLE users MODIFY COLUMN phone VARCHAR(30);
ALTER TABLE users DROP COLUMN phone;

-- 用户管理
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON mydb.* TO 'newuser'@'localhost';
FLUSH PRIVILEGES;

-- 查看用户权限
SHOW GRANTS FOR 'newuser'@'localhost';

-- 撤销权限
REVOKE ALL PRIVILEGES ON mydb.* FROM 'newuser'@'localhost';

-- 删除用户
DROP USER 'newuser'@'localhost';

-- 修改密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';

-- 查看当前连接
SHOW PROCESSLIST;

-- 查看服务器状态
SHOW STATUS;

-- 查看变量
SHOW VARIABLES LIKE '%max_connections%';

-- 修改变量（运行时）
SET GLOBAL max_connections = 200;
```

### 配置文件 (my.ini)

```ini
[mysqld]
port = 3306
basedir = C:/mysql
datadir = C:/mysql/data
max_connections = 151
max_connect_errors = 100
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
default-storage-engine = InnoDB
innodb_buffer_pool_size = 128M
innodb_log_file_size = 48M
innodb_file_per_table = 1
innodb_flush_log_at_trx_commit = 1
slow_query_log = 1
slow_query_log_file = C:/mysql/data/slow-query.log
long_query_time = 2
log_error = C:/mysql/data/error.log
sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

[mysql]
default-character-set = utf8mb4
prompt = \u@mysql:\d>

[client]
port = 3306
default-character-set = utf8mb4
```

---

## 常见问题

### Q1: 无法连接到 MySQL 服务器怎么办？

**排查步骤：**

1. **检查服务是否运行**：
   ```powershell
   netstat -ano | findstr :3306
   Get-Service MySQL57
   ```

2. **检查防火墙**：确保 3306 端口未被阻止

3. **检查用户权限**：
   ```powershell
   mysql -u root -e "SELECT user, host FROM mysql.user;"
   ```

4. **重置 root 密码**：
   ```powershell
   # 停止服务
   net stop MySQL57
   # 跳过权限启动
   mysqld --skip-grant-tables --console
   # 另一个终端连接并重置密码
   mysql -u root
   # SQL: FLUSH PRIVILEGES;
   # SQL: ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
   ```

### Q2: 如何解决中文乱码问题？

1. 创建数据库时指定字符集：
   ```sql
   CREATE DATABASE mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

2. 在 my.ini 中配置默认字符集：
   ```ini
   character-set-server = utf8mb4
   collation-server = utf8mb4_unicode_ci
   ```

3. 连接时指定字符集：
   ```powershell
   mysql -u root -p --default-character-set=utf8mb4
   ```

### Q3: MySQL 数据目录在哪里？

- 默认数据目录：`C:\ProgramData\MySQL\MySQL Server 5.7\Data\`
- 通过 Scoop 安装时通常在 Scoop 的 persist 目录下
- 可以在 my.ini 的 `datadir` 配置项中查看

### Q4: 如何优化慢查询？

1. 开启慢查询日志：
   ```sql
   SET GLOBAL slow_query_log = 'ON';
   SET GLOBAL long_query_time = 2;
   ```

2. 使用 `EXPLAIN` 分析查询计划：
   ```sql
   EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';
   ```

3. 优化建议：
   - 为常用查询字段创建索引
   - 避免 SELECT *，只查询需要的字段
   - 合理使用 JOIN，避免笛卡尔积
   - 使用 LIMIT 限制返回行数

### Q5: 如何备份和恢复数据库？

参考上方 `mysqldump` 命令部分。关键点：

- 定期备份是保障数据安全的最佳实践
- 使用 `--single-transaction` 选项确保 InnoDB 备份的一致性
- 备份后验证备份文件的完整性
- 测试恢复流程确保备份可用

### Q6: MySQL 5.7 与 8.0 的主要区别是什么？

- **默认字符集**：8.0 默认 utf8mb4，5.7 默认 latin1
- **窗口函数**：8.0 支持，5.7 不支持
- **CTE（公共表表达式）**：8.0 支持 WITH 子句
- **JSON 增强**：8.0 提供更多 JSON 函数
- **角色管理**：8.0 支持角色（Role）
- **安全改进**：8.0 默认使用 caching_sha2_password 认证

### Q7: 如何查看和修改 MySQL 配置？

```sql
-- 查看所有变量
SHOW VARIABLES;

-- 查看特定变量
SHOW VARIABLES LIKE 'max_connections';

-- 修改全局变量（需要重启才能持久化）
SET GLOBAL max_connections = 300;

-- 查看当前生效的配置文件
SHOW VARIABLES LIKE 'basedir';
```

---

## 相关资源

### 官方资源

- MySQL 官网：https://www.mysql.com/
- MySQL 5.7 文档：https://dev.mysql.com/doc/refman/5.7/en/
- MySQL 5.7 下载：https://dev.mysql.com/downloads/mysql/5.7.html
- MySQL Bug 追踪：https://bugs.mysql.com/

### GUI 管理工具

- MySQL Workbench（官方工具）：https://www.mysql.com/products/workbench/
- Navicat for MySQL：https://www.navicat.com/
- DBeaver：https://dbeaver.io/
- HeidiSQL：https://www.heidisql.com/
- phpMyAdmin：https://www.phpmyadmin.net/

### 驱动程序

- Python（mysql-connector-python）：https://pypi.org/project/mysql-connector-python/
- Python（PyMySQL）：https://pypi.org/project/PyMySQL/
- Node.js（mysql2）：https://www.npmjs.com/package/mysql2
- Java（MySQL Connector/J）：https://dev.mysql.com/downloads/connector/j/
- C#（MySql.Data）：https://dev.mysql.com/downloads/connector/net/
- Go（go-sql-driver）：https://github.com/go-sql-driver/mysql

### 社区资源

- MySQL 社区论坛：https://forums.mysql.com/
- Stack Overflow MySQL 标签：https://stackoverflow.com/questions/tagged/mysql
- MySQL 中文社区：http://imysql.com/

### 学习资源

- MySQL 菜鸟教程：https://www.runoob.com/mysql/mysql-tutorial.html
- SQL 教程：https://www.w3schools.com/sql/
- MySQL 性能优化：https://www.percona.com/blog/
