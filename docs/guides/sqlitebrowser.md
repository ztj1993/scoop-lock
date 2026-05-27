# DB Browser for SQLite 使用指南

## 简介

DB Browser for SQLite（简称 DB4S）是一款功能强大的开源数据库管理工具，专为 SQLite 数据库设计。

它提供了一个直观的图形用户界面，让用户无需编写 SQL 语句即可创建、设计和编辑 SQLite 数据库文件。

当前通过 Scoop 安装的版本为 **v3.13.1**，采用 **MPL-2.0|GPL-3.0** 双许可协议。

DB4S 隶属于 **DB Browser for SQLite (DB4S) project** 开源社区项目。

官方网站：https://sqlitebrowser.org/

该工具适用于数据库开发人员、数据分析师以及任何需要与 SQLite 数据库交互的用户。

无论是小型项目的数据存储还是嵌入式应用的数据库管理，DB4S 都能提供出色的使用体验。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v3.13.1                               |
| 许可证     | MPL-2.0 / GPL-3.0                     |
| 项目主页   | https://sqlitebrowser.org/            |
| 包含程序   | DB Browser for SQLite.exe, DB Browser for SQLCipher.exe |

### 与其他 SQLite 工具对比

与命令行工具 `sqlite3` 相比，DB4S 提供了可视化界面，降低了使用门槛。

与 DBeaver、DataGrip 等通用数据库管理工具相比，DB4S 更加专注于 SQLite，启动速度更快，资源占用更少。

对于需要加密数据库的场景，DB4S 还附带了 **DB Browser for SQLCipher**，支持 SQLCipher 加密数据库的创建和管理。

## 主要功能

### 数据库创建与管理

DB4S 支持创建全新的 SQLite 数据库文件，用户可以指定文件名和存储位置。

可以打开和浏览现有的 SQLite 数据库文件（.db、.sqlite、.sqlite3 等格式）。

支持数据库的压缩（VACUUM）操作，优化数据库文件大小。

支持将数据库导出为 SQL 脚本文件，便于迁移和备份。

### 表结构设计

提供可视化的表设计器，支持创建新表、修改表结构和删除表。

支持设置字段的数据类型（INTEGER、TEXT、REAL、BLOB、NUMERIC 等）。

可以定义主键、外键、唯一约束、非空约束和默认值。

支持通过界面添加和管理索引，优化查询性能。

支持创建视图（View）和触发器（Trigger）。

### 数据浏览与编辑

以表格形式展示数据，支持分页浏览，处理大数据集时不会卡顿。

支持在表格中直接添加、修改和删除记录。

提供排序和过滤功能，快速定位目标数据。

支持导入 CSV、JSON 等格式的数据文件。

支持将查询结果导出为 CSV、JSON、SQL 等多种格式。

### SQL 执行环境

内置功能完善的 SQL 编辑器，支持语法高亮和自动补全。

可以执行单条或多条 SQL 语句，查看执行结果。

支持在执行前进行 SQL 语句的语法检查。

SQL 执行历史记录方便重复执行常用查询。

支持同时打开多个 SQL 编辑器标签页。

### 数据库加密支持

通过 DB Browser for SQLCipher 版本，支持创建和打开 SQLCipher 加密数据库。

可以设置加密算法（如 AES-256）和 KDF 迭代次数。

支持修改现有加密数据库的密码。

## 常用操作

### 安装

通过 Scoop 安装 DB Browser for SQLite：

```powershell
scoop install sqlitebrowser
```

安装完成后，开始菜单中会出现两个快捷方式：
- DB Browser for SQLite.exe
- DB Browser for SQLCipher.exe

### 创建数据库

1. 打开 DB Browser for SQLite
2. 点击菜单栏的"新建数据库"按钮或使用快捷键 `Ctrl+N`
3. 在弹出的文件对话框中选择保存位置并输入文件名
4. 在表设计器中定义表结构
5. 点击"写入更改"保存表结构

### 打开已有数据库

1. 点击"打开数据库"按钮或使用快捷键 `Ctrl+O`
2. 浏览并选择目标 .db 或 .sqlite 文件
3. 在左侧导航栏中浏览数据库对象（表、视图、索引等）

### 编辑表数据

1. 在左侧导航栏双击目标表名
2. 切换到"浏览数据"标签页
3. 双击单元格进行编辑
4. 使用底部的"+"按钮添加新记录
5. 选中行后按 Delete 键删除记录
6. 点击"写入更改"保存修改

### 执行 SQL 查询

1. 点击"执行 SQL"标签页
2. 在编辑器中输入 SQL 语句
3. 点击执行按钮或按 `F5` 运行查询
4. 在下方的结果面板中查看查询结果

### 常用 SQL 操作示例

创建表：

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

插入数据：

```sql
INSERT INTO users (name, email) VALUES ('张三', 'zhangsan@example.com');
INSERT INTO users (name, email) VALUES ('李四', 'lisi@example.com');
```

查询数据：

```sql
SELECT * FROM users WHERE name LIKE '%张%';
SELECT COUNT(*) FROM users;
SELECT * FROM users ORDER BY created_at DESC LIMIT 10;
```

更新数据：

```sql
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;
```

删除数据：

```sql
DELETE FROM users WHERE id = 1;
```

### 导入数据

1. 点击菜单"文件" → "导入" → "表自 CSV 文件"
2. 选择 CSV 文件
3. 设置分隔符、编码等导入选项
4. 选择导入到新表或现有表
5. 确认字段映射后点击"确定"

### 导出数据

1. 选择要导出的表或执行查询获取结果集
2. 点击菜单"文件" → "导出" → "导出表自 CSV 文件"或"导出结果集自 CSV 文件"
3. 设置导出选项（分隔符、编码、是否包含列标题）
4. 选择保存位置并确认

### 数据库优化

定期执行 VACUUM 操作可以回收已删除数据占用的空间：

```sql
VACUUM;
```

也可以通过菜单"工具" → "压缩数据库"来执行此操作。

## 常见问题

### 无法打开数据库文件

**问题**：双击数据库文件后提示"无法打开文件"或显示错误信息。

**解决方法**：
- 检查文件是否被其他程序锁定
- 确认文件路径中不包含特殊字符
- 以管理员权限运行 DB4S
- 检查文件是否已损坏，尝试使用命令行工具 `sqlite3` 打开

### 数据库文件损坏

**问题**：打开数据库时提示"文件已损坏"或"不是数据库文件"。

**解决方法****：
- 使用 SQLite 命令行工具尝试修复：`sqlite3 damaged.db ".dump" | sqlite3 new.db`
- 从备份中恢复数据库文件
- 检查文件是否被意外截断或部分覆盖

### 大文件操作卡顿

**问题**：打开大型数据库（超过 1GB）时界面响应缓慢。

**解决方法**：
- 使用分页浏览模式，避免一次加载所有数据
- 编写带 LIMIT 子句的 SQL 查询来限制返回行数
- 关闭不必要的标签页以减少内存占用
- 考虑增加系统内存或使用 SSD 存储数据库文件

### SQLCipher 数据库无法解密

**问题**：使用 SQLCipher 版本打开加密数据库时提示密码错误。

**解决方法**：
- 确认使用的是 DB Browser for SQLCipher 而非普通版本
- 检查密码是否正确，注意大小写和特殊字符
- 确认加密算法和 KDF 迭代次数与创建时一致
- 尝试调整页大小（Page Size）设置

### 导入 CSV 编码乱码

**问题**：导入 CSV 文件后中文字符显示为乱码。

**解决方法**：
- 导入时将编码设置为 UTF-8
- 如果源文件是 GBK 编码，先用文本编辑器转换为 UTF-8
- 在导入选项中指定正确的分隔符和文本限定符

### SQL 自动补全不工作

**问题**：在 SQL 编辑器中输入时没有自动补全提示。

**解决方法**：
- 确认在设置中启用了自动补全功能
- 尝试按 `Ctrl+Space` 手动触发补全
- 确保数据库已正确打开且包含表结构

### 多用户并发访问问题

**问题**：多个程序同时访问同一个 SQLite 数据库时出现锁定错误。

**解决方法**：
- SQLite 采用文件级锁定，写操作会阻塞其他写操作
- 设置合理的超时时间：`PRAGMA busy_timeout = 5000;`
- 考虑使用 WAL 模式提高并发性能：`PRAGMA journal_mode=WAL;`
- 对于高并发场景，建议迁移到 PostgreSQL 或 MySQL

## 相关资源

### 官方资源

- 官方网站：https://sqlitebrowser.org/
- GitHub 仓库：https://github.com/sqlitebrowser/sqlitebrowser
- 官方文档：https://github.com/sqlitebrowser/sqlitebrowser/wiki
- 发布页面：https://github.com/sqlitebrowser/sqlitebrowser/releases

### SQLite 相关

- SQLite 官方文档：https://www.sqlite.org/docs.html
- SQLite SQL 语法参考：https://www.sqlite.org/lang.html
- SQLite 数据类型：https://www.sqlite.org/datatype3.html
- SQLCipher 项目：https://www.zetetic.net/sqlcipher/

### 社区资源

- Stack Overflow 上的 SQLite 标签：https://stackoverflow.com/questions/tagged/sqlite
- DB4S GitHub Issues：https://github.com/sqlitebrowser/sqlitebrowser/issues
- Scoop Extras 仓库：https://github.com/ScoopInstaller/Extras

### 学习资料

- SQLite 教程（W3Schools）：https://www.w3schools.com/sql/sql_intro.asp
- SQL 语言入门教程：https://www.runoob.com/sql/sql-tutorial.html
- SQLite 性能优化指南：https://www.sqlite.org/optimization.html

### 相关工具推荐

- **DBeaver**：通用数据库管理工具，支持多种数据库
- **DataGrip**：JetBrains 出品的专业数据库 IDE
- **sqlite3 CLI**：SQLite 官方命令行工具
- **DB Browser for SQLCipher**：DB4S 的加密数据库版本
