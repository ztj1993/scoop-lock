# GoLand 使用指南

## 简介

GoLand 是 JetBrains 公司推出的一款专业 Go 语言集成开发环境（IDE），基于 IntelliJ 平台构建。
GoLand v2021.2.2 提供了智能代码补全、代码导航、快速重构、强大的调试器和集成测试运行器等
功能，是 Go 语言开发者最主流的 IDE 选择之一。

GoLand 是一款商业软件（Proprietary），提供 30 天免费试用期。教育机构用户可以申请免费教育许可。
通过 Scoop 安装后，使用 `goland64.exe` 快捷方式启动。

作为 JetBrains 产品线的一员，GoLand 延续了 IntelliJ 系列 IDE 的优秀体验，提供了开箱即用的
Go 开发支持，无需复杂的插件配置即可获得完整的 Go 开发工具链。

- **版本**: v2021.2.2
- **许可证**: Proprietary（商业许可）
- **官方网站**: https://www.jetbrains.com/goland/
- **安装方式**: Scoop 包管理器

## 主要功能

### 智能代码编辑

GoLand 提供业界领先的代码编辑能力：

- **智能补全**: 基于类型和上下文的代码补全，理解 Go 的接口、结构体等类型系统
- **代码模板**: 内置常用的 Go 代码模板（Live Templates），如 `iferr`、`forr` 等
- **语法高亮**: 支持 Go 语言的所有语法特性，包括泛型（Go 1.18+）
- **代码格式化**: 支持 gofmt 和 goimports 自动格式化
- **代码检查**: 实时检测代码中的潜在问题和不符合最佳实践的写法
- **快速修复**: 自动建议并应用代码修复方案

### 代码导航

快速在代码间跳转和查找：

- **Go to Definition**: 跳转到变量、函数、类型的定义处
- **Find Usages**: 查找符号的所有使用位置
- **Go to Implementation**: 跳转到接口的具体实现
- **File Structure**: 查看当前文件的结构大纲
- **Type Hierarchy**: 查看类型的继承层次
- **Call Hierarchy**: 查看函数的调用层次
- **Breadcrumb Navigation**: 文件路径导航栏

### 重构工具

GoLand 提供安全可靠的重构功能：

- **Rename**: 安全地重命名变量、函数、类型、包
- **Extract Variable/Function**: 提取变量或函数
- **Extract Interface**: 从结构体提取接口
- **Inline**: 内联变量或函数
- **Move**: 移动符号到其他文件或包
- **Change Signature**: 修改函数签名
- **Introduce Parameter**: 引入新参数

### 调试器

集成强大的调试工具：

- 断点管理（普通断点、条件断点、日志断点）
- 变量监视和表达式求值
- 调用栈查看
- Goroutine 列表和切换
- 内存视图
- 远程调试支持
- Docker 和 Kubernetes 调试支持

### 测试与覆盖率

- 集成 go test 测试运行器
- 支持表驱动测试的便捷运行
- 测试覆盖率分析和可视化
- 基准测试（Benchmark）支持
- 支持 Testify 等测试框架
- 覆盖率报告导出

### 数据库工具

内置数据库管理工具：

- 支持 MySQL、PostgreSQL、SQLite、MongoDB 等
- SQL 编辑和执行
- 数据查看和编辑
- 数据库结构浏览
- 数据导入导出
- ER 图生成

### 版本控制集成

深度集成主流版本控制系统：

- Git、GitHub、GitLab、Bitbucket
- SVN、Mercurial
- 可视化差异对比
- 分支管理和合并工具
- 提交前代码审查
- GitHub Pull Request 支持

### Docker 与 Kubernetes 集成

- Docker 容器管理和日志查看
- Docker Compose 支持
- Kubernetes 集群浏览
- Helm Chart 编辑
- 远程开发支持

## 常用命令/操作

### 启动 GoLand

通过 Scoop 安装后，使用以下方式启动：

```bash
goland64
```

也可以在开始菜单或 Scoop 快捷方式中找到 GoLand 快捷启动项。

命令行启动并打开指定项目：

```bash
goland64 C:\path\to\project
```

命令行启动并打开指定文件：

```bash
goland64 C:\path\to\file.go
```

### 快捷键参考

GoLand 遵循 JetBrains 标准快捷键方案，以下是常用快捷键：

**通用操作：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Shift+A` | 查找操作（Action） |
| `Ctrl+Shift+F12` | 隐藏所有工具窗口，最大化编辑器 |
| `Double Shift` | 全局搜索（Search Everywhere） |
| `Ctrl+N` | 查找类 |
| `Ctrl+Shift+N` | 查找文件 |
| `Ctrl+Alt+Shift+N` | 查找符号 |
| `Alt+1` | 打开项目工具窗口 |
| `Alt+F12` | 打开终端 |

**代码编辑：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+Space` | 基本代码补全 |
| `Ctrl+Shift+Space` | 智能代码补全 |
| `Ctrl+Shift+Enter` | 补全当前语句 |
| `Ctrl+Alt+L` | 格式化代码 |
| `Ctrl+/` | 行注释 |
| `Ctrl+Shift+/` | 块注释 |
| `Ctrl+D` | 复制当前行 |
| `Ctrl+Y` | 删除当前行 |
| `Ctrl+W` | 扩展选区 |
| `Alt+Enter` | 显示意图操作和快速修复 |
| `Ctrl+Alt+V` | 提取变量 |
| `Ctrl+Alt+M` | 提取函数 |

**导航：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+B` | 跳转到定义 |
| `Ctrl+Shift+B` | 跳转到类型定义 |
| `Ctrl+U` | 跳转到父类/方法 |
| `Alt+Left/Right` | 切换标签页 |
| `Ctrl+G` | 跳转到行 |
| `Ctrl+E` | 最近文件 |
| `Ctrl+Shift+E` | 最近编辑位置 |
| `Ctrl+Alt+Left` | 导航后退 |
| `Ctrl+Alt+Right` | 导航前进 |

**调试：**

| 快捷键 | 功能 |
|--------|------|
| `F8` | 单步跳过（Step Over） |
| `F7` | 单步进入（Step Into） |
| `Shift+F8` | 单步跳出（Step Out） |
| `F9` | 继续运行（Resume） |
| `Ctrl+F8` | 切换断点 |
| `Shift+F9` | 调试模式运行 |
| `Shift+F10` | 运行模式运行 |
| `Ctrl+F2` | 停止运行 |

**版本控制：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+K` | 提交更改 |
| `Ctrl+Shift+K` | 推送更改 |
| `Ctrl+T` | 拉取更改 |
| `Alt+Shift+C` | 查看最近更改 |
| `Ctrl+Alt+A` | 添加到 Git |

### 配置 Go SDK

首次使用 GoLand 时，需要配置 Go SDK：

1. 打开 GoLand → `File` → `Settings` → `Go` → `GOROOT`
2. 选择 Go 安装路径（通常由 Scoop 自动管理）
3. 在 `Go` → `GOPATH` 中配置项目工作区路径

### 运行与调试配置

创建运行配置：

1. 点击右上角的运行配置下拉框
2. 选择 `Edit Configurations`
3. 点击 `+` 添加 `Go Build` 或 `Go Test` 配置
4. 指定入口文件、程序参数、环境变量等

### 插件管理

通过 `File` → `Settings` → `Plugins` 管理插件：

推荐插件：
- **Protocol Buffers**: Protobuf 文件支持
- **Database Tools**: 数据库管理
- **Docker**: Docker 集成
- **Kubernetes**: K8s 支持
- **Makefile Language**: Makefile 支持
- **Rainbow Brackets**: 彩色括号匹配
- **Key Promoter X**: 快捷键学习提示

## 常见问题

### Q: GoLand 提示 "Go SDK not found"

确保已安装 Go 语言并配置了 GOPATH 和 GOROOT 环境变量：
1. 打开 `Settings` → `Go` → `GOROOT`
2. 手动指定 Go 安装目录

### Q: 如何配置代理加速 Go 模块下载？

在终端中设置 Go 代理：

```bash
go env -w GOPROXY=https://goproxy.cn,direct
```

或在 GoLand 的 `Settings` → `Go` → `Go Modules` 中配置。

### Q: 代码补全不工作怎么办？

1. 检查 Go SDK 是否正确配置
2. 确认项目已正确初始化（`go mod init`）
3. 尝试 `File` → `Invalidate Caches` → `Invalidate and Restart`
4. 检查索引是否正在构建（右下角进度条）

### Q: 如何配置代码风格？

1. 打开 `Settings` → `Editor` → `Code Style` → `Go`
2. 推荐使用 gofmt 默认风格
3. 可以勾选 `On Save` → `Reformat code` 实现保存时自动格式化

### Q: 如何激活 GoLand？

- 30 天免费试用
- 购买商业许可证
- 学生/教师可申请免费教育许可
- 开源项目维护者可申请免费开源许可

### Q: 内存不足导致 IDE 卡顿？

1. 打开 `Help` → `Change Memory Settings`
2. 增加最大堆内存（建议 2048MB 或更高）
3. 重启 IDE 使设置生效

### Q: 如何进行远程调试？

1. 在远程服务器上使用 `dlv` 启动调试服务器
2. 在 GoLand 中创建 `Go Remote` 调试配置
3. 填入远程服务器地址和端口
4. 启动调试会话

## 相关资源

- **官方网站**: https://www.jetbrains.com/goland/
- **官方文档**: https://www.jetbrains.com/help/goland/
- **快捷键参考**: https://www.jetbrains.com/help/goland/keyboard-shortcuts-by-keystroke.html
- **Go 语言官网**: https://go.dev
- **Go 语言中文网**: https://studygolang.com
- **JetBrains 学生许可**: https://www.jetbrains.com/community/education/
- **GoLand 插件仓库**: https://plugins.jetbrains.com/go
- **Scoop 包管理器**: https://scoop.sh
