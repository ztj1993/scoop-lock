# Supervisord 使用指南

## 简介

Supervisord 是一个用 Go 语言编写的进程控制系统，它是 Python 版 Supervisor 的 Go 语言重新实现。

该工具用于监控和管理在操作系统上运行的进程，确保关键服务持续运行，并在进程异常退出时自动重启。

当前通过 Scoop 安装的版本为 **v0.7.3**，项目定位为 **"A process control system"**。

官方网站：https://github.com/ochinchina/supervisord

Supervisord 特别适用于管理需要长期运行的后台服务，如 Web 服务器、消息队列、数据库代理等。

在 Windows 环境下，Supervisord 可以配合 WinSW 将自身注册为 Windows 服务，实现开机自动启动。

与原版 Python Supervisor 相比，Go 版本无需 Python 运行时环境，部署更加简便，二进制文件更小。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v0.7.3                                |
| 类型       | 进程控制系统                          |
| 项目主页   | https://github.com/ochinchina/supervisord |
| 可执行文件 | supervisord.exe                       |
| 配置文件   | supervisord.conf                      |

### 核心特性

- 使用 Go 语言编写，无需额外运行时依赖
- 支持进程的启动、停止、重启和状态查询
- 提供 Web 管理界面，可通过浏览器管理进程
- 支持进程的自动重启和故障恢复
- 支持日志收集和轮转
- 兼容原版 Python Supervisor 的配置格式
- 可配合 WinSW 注册为 Windows 服务

## 主要功能

### 进程管理

Supervisord 的核心功能是管理子进程的生命周期。

可以同时管理多个进程，每个进程在配置文件中独立定义。

支持配置进程的启动命令、工作目录、环境变量等参数。

可以设置进程的优先级，决定启动和停止的顺序。

支持进程分组，将相关进程组织在一起进行管理。

### 自动重启策略

Supervisord 提供了灵活的进程重启策略，确保服务的高可用性。

可以配置进程在退出后是否自动重启（`autorestart` 参数）。

支持设置启动重试次数和重试间隔（`startretries` 和 `startsecs` 参数）。

可以指定在哪些退出码下触发重启，哪些退出码表示正常退出。

### 日志管理

每个被管理的进程都拥有独立的日志输出配置。

支持将 stdout 和 stderr 分别记录到不同文件。

可以配置日志文件的最大大小和轮转次数，防止日志文件无限增长。

日志文件路径可自定义，便于集中管理和归档。

Supervisord 自身的日志也可配置输出位置和级别。

### Web 管理界面

内置 HTTP 服务器，提供 Web 管理界面和 XML-RPC 接口。

可以通过浏览器远程查看和管理所有被监控的进程。

支持通过 Web 界面启动、停止和重启进程。

可以查看进程的实时日志输出。

默认监听在 127.0.0.1:9001，可在配置中修改。

### Windows 服务集成

在 Windows 环境下，Supervisord 可以通过 WinSW 注册为系统服务。

注册为服务后，Supervisord 将随系统自动启动，无需用户登录即可运行。

可以在 Windows 服务管理器（services.msc）中进行管理。

这使得被监控的进程也能实现开机自动运行。

## 常用操作

### 安装

通过 Scoop 安装 Supervisord：

```powershell
scoop install supervisord
```

安装完成后，`supervisord.exe` 会被添加到系统 PATH 中。

### 创建配置文件

Supervisord 使用 `supervisord.conf` 作为主配置文件。

以下是一个基础配置文件示例：

```ini
[unix_http_server]
file=./supervisor.sock

[inet_http_server]
port=127.0.0.1:9001
username=admin
password=admin123

[supervisord]
logfile=./supervisord.log
logfile_maxbytes=50MB
logfile_backups=10
loglevel=info
pidfile=./supervisord.pid
nodaemon=false

[rpcinterface:supervisor]
supervisor.rpcinterface_factory=supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix://./supervisor.sock
serverurl=http://127.0.0.1:9001

[program:myapp]
command=C:\\path\\to\\your\\app.exe
directory=C:\\path\\to\\your
autostart=true
autorestart=true
startsecs=10
startretries=3
stdout_logfile=./logs/myapp_stdout.log
stderr_logfile=./logs/myapp_stderr.log
stdout_logfile_maxbytes=50MB
stderr_logfile_maxbytes=50MB
```

### 配置文件详解

#### supervisord 配置段

```ini
[supervisord]
logfile=./supervisord.log
logfile_maxbytes=50MB
logfile_backups=10
loglevel=info
pidfile=./supervisord.pid
nodaemon=false
```

主要参数说明：
- `logfile`：Supervisord 主进程日志路径
- `logfile_maxbytes`：单个日志文件最大大小
- `logfile_backups`：保留的日志备份数量
- `loglevel`：日志级别（critical/error/warn/info/debug/trace）
- `pidfile`：PID 文件路径
- `nodaemon`：是否以非守护进程模式运行

#### program 配置段

```ini
[program:myapp]
command=C:\\path\\to\\your\\app.exe arg1 arg2
directory=C:\\path\\to\\your
environment=KEY1="value1",KEY2="value2"
autostart=true
autorestart=true
startsecs=10
startretries=3
priority=999
user=SYSTEM
stdout_logfile=./logs/myapp_stdout.log
stderr_logfile=./logs/myapp_stderr.log
```

主要参数说明：
- `command`：要执行的命令
- `directory`：工作目录
- `environment`：环境变量
- `autostart`：Supervisord 启动时是否自动启动该进程
- `autorestart`：进程退出后是否自动重启（true/false/unexpected）
- `startsecs`：进程启动后保持运行多少秒算作启动成功
- `startretries`：启动失败后的最大重试次数
- `priority`：启动优先级，数值越小越先启动

#### group 配置段

```ini
[group:webapps]
programs=app1,app2,app3
priority=999
```

### 启动 Supervisord

以默认配置启动：

```powershell
supervisord
```

指定配置文件路径：

```powershell
supervisord -c C:\path\to\supervisord.conf
```

以非守护进程模式启动（前台运行）：

```powershell
supervisord -n
```

### 使用 supervisordctl 管理进程

Supervisord 提供了内置的命令行管理功能。

查看所有进程状态：

```powershell
supervisord ctl status
```

启动指定进程：

```powershell
supervisord ctl start myapp
```

停止指定进程：

```powershell
supervisord ctl stop myapp
```

重启指定进程：

```powershell
supervisord ctl restart myapp
```

停止所有进程：

```powershell
supervisord ctl stop all
```

### 配置 WinSW 实现 Windows 服务

创建 WinSW XML 配置文件 `supervisord-service.xml`：

```xml
<service>
  <id>supervisord</id>
  <name>Supervisord Process Manager</name>
  <description>Supervisord 进程管理系统服务</description>
  <executable>%BASE%\supervisord.exe</executable>
  <arguments>-c %BASE%\supervisord.conf</arguments>
  <logpath>%BASE%\logs</logpath>
  <logmode>rotate</logmode>
</service>
```

安装服务：

```powershell
WinSW install supervisord-service.xml
```

启动服务：

```powershell
net start supervisord
```

### Web 管理界面使用

启动 Supervisord 后，如果配置了 `inet_http_server`，可以通过浏览器访问管理界面。

打开浏览器访问：`http://127.0.0.1:9001`

在 Web 界面中可以：
- 查看所有进程的运行状态
- 启动、停止、重启单个进程
- 查看进程的日志输出
- 查看 Supervisord 系统信息

## 常见问题

### 进程启动后立即退出

**问题**：配置的进程启动后很快退出，Supervisord 反复重启。

**解决方法**：
- 检查 `command` 路径是否正确，确认可执行文件存在
- 手动在命令行运行相同的命令，查看是否有错误输出
- 增大 `startsecs` 的值，给进程更多启动时间
- 检查 `startretries` 设置，避免无限重启
- 查看进程的 stderr 日志获取错误详情

### 配置文件路径问题

**问题**：Windows 系统中路径分隔符导致配置错误。

**解决方法**：
- 在配置文件中使用双反斜杠 `\\` 或正斜杠 `/`
- 使用绝对路径，避免相对路径解析问题
- 确保 `directory` 参数指向正确的目录

### 日志文件无法写入

**问题**：进程启动后日志文件为空或未创建。

**解决方法**：
- 确保日志目录存在且有写入权限
- 检查路径中是否包含特殊字符
- 使用绝对路径指定日志文件位置
- 确认磁盘空间充足

### Web 管理界面无法访问

**问题**：启动 Supervisord 后无法通过浏览器访问管理界面。

**解决方法**：
- 确认配置文件中 `inet_http_server` 配置段存在
- 检查端口是否被其他程序占用
- 确认防火墙未阻止该端口
- 尝试使用 `127.0.0.1:9001` 而非 `localhost:9001`

### 环境变量传递失败

**问题**：进程无法接收到配置中设置的环境变量。

**解决方法**：
- 检查 `environment` 参数的格式是否正确
- 确保环境变量值中的特殊字符已正确转义
- 在程序中打印环境变量进行验证

### 多实例冲突

**问题**：同一台机器上运行多个 Supervisord 实例时出现冲突。

**解决方法**：
- 为每个实例使用不同的配置文件
- 确保每个实例使用不同的端口和 socket 文件
- 使用不同的 PID 文件路径
- 为每个实例使用不同的日志目录

## 相关资源

### 官方资源

- GitHub 仓库：https://github.com/ochinchina/supervisord
- 问题反馈：https://github.com/ochinchina/supervisord/issues
- 发布页面：https://github.com/ochinchina/supervisord/releases

### Supervisor 原版参考

- Python Supervisor 官方文档：http://supervisord.org/
- Supervisor 配置详解：http://supervisord.org/configuration.html
- Supervisor 进程配置：http://supervisord.org/configuration.html#program-x-section-settings

### WinSW 相关

- WinSW GitHub 仓库：https://github.com/winsw/winsw
- WinSW 文档：https://github.com/winsw/winsw/blob/master/doc/installation.md

### 社区资源

- Scoop 主仓库：https://github.com/ScoopInstaller/Main
- Supervisord Go 包：https://pkg.go.dev/github.com/ochinchina/supervisord

### 相关工具推荐

- **PM2**：Node.js 进程管理工具，功能类似
- **NSSM**：Windows 服务管理工具，可将任意程序注册为服务
- **WinSW**：Windows 服务包装器，与 Supervisord 配合使用
- **systemd**：Linux 系统的进程管理器（Linux 环境下的替代方案）
