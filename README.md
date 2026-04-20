# scoop
我个人使用的软件版本锁定，同时针对 China 的一些参数配置。

## 使用
```
scoop bucket add main https://github.com/ztj1993/scoop-lock.git
```

## 官方软件清单
- https://github.com/ScoopInstaller/Main
- https://github.com/ScoopInstaller/Extras
- https://github.com/ScoopInstaller/Java
- https://github.com/ScoopInstaller/PHP
- https://github.com/ScoopInstaller/Versions

## 推荐社区清单
- https://github.com/Ash258/Scoop-JetBrains
- https://github.com/TheRandomLabs/scoop-nonportable

## 清单文件指南

### 变量说明
```
$dir           
$bucketsdir      清单桶文件夹 \scoop\buckets
$PSScriptRoot    
```

### Python 快速安装
```
# 安装管理工具 uv
scoop install uv

# 安装 Python 3.8
uv python install 3.8

# 安装 Python 3.13
uv python install 3.13

# 检查 python 3.8 和 3.13 安装
python3.8 --version
python3.13 --version
```

### GoLang 快速安装
```
# 安装管理工具 g
scoop install g

# 安装 Go 1.18
g install 1.18

# 检查 go 1.18 安装
go version

# 安装 Go 1.23
g install 1.23

# 检查 go 1.23 安装
go version

# 切换 Go 1.18
g use 1.18

# 检查 go 版本
go version
```

### Node.js 快速安装
```
# 安装管理工具 nvm
scoop install nvm

# 安装最新版本 Node.js
nvm install --lts

# 检查 node.js 版本
node --version
```

## 本仓库软件清单

### 开发工具
| 软件 | 描述 |
|------|------|
| 7zip | 多格式文件压缩工具，具有高压缩率 |
| git | 分布式版本控制系统 |
| g | Go 环境多版本管理和切换的命令行工具 |
| nvm | Windows 版 Node.js 版本管理工具 |
| uv | 极速 Python 包安装器和解析器，使用 Rust 编写 |
| yarn | Node.js 依赖管理器 |
| gradle | 开源构建自动化工具 |
| composer | PHP 依赖管理器 |
| gcc | GNU 编译器集合和 binutils |
| msys2 | Windows 软件发行版和构建平台 |
| innounp | Inno Setup 解包工具 |
| protobuf | 用于编译 .proto 文件的协议编译器 |
| dark | WiX Toolset 反编译器 |

### 编辑器/IDE
| 软件 | 描述 |
|------|------|
| notepadplusplus | 免费源代码编辑器和 Notepad 替代品 |
| pycharm | JetBrains 跨平台 Python IDE |
| PyCharm2021 | JetBrains PyCharm 专业版 |
| WebStorm | JetBrains 智能 JavaScript IDE |
| PhpStorm | JetBrains PHP 编程 IDE |
| IntelliJ-IDEA | JetBrains Java IDE 旗舰版 |
| GoLand | JetBrains Go 语言 IDE |
| DataGrip | JetBrains 数据库和 SQL IDE |
| android-studio | Android 官方开发 IDE |
| hbuilderx | DCloud 出品的 Web 开发 IDE |

### 网络/代理工具
| 软件 | 描述 |
|------|------|
| aria2 | 轻量级多协议多源命令行下载工具 |
| xray | 构建代理以绕过网络限制的平台 |
| v2ray | 构建代理以绕过网络限制的平台 |
| sing-box | 通用代理平台 |
| brook | 为开发者设计的跨平台网络工具 |
| frp | 快速反向代理，将内网服务暴露到公网 |
| easytier | 去中心化网格 VPN，支持 WireGuard (CLI 版) |
| easytier-gui | 去中心化网格 VPN，支持 WireGuard (GUI 版) |
| tun2socks | 将网络流量通过 SOCKS 代理转发 |
| nginx | HTTP 和反向代理服务器 |
| ddns-go | 快速反向代理，将内网服务暴露到公网 |

### 数据库/消息队列
| 软件 | 描述 |
|------|------|
| redis | 内存数据结构存储，用作数据库、缓存和消息代理 |
| rabbitmq | 消息代理 |
| mongodb | 文档数据库，具有可扩展性和灵活性 |
| mysql57 | 全球最流行的开源数据库 |
| elasticsearch | 分布式 RESTful 搜索引擎 |
| mosquitto | 实现 MQTT 协议的开源消息代理 |
| sqlitebrowser | SQLite 数据库浏览器 |

### 远程/终端工具
| 软件 | 描述 |
|------|------|
| putty | SSH 和 Telnet 的免费实现，附带 xterm 终端模拟器 |
| winscp | 使用 FTP、FTPS、SCP、SFTP、WebDAV 或 S3 协议传输文件 |
| windterm | SSH/Sftp/Shell/Telnet/Serial 客户端 |
| xpra | 持久化远程显示服务器和客户端，用于转发应用程序和桌面屏幕 |
| virt-viewer | 虚拟机控制台查看器 |

### 实用工具
| 软件 | 描述 |
|------|------|
| powertoys | 高级用户调整和简化 Windows 体验的实用工具集 |
| rufus | 格式化并创建可启动 USB 闪存驱动器的工具 |
| diskgenius | 数据恢复、磁盘分区管理、备份和还原工具 |
| picpick | 全功能屏幕截图工具、图像编辑器、取色器等 |
| switchhosts | Hosts 管理和切换工具 |
| guipropview | 显示系统上所有打开窗口的详细信息 |
| NatTypeTester | 测试当前网络的 NAT 类型 (STUN) |
| vcredist-aio | Microsoft Visual C++ 可再发行运行时合集 |
| winsw | 将任何可执行文件作为 Windows 服务运行的包装器 |
| sudo | Unix sudo 命令的近似实现 |

### 开发辅助
| 软件 | 描述 |
|------|------|
| docker-compose | 使用 Docker 定义和运行多容器应用程序 |
| postman | 完整的 API 开发环境 |
| reqable | 高级 API 调试代理 |
| sourcegit | 开源 Git GUI 客户端 |
| sourcetree | 简单强大的 Git GUI |
| adb | Android SDK 平台工具，包括 adb 和 fastboot |
| cc-switch | Claude Code、Codex 和 Gemini CLI 的桌面一体化助手工具 |

### 云存储工具
| 软件 | 描述 |
|------|------|
| oss-browser | 阿里云 OSS 文件管理器 |
| kodo-browser | 七牛对象存储图形化管理工具 |

### 浏览器
| 软件 | 描述 |
|------|------|
| chromium | 更安全、更快、更稳定的浏览器 |

### 文档工具
| 软件 | 描述 |
|------|------|
| pdf-xchange-editor | 小巧、快速、功能丰富的 PDF 查看器/编辑器 |

### 目录服务
| 软件 | 描述 |
|------|------|
| ldap-admin | LDAP 客户端和目录管理工具 |

### 编程语言
| 软件 | 描述 |
|------|------|
| erlang | 用于构建大规模可扩展软实时系统的编程语言 |

### 文件比较
| 软件 | 描述 |
|------|------|
| BeyondCompare3 | 文件和文件夹比较工具 |

### 数据库管理
| 软件 | 描述 |
|------|------|
| navicat16 | 数据库管理工具 |

### 虚拟化工具
| 软件 | 描述 |
|------|------|
| ovftool | VMware OVF 工具 |
