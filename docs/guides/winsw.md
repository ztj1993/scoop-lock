# WinSW 使用指南

## 简介

WinSW（Windows Service Wrapper）是一个 Windows 服务包装器，可以将任何可执行文件作为 Windows 服务运行。

它解决了在 Windows 上将普通应用程序注册为系统服务的难题，无需编写额外的服务代码。

当前通过 Scoop 安装的版本为 **v3.0.0-alpha.11**，采用 **MIT** 许可证。

项目定位为 **"A wrapper executable that can be used to host any executable as a Windows service"**。

官方网站：https://github.com/winsw/winsw

WinSW 是许多开源项目在 Windows 上运行的重要基础设施。

V2Ray、Supervisord、Elasticsearch 等项目都依赖 WinSW 来实现 Windows 服务功能。

注册为 Windows 服务后，应用程序可以随系统自动启动，无需用户登录即可在后台运行。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v3.0.0-alpha.11                       |
| 许可证     | MIT                                   |
| 项目主页   | https://github.com/winsw/winsw       |
| 可执行文件 | WinSW.exe                             |

### 工作原理

WinSW 通过 XML 配置文件定义服务的行为，包括要运行的程序、参数、日志等。

当用户将 WinSW 可执行文件重命名为与 XML 配置文件相同的名称时，WinSW 会自动加载对应的配置。

例如，将 `WinSW.exe` 复制为 `myapp.exe`，同时创建 `myapp.xml` 配置文件。

WinSW 会读取 `myapp.xml` 中的配置，将指定的程序作为 Windows 服务管理。

### 使用场景

- 将命令行工具（如 V2Ray、Node.js 应用）注册为 Windows 服务
- 将 Java 应用程序作为服务运行（如 Elasticsearch、Jenkins）
- 将 Python 脚本作为服务运行
- 将任何需要长期运行的进程包装为 Windows 服务

## 主要功能

### 服务注册与管理

WinSW 的核心功能是将普通可执行文件注册为 Windows 服务。

支持通过命令行安装、卸载、启动和停止服务。

可以为服务设置启动类型（自动、手动、禁用）。

支持设置服务的恢复策略（失败后重启、重启延迟等）。

可以配置服务的依赖关系，确保服务按正确顺序启动。

### 灵活的配置选项

使用 XML 格式的配置文件，支持丰富的配置选项。

可以指定可执行文件路径、命令行参数和工作目录。

支持设置环境变量，为服务程序提供必要的运行环境。

可以配置服务的账户身份（LocalSystem、特定用户等）。

支持自定义服务名称、显示名称和描述信息。

### 日志管理

WinSW 提供了完善的日志管理功能。

支持将服务的标准输出和标准错误重定向到日志文件。

提供多种日志模式：
- `append`：追加模式，日志持续写入同一文件
- `rotate`：轮转模式，按大小或时间自动轮转
- `reset`：每次服务启动时清空日志
- `none`：不记录日志

可以设置日志文件的大小上限和保留数量。

### 生命周期管理

支持配置服务的启动和停止行为。

可以设置启动延迟（`starttime`），等待依赖服务就绪。

支持优雅停止（`stoptimeout`），给服务足够的时间完成清理。

可以配置停止父进程时同时停止子进程（`stopparentprocessfirst`）。

支持服务挂起检测和自动重启。

### 扩展功能

WinSW v3 版本引入了更多现代化功能。

支持 YAML 格式的配置文件（除 XML 外）。

内置 HTTP 服务器，支持健康检查端点。

支持计划任务（Scheduled Task）配置。

提供 .NET 扩展机制，支持自定义启动/停止前后的操作。

## 常用操作

### 安装

通过 Scoop 安装 WinSW：

```powershell
scoop install winsw
```

安装完成后，`WinSW.exe` 会被添加到系统 PATH 中。

### 创建配置文件

WinSW 使用 XML 配置文件来定义服务行为。配置文件必须与 WinSW 可执行文件同名。

假设要将 `myapp.exe` 注册为服务：

1. 复制 WinSW.exe 为 myapp.exe：

```powershell
Copy-Item (Get-Command WinSW).Source .\myapp.exe
```

2. 创建 myapp.xml 配置文件：

```xml
<service>
  <id>myapp</id>
  <name>My Application</name>
  <description>我的应用程序服务</description>
  <executable>%BASE%\myapp.exe</executable>
  <arguments>--config %BASE%\config.json</arguments>
  <workingdirectory>%BASE%</workingdirectory>
  <logpath>%BASE%\logs</logpath>
  <log mode="rotate">
    <sizeThreshold>10240</sizeThreshold>
    <keepFiles>8</keepFiles>
  </log>
  <onfailure action="restart" delay="10 sec"/>
  <onfailure action="restart" delay="20 sec"/>
  <onfailure action="none"/>
  <resetfailure>1 hour</resetfailure>
</service>
```

### 配置文件详解

#### 基本配置

```xml
<service>
  <id>myapp</id>
  <name>My Application</name>
  <description>我的应用程序</description>
  <executable>C:\path\to\app.exe</executable>
  <arguments>arg1 arg2</arguments>
  <workingdirectory>C:\path\to</workingdirectory>
</service>
```

主要元素说明：
- `id`：服务的唯一标识符，用于命令行操作
- `name`：服务的显示名称
- `description`：服务描述
- `executable`：要运行的可执行文件路径
- `arguments`：传递给可执行文件的命令行参数
- `workingdirectory`：工作目录

#### 日志配置

```xml
<logpath>C:\logs\myapp</logpath>
<log mode="rotate">
  <sizeThreshold>10240</sizeThreshold>
  <keepFiles>8</keepFiles>
</log>
```

日志模式选项：
- `append`：追加到日志文件
- `rotate`：按大小轮转
- `reset`：每次启动清空
- `none`：不记录

#### 环境变量

```xml
<env name="JAVA_HOME" value="C:\Java\jdk17"/>
<env name="APP_ENV" value="production"/>
```

#### 启动失败恢复

```xml
<onfailure action="restart" delay="10 sec"/>
<onfailure action="restart" delay="20 sec"/>
<onfailure action="none"/>
<resetfailure>1 hour</resetfailure>
```

`action` 可以是 `restart`（重启）、`reboot`（重启计算机）或 `none`（不操作）。

#### 安全配置

```xml
<serviceaccount>
  <domain>NT AUTHORITY</domain>
  <user>SYSTEM</user>
  <allowservicelogon>true</allowservicelogon>
</serviceaccount>
```

### 安装服务

使用 WinSW 的 install 命令注册服务：

```powershell
.\myapp.exe install
```

或者直接使用 WinSW.exe 指定配置文件：

```powershell
WinSW.exe install myapp.xml
```

### 卸载服务

```powershell
.\myapp.exe uninstall
```

### 启动服务

```powershell
.\myapp.exe start
```

或者使用 Windows 服务管理器：

```powershell
net start myapp
```

### 停止服务

```powershell
.\myapp.exe stop
```

或者：

```powershell
net stop myapp
```

### 重启服务

```powershell
.\myapp.exe restart
```

### 查看服务状态

```powershell
.\myapp.exe status
```

### 测试模式运行

在不注册为服务的情况下测试运行：

```powershell
.\myapp.exe test
```

### 自定义日志配置

使用 roll-by-size 模式（按大小轮转）：

```xml
<log mode="roll-by-size">
  <sizeThreshold>51200</sizeThreshold>
  <keepFiles>5</keepFiles>
</log>
```

使用 roll-by-time 模式（按时间轮转）：

```xml
<log mode="roll-by-time">
  <pattern>yyyyMMdd</pattern>
  <autoRollAtTime>00:00:00</autoRollAtTime>
  <timeToKeepFiles>30</timeToKeepFiles>
</log>
```

## 常见问题

### 安装服务失败

**问题**：运行 `install` 命令后提示权限不足或安装失败。

**解决方法**：
- 以管理员权限运行命令提示符
- 确认服务 ID 不与现有服务冲突
- 检查配置文件中的路径是否正确
- 确认可执行文件存在且可访问

### 服务启动后立即停止

**问题**：服务启动后很快停止，日志中没有输出。

**解决方法**：
- 确认可执行文件路径正确
- 检查工作目录是否存在
- 以命令行方式手动运行相同的程序查看是否正常
- 查看 Windows 事件查看器中的系统日志
- 增加启动超时时间

### 日志文件为空

**问题**：服务运行正常但日志文件为空或未创建。

**解决方法**：
- 确认日志目录存在且有写入权限
- 检查 `logpath` 配置是否正确
- 确认日志模式不为 `none`
- 确认程序的输出确实写入了 stdout/stderr

### 配置文件中的路径问题

**问题**：Windows 路径中的特殊字符导致配置解析错误。

**解决方法**：
- 在 XML 中使用正斜杠 `/` 代替反斜杠 `\`
- 使用 `%BASE%` 变量引用 WinSW 所在目录
- 路径中包含空格时使用引号
- 特殊字符需要进行 XML 转义

### 服务无法访问网络

**问题**：作为服务运行时无法访问网络资源。

**解决方法**：
- 检查服务运行账户是否有网络访问权限
- 确认 Windows 防火墙未阻止该服务
- 如果使用 LocalSystem 账户，可能需要配置代理设置
- 考虑使用特定用户账户运行服务

### 多个服务冲突

**问题**：同一台机器上注册多个 WinSW 服务时出现冲突。

**解决方法**：
- 确保每个服务使用不同的 ID
- 每个服务使用独立的可执行文件副本
- 使用独立的配置文件和日志目录
- 避免端口冲突

### 更新 WinSW 版本

**问题**：需要更新 WinSW 到新版本但不想重新注册服务。

**解决方法**：
- 停止相关服务
- 替换 WinSW.exe 文件（或重命名后的副本）
- 保留原有的 XML 配置文件
- 重新启动服务

## 相关资源

### 官方资源

- GitHub 仓库：https://github.com/winsw/winsw
- 官方文档：https://github.com/winsw/winsw/blob/master/doc/installation.md
- XML 配置参考：https://github.com/winsw/winsw/blob/master/doc/xmlConfigFile.md
- 发布页面：https://github.com/winsw/winsw/releases
- 问题反馈：https://github.com/winsw/winsw/issues

### 使用示例

- V2Ray + WinSW：将 V2Ray 注册为 Windows 服务
- Supervisord + WinSW：将 Supervisord 注册为 Windows 服务
- Jenkins + WinSW：Jenkins 使用 WinSW 作为服务包装器
- Elasticsearch + WinSW：Elasticsearch 使用 WinSW 管理服务

### 社区资源

- Stack Overflow 上的 WinSW 相关问题：https://stackoverflow.com/questions/tagged/winsw
- Scoop Main 仓库：https://github.com/ScoopInstaller/Main

### 相关工具推荐

- **NSSM**（Non-Sucking Service Manager）：另一个流行的 Windows 服务包装工具
- **SC.exe**：Windows 内置的服务管理命令
- **srvany.exe**：Windows Resource Kit 中的服务包装工具（已过时）
- **WinSW v2**：WinSW 的稳定版分支，适合生产环境使用
- **Process Explorer**：Sysinternals 出品的进程管理工具，可用于调试服务
