# scoop-lock

个人使用的 Scoop bucket，用于锁定常用软件版本，并对国内网络环境下的安装体验做了一些默认优化。

## 快速开始

### 添加 Bucket

```powershell
scoop bucket add main https://github.com/ztj1993/scoop-lock.git
```

### 安装软件

```powershell
scoop install git
scoop install uv
```

### 常用命令

```powershell
# 安装应用时不更新 Scoop
scoop install chrome --no-update-scoop

# 更新指定应用
scoop update main/7zip

# 将自动更新检测时间设置到很远，避免每次命令都触发 Scoop 自更新
scoop config last_update "2099-01-01 00:00:00"
```

## 初始化 Scoop

如果当前机器还没有安装 Scoop，可以直接运行仓库提供的安装脚本。脚本会安装 Scoop，并把本仓库作为 `main` bucket 放到默认目录。

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
irm https://raw.githubusercontent.com/ztj1993/scoop-lock/master/install.ps1 | iex
```

如需强制重新安装 Scoop 或重新覆盖本 bucket：

```powershell
$env:FORCE_SCOOP = 1
$env:FORCE_MAIN_BUCKET = 1
irm https://raw.githubusercontent.com/ztj1993/scoop-lock/master/install.ps1 | iex
```

## 安装脚本环境变量

| 变量 | 说明 | 默认值 |
| --- | --- | --- |
| `SCOOP_PACKAGE_REPO` | Scoop 安装包下载地址 | `https://ghfast.top/https://github.com/ScoopInstaller/Scoop/archive/master.zip` |
| `SCOOP_APP_DIR` | Scoop 安装目录 | `$env:USERPROFILE\scoop\apps\scoop\current` |
| `SCOOP_MAIN_BUCKET_REPO` | 本 bucket 下载地址 | `https://ghfast.top/https://github.com/ztj1993/scoop-lock/archive/master.zip` |
| `SCOOP_MAIN_BUCKET_DIR` | 本 bucket 安装目录 | `$env:USERPROFILE\scoop\buckets\main` |
| `FORCE_SCOOP` | 强制重新安装 Scoop | 空值表示不强制 |
| `FORCE_MAIN_BUCKET` | 强制重新安装本 bucket | 空值表示不强制 |

示例：使用 GitHub 原始地址安装 Scoop。

```powershell
$env:SCOOP_PACKAGE_REPO = "https://github.com/ScoopInstaller/Scoop/archive/master.zip"
irm https://raw.githubusercontent.com/ztj1993/scoop-lock/master/install.ps1 | iex
```

## 常用运行时安装

### Python

```powershell
scoop install uv

uv python install 3.8
uv python install 3.13

python3.8 --version
python3.13 --version
```

### Go

```powershell
scoop install g

g install 1.18
g install 1.23
g use 1.23

go version
```

### Node.js

```powershell
scoop install nvm

nvm install lts
nvm use lts

node --version
```

## 本仓库软件清单

### 开发工具

| 软件 | 描述 |
| --- | --- |
| 7zip | 多格式文件压缩工具，具有较高压缩率 |
| git | 分布式版本控制系统 |
| g | Go 多版本管理和切换工具 |
| nvm | Windows 版 Node.js 版本管理工具 |
| uv | 使用 Rust 编写的 Python 包管理和运行时管理工具 |
| yarn | Node.js 依赖管理器 |
| gradle | 开源构建自动化工具 |
| gcc | GNU 编译器集合和 binutils |
| msys2 | Windows 软件发行版和构建平台 |
| innounp | Inno Setup 解包工具 |
| dark | WiX Toolset 反编译器 |
| supervisord | 进程管理工具 |

### 编辑器 / IDE

| 软件 | 描述 |
| --- | --- |
| notepadplusplus | 免费源代码编辑器和 Notepad 替代品 |

### 网络 / 代理工具

| 软件 | 描述 |
| --- | --- |
| aria2 | 轻量级多协议多源命令行下载工具 |
| clash-verge-rev | Clash Verge 延续版图形客户端 |
| easytier | 去中心化网格 VPN，CLI 版 |
| easytier-gui | 去中心化网格 VPN，GUI 版 |
| tun2socks | 将网络流量通过 SOCKS 代理转发 |

### 数据库 / 消息队列

| 软件 | 描述 |
| --- | --- |
| redis | 内存数据结构存储，可用作数据库、缓存和消息代理 |

### 远程 / 终端工具

| 软件 | 描述 |
| --- | --- |
| putty | SSH 和 Telnet 客户端 |
| winscp | 支持 FTP、FTPS、SCP、SFTP、WebDAV、S3 的文件传输工具 |
| windterm | SSH / SFTP / Shell / Telnet / Serial 客户端 |

### 实用工具

| 软件 | 描述 |
| --- | --- |
| powertoys | Windows 高级用户实用工具集 |
| rufus | 创建可启动 USB 闪存驱动器的工具 |
| switchhosts | Hosts 管理和切换工具 |
| vcredist-aio | Microsoft Visual C++ 可再发行运行时合集 |
| sudo | 类 Unix `sudo` 命令实现 |

### 开发辅助

| 软件 | 描述 |
| --- | --- |
| docker-compose | 使用 Docker 定义和运行多容器应用 |
| reqable | API 调试代理 |
| sourcegit | 开源 Git GUI 客户端 |
| cc-switch | Claude Code、Codex 和 Gemini CLI 的桌面一体化助手 |

### 已弃用 / 旧版本

| 软件 | 描述 |
| --- | --- |
| go118 | Go 1.18 |
| go121 | Go 1.21 |
| nodejs | Node.js 旧版 manifest |
| nodejs16 | Node.js 16 |
| python27 | Python 2.7 |
| python311 | Python 3.11 |
| python37 | Python 3.7 |
| python38 | Python 3.8 |
| sourcetree | Git GUI 客户端 |
| vcredist2005 | Visual C++ 2005 运行时 |
| vcredist2008 | Visual C++ 2008 运行时 |
| vcredist2010 | Visual C++ 2010 运行时 |
| vcredist2012 | Visual C++ 2012 运行时 |
| vcredist2013 | Visual C++ 2013 运行时 |
| vcredist2022 | Visual C++ 2022 运行时 |

## 归档软件 (archive)

以下软件已移动到 `archive` 目录，不常用但仍可安装：

```powershell
# 从 archive 目录安装软件
scoop install main/archive/<软件名>
```

### 开发工具

| 软件 | 描述 |
| --- | --- |
| adb | Android SDK 平台工具 |
| aliyun-cli | 阿里云命令行工具 |
| android-studio | Android 官方开发 IDE |
| claude | Claude CLI |
| claude-code | Claude Code 命令行开发工具 |
| codex | OpenAI Codex 命令行开发工具 |
| composer | PHP 依赖管理器 |
| gradle | 开源构建自动化工具 |
| protobuf | 用于编译 `.proto` 文件的协议编译器 |
| yarn | Node.js 依赖管理器 |

### 编辑器 / IDE

| 软件 | 描述 |
| --- | --- |
| DataGrip | JetBrains 数据库和 SQL IDE |
| GoLand | JetBrains Go IDE |
| hbuilderx | DCloud 出品的 Web / UniApp 开发 IDE |
| IntelliJ-IDEA | JetBrains Java IDE 旗舰版 |
| PhpStorm | JetBrains PHP IDE |
| PyCharm2021 | JetBrains PyCharm 专业版旧版本 |
| pycharm | JetBrains 跨平台 Python IDE |
| WebStorm | JetBrains JavaScript / TypeScript IDE |

### 网络 / 代理工具

| 软件 | 描述 |
| --- | --- |
| brook | 面向开发者的跨平台代理工具 |
| ddns-go | 自动更新 DNS 解析的 DDNS 工具 |
| frp | 快速反向代理 |
| nginx | HTTP 和反向代理服务器 |
| sing-box | 通用代理平台 |
| v2ray | 代理平台核心 |
| xray | 代理平台核心 |

### 数据库 / 消息队列

| 软件 | 描述 |
| --- | --- |
| elasticsearch | 分布式 RESTful 搜索引擎 |
| mongodb | 文档数据库 |
| mosquitto | MQTT 消息代理 |
| mysql57 | MySQL 5.7 数据库 |
| rabbitmq | 消息代理 |
| sqlitebrowser | SQLite 数据库浏览器 |

### 远程 / 终端工具

| 软件 | 描述 |
| --- | --- |
| virt-viewer | 虚拟机控制台查看器 |
| xpra | 持久化远程显示服务器和客户端 |

### 实用工具

| 软件 | 描述 |
| --- | --- |
| diskgenius | 数据恢复、磁盘分区管理工具 |
| guipropview | 查看系统打开窗口的详细属性 |
| NatTypeTester | NAT 类型测试工具 |
| picpick | 屏幕截图、图像编辑和取色工具 |
| winsw | 将可执行文件包装为 Windows 服务的工具 |

### 开发辅助

| 软件 | 描述 |
| --- | --- |
| postman | API 开发和调试环境 |

### 云存储工具

| 软件 | 描述 |
| --- | --- |
| kodo-browser | 七牛对象存储图形化管理工具 |
| oss-browser | 阿里云 OSS 文件管理器 |

### 浏览器

| 软件 | 描述 |
| --- | --- |
| chromium | Chromium 浏览器 |

### 文档工具

| 软件 | 描述 |
| --- | --- |
| pdf-xchange-editor | PDF 查看器和编辑器 |

### 目录服务

| 软件 | 描述 |
| --- | --- |
| ldap-admin | LDAP 客户端和目录管理工具 |

### 编程语言 / 运行时

| 软件 | 描述 |
| --- | --- |
| erlang | 用于构建大规模可扩展软实时系统的编程语言 |
| php73 | PHP 7.3 运行时 |
| php73-xdebug | PHP 7.3 的 Xdebug 扩展 |

### 文件比较

| 软件 | 描述 |
| --- | --- |
| BeyondCompare3 | 文件和文件夹比较工具 |

### 数据库管理

| 软件 | 描述 |
| --- | --- |
| navicat16 | 数据库管理工具 |

### 虚拟化工具

| 软件 | 描述 |
| --- | --- |
| ovftool | VMware OVF 工具 |

### 桌面应用

| 软件 | 描述 |
| --- | --- |
| opencode-desktop | OpenCode 桌面客户端 |

## 参考 Bucket

官方 bucket：

- [ScoopInstaller/Main](https://github.com/ScoopInstaller/Main)
- [ScoopInstaller/Extras](https://github.com/ScoopInstaller/Extras)
- [ScoopInstaller/Java](https://github.com/ScoopInstaller/Java)
- [ScoopInstaller/PHP](https://github.com/ScoopInstaller/PHP)
- [ScoopInstaller/Versions](https://github.com/ScoopInstaller/Versions)

社区 bucket：

- [Ash258/Scoop-JetBrains](https://github.com/Ash258/Scoop-JetBrains)
- [TheRandomLabs/scoop-nonportable](https://github.com/TheRandomLabs/scoop-nonportable)

## Manifest 编写提示

常用路径变量：

```powershell
$dir          # 当前应用安装目录
$bucketsdir   # Scoop buckets 根目录，例如 $env:USERPROFILE\scoop\buckets
$PSScriptRoot # 当前脚本所在目录
```
