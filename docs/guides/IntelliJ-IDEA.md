# IntelliJ IDEA 使用指南

## 简介

IntelliJ IDEA 是 JetBrains 公司开发的一款专业级 Java 集成开发环境（IDE），被公认为
Java 开发者最强大的 IDE 之一。IntelliJ IDEA Ultimate v2021.2.2 是商业旗舰版，
提供企业级的开发功能，采用 Proprietary 商业许可证。

IntelliJ IDEA 基于 JetBrains 自研的 IntelliJ 平台构建，提供了智能代码补全、深度代码分析、
强大的重构工具、先进的调试器等核心能力。除了 Java，它还全面支持 Kotlin、Scala、Groovy 等
JVM 语言，以及 JavaScript、TypeScript、SQL、HTML、CSS 等 Web 技术栈。

IntelliJ IDEA 是 Spring、Jakarta EE、Micronaut、Quarkus 等 Java 企业级框架的首选 IDE，
同时提供数据库工具、应用服务器集成、Docker/Kubernetes 支持等企业级开发所需的全套功能。

Scoop 安装后通过 `idea64.exe` 快捷方式启动。

- **版本**: v2021.2.2
- **许可证**: Proprietary（商业许可）
- **官方网站**: https://www.jetbrains.com/idea/
- **安装方式**: Scoop 包管理器

## 主要功能

### 智能代码编辑

IntelliJ IDEA 的核心竞争力在于其深度的代码理解能力：

- **智能补全**: 基于上下文的代码补全，理解类型、数据流和设计模式
- **补全类型**: 基本补全（Ctrl+Space）、类型匹配补全（Ctrl+Shift+Space）、
  后缀补全（Postfix Completion）、静态方法补全
- **代码生成**: 自动生成 getter/setter、构造函数、equals/hashCode、toString 等
- **实时模板**: 预定义的代码模板（如 `sout`、`psvm`、`fori` 等）
- **意图操作**: Alt+Enter 触发智能修复和代码改进建议
- **代码检查**: 超过 600 种内置代码检查规则

### 深度代码分析

- 控制流分析
- 数据流分析
- 类型推断
- 空值分析（Null Analysis）
- 资源泄漏检测
- 并发问题检测
- 性能问题检测
- 安全漏洞检测

### 强大的重构工具

IntelliJ IDEA 提供业界最全面的重构支持：

- **Rename**: 跨文件安全重命名
- **Extract Method/Variable/Field/Class**: 提取重构
- **Inline**: 内联重构
- **Move**: 移动类、方法到其他文件
- **Change Signature**: 修改方法签名
- **Pull Members Up/Push Members Down**: 成员上移/下移
- **Convert**: 代码转换（如匿名类转 Lambda）
- **Copy/Move Class**: 复制/移动类到其他包
- **Type Migration**: 类型迁移

### 高级调试器

- 断点类型：行断点、条件断点、日志断点、异常断点、字段断点、方法断点
- 表达式求值和代码片段执行
- 变量视图和内存视图
- 帧导航和线程切换
- 远程调试和分布式调试
- Stream Debugger（Java Stream 链式调试）
- Drop Frame（回退到上一帧）

### 框架与技术栈支持

**Ultimate 版独有支持：**

- **Spring**: Spring Boot、Spring MVC、Spring Data、Spring Security
- **Jakarta EE**: JPA、JSF、CDI、EJB、JAX-RS
- **微服务**: Spring Cloud、Dubbo、gRPC
- **Web 开发**: JavaScript、TypeScript、Angular、React、Vue.js
- **数据库**: SQL 编辑器、数据库管理、持久化框架
- **应用服务器**: Tomcat、WildFly、GlassFish、WebSphere
- **容器**: Docker、Kubernetes
- **构建工具**: Maven、Gradle、Ant

### 数据库工具

- 支持 MySQL、PostgreSQL、Oracle、SQL Server、SQLite 等
- SQL 编辑和执行
- 数据查看和编辑
- 数据库结构管理
- 查询计划分析
- 数据导入导出
- ORM 映射可视化

### 版本控制集成

- Git、GitHub、GitLab、Bitbucket
- SVN、Mercurial、Perforce
- 可视化合并和差异对比
- 交互式 Rebase
- Shelf（暂存修改）
- Local History（本地历史记录）

## 常用命令/操作

### 启动 IntelliJ IDEA

Scoop 安装后启动：

```bash
idea64
```

命令行打开项目：

```bash
idea64 C:\path\to\project
```

命令行比较文件差异：

```bash
idea64 diff file1.java file2.java
```

命令行合并文件：

```bash
idea64 merge file1.java file2.java base.java output.java
```

### 快捷键参考

**通用操作：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Shift+A` | 查找操作（Action） |
| `Double Shift` | 全局搜索（Search Everywhere） |
| `Ctrl+N` | 查找类 |
| `Ctrl+Shift+N` | 查找文件 |
| `Ctrl+Alt+Shift+N` | 查找符号 |
| `Ctrl+Shift+F` | 全局文本搜索 |
| `Alt+1` | 项目工具窗口 |
| `Alt+F12` | 终端 |
| `Ctrl+Alt+S` | 打开设置 |
| `Ctrl+Shift+F12` | 最大化编辑器 |

**代码编辑：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Space` | 基本代码补全 |
| `Ctrl+Shift+Space` | 类型匹配补全 |
| `Ctrl+Alt+Space` | 类名补全 |
| `Ctrl+Shift+Enter` | 补全当前语句 |
| `Ctrl+J` | 插入 Live Template |
| `Ctrl+Alt+J` | 用 Live Template 包裹 |
| `Ctrl+/` | 行注释 |
| `Ctrl+Shift+/` | 块注释 |
| `Ctrl+D` | 复制行 |
| `Ctrl+Y` | 删除行 |
| `Ctrl+W` | 扩展选区 |
| `Ctrl+Shift+W` | 缩小选区 |
| `Alt+Enter` | 意图操作/快速修复 |
| `Ctrl+Alt+L` | 格式化代码 |
| `Ctrl+Alt+O` | 优化导入 |
| `Tab` | 展开缩写/后缀补全 |

**导航：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+B` | 跳转到定义 |
| `Ctrl+Alt+B` | 跳转到实现 |
| `Ctrl+U` | 跳转到父类 |
| `Ctrl+Shift+B` | 跳转到类型定义 |
| `Alt+Up/Down` | 在方法间跳转 |
| `Ctrl+[` / `Ctrl+]` | 跳转到代码块开始/结束 |
| `Ctrl+G` | 跳转到行 |
| `Ctrl+E` | 最近文件 |
| `Ctrl+Shift+E` | 最近编辑位置 |
| `Ctrl+Alt+Left` | 导航后退 |
| `Ctrl+Alt+Right` | 导航前进 |
| `F2` / `Shift+F2` | 跳转到下一个/上一个错误 |
| `Ctrl+F12` | 文件结构弹窗 |

**重构：**

| 快捷键 | 功能 |
|--------|------|
| `Shift+F6` | 重命名 |
| `Ctrl+Alt+M` | 提取方法 |
| `Ctrl+Alt+V` | 提取变量 |
| `Ctrl+Alt+F` | 提取字段 |
| `Ctrl+Alt+C` | 提取常量 |
| `Ctrl+Alt+P` | 提取参数 |
| `Ctrl+Alt+N` | 内联 |
| `F5` | 复制 |
| `F6` | 移动 |

**调试：**

| 快捷键 | 功能 |
|--------|------|
| `Shift+F9` | 调试模式运行 |
| `Shift+F10` | 运行模式运行 |
| `F8` | 单步跳过 |
| `F7` | 单步进入 |
| `Shift+F8` | 单步跳出 |
| `Alt+F9` | 运行到光标处 |
| `F9` | 继续执行 |
| `Ctrl+F8` | 切换断点 |
| `Ctrl+Shift+F8` | 查看所有断点 |
| `Alt+F8` | 计算表达式 |
| `Ctrl+F2` | 停止 |

**版本控制：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+K` | 提交 |
| `Ctrl+Shift+K` | 推送 |
| `Ctrl+T` | 拉取 |
| `Alt+Shift+C` | 查看最近更改 |
| `Ctrl+Alt+Z` | 回滚更改 |
| `Alt+Back Quote` | VCS 操作弹窗 |

### 配置 Java SDK

1. 打开 `File` → `Project Structure` → `Project`
2. 在 `SDK` 下拉框中选择已安装的 JDK
3. 如需添加新 JDK，点击 `Add SDK` → `JDK` 并选择 JDK 安装目录

### 创建项目

创建 Java 项目：
1. `File` → `New` → `Project`
2. 选择项目类型（Java、Maven、Gradle、Spring Initializr 等）
3. 配置项目名称、位置和 SDK
4. 选择构建工具和框架

创建 Maven 项目：

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0-SNAPSHOT</version>
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
</project>
```

### 运行与调试配置

创建运行配置：
1. 点击右上角运行配置下拉框
2. 选择 `Edit Configurations`
3. 点击 `+` 添加配置类型
4. 配置主类、程序参数、环境变量、JVM 参数等

常用配置类型：
- Application：运行 Java 主类
- JUnit：运行测试
- Maven：运行 Maven 命令
- Gradle：运行 Gradle 命令
- Remote JVM Debug：远程调试
- Spring Boot：运行 Spring Boot 应用

### 插件管理

通过 `File` → `Settings` → `Plugins` 管理：

推荐插件：
- **Lombok**: Lombok 注解支持
- **MyBatisX**: MyBatis 增强
- **Key Promoter X**: 快捷键学习
- **Rainbow Brackets**: 彩色括号
- **SonarLint**: 代码质量检查
- **Maven Helper**: Maven 依赖分析
- **GsonFormat**: JSON 转 Java 类
- **JRebel**: 热部署
- **.env files support**: 环境变量文件支持

## 常见问题

### Q: IntelliJ IDEA 社区版和旗舰版有什么区别？

- 社区版（Community）：免费开源，支持基本 Java/Kotlin 开发、Maven/Gradle 构建
- 旗舰版（Ultimate）：付费订阅，额外支持 Web 开发、Spring、数据库工具、企业框架等

### Q: 如何激活 IntelliJ IDEA？

- 30 天免费试用
- 购买商业订阅
- 学生/教师免费教育许可
- 开源项目维护者免费许可

### Q: IDE 卡顿怎么办？

1. `Help` → `Change Memory Settings` 增加内存（建议 2048MB+）
2. 关闭不需要的插件
3. `File` → `Invalidate Caches` 清理缓存
4. 排除不需要索引的目录（右键 → `Mark Directory as` → `Excluded`）
5. 关闭 Power Save Mode

### Q: 如何配置 Maven 阿里云镜像？

在 `~/.m2/settings.xml` 中配置：

```xml
<settings>
  <mirrors>
    <mirror>
      <id>aliyun</id>
      <mirrorOf>central</mirrorOf>
      <name>Aliyun Maven</name>
      <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
  </mirrors>
</settings>
```

### Q: 如何配置代码风格？

1. `File` → `Settings` → `Editor` → `Code Style` → `Java`
2. 可以导入 Eclipse 或 Google Java Style 配置
3. 支持 `.editorconfig` 文件配置

### Q: 如何进行远程调试？

1. 在远程 JVM 启动参数中添加：
   ```
   -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005
   ```
2. 在 IDEA 中创建 `Remote JVM Debug` 配置
3. 设置远程主机地址和端口
4. 启动调试会话

### Q: 如何解决 "Cannot resolve symbol" 错误？

1. 检查 SDK 是否正确配置
2. `File` → `Invalidate Caches` → `Invalidate and Restart`
3. 右键项目 → `Maven` → `Reload Project`（Maven 项目）
4. 检查依赖是否正确下载

## 相关资源

- **官方网站**: https://www.jetbrains.com/idea/
- **官方文档**: https://www.jetbrains.com/help/idea/
- **快捷键参考**: https://www.jetbrains.com/help/idea/keyboard-shortcuts-by-keystroke.html
- **IntelliJ IDEA 教程**: https://www.jetbrains.com/idea/learn/
- **JetBrains 学生许可**: https://www.jetbrains.com/community/education/
- **插件仓库**: https://plugins.jetbrains.com/java
- **JetBrains 博客**: https://blog.jetbrains.com/idea/
- **Scoop 包管理器**: https://scoop.sh
