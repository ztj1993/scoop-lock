# FRP 使用指南

## 简介

FRP（Fast Reverse Proxy）是一款高性能的反向代理工具，可以帮助你将位于 NAT 或防火墙之后的
本地服务器暴露到互联网上。由 fatedier 开发并维护，采用 Apache-2.0 开源许可证。

FRP v0.51.3 是当前的稳定版本，支持 TCP、UDP、HTTP、HTTPS、STCP、SUDP 等多种协议的代理转发，
并提供了 P2P 穿透、负载均衡、健康检查、流量加密与压缩等高级功能。

FRP 采用客户端-服务器架构：服务端（frps）部署在具有公网 IP 的服务器上，客户端（frpc）部署在
需要穿透的内网环境中。客户端主动连接服务端，建立隧道后，外部流量通过服务端转发到内网服务器。

典型应用场景包括：
- 家庭/办公室内网服务的外网访问
- 远程桌面连接
- 本地 Web 服务的公网暴露
- 游戏服务器的端口映射
- SSH 穿透访问

- **版本**: v0.51.3
- **许可证**: Apache-2.0
- **官方网站**: https://github.com/fatedier/frp
- **安装方式**: Scoop 包管理器

## 主要功能

### 多协议支持

- **TCP 代理**: 转发任意 TCP 端口，适用于 SSH、数据库、远程桌面等
- **UDP 代理**: 支持 UDP 协议转发，适用于 DNS、游戏等场景
- **HTTP 代理**: 支持基于域名的虚拟主机，自动处理 HTTP 请求
- **HTTPS 代理**: 支持 HTTPS 流量的透传转发
- **STCP/XTCP**: 安全的 TCP/P2P 代理，提供加密和 P2P 穿透能力
- **SUDP**: 安全的 UDP 代理

### 高级特性

- **P2P 穿透**: 通过 STCP/XTCP 模式实现点对点直连，减少中转流量
- **负载均衡**: 支持多个相同服务的负载均衡
- **健康检查**: 自动检测后端服务的可用性
- **流量加密**: 支持 TLS 加密，保护数据传输安全
- **流量压缩**: 支持 gzip/snappy/lz4 压缩，减少带宽消耗
- **端口复用**: 多个代理可以共用同一个端口
- **热加载**: 支持运行时修改配置并自动重载
- **客户端插件**: 内置 http_proxy、socks5、static_file 等实用插件

### Dashboard 管理界面

FRP 内置 Web Dashboard，可以实时查看代理状态、流量统计等信息：

- 查看客户端连接状态
- 查看各代理的流量统计
- 查看服务端资源使用情况

### 客户端插件系统

内置多种实用插件：

- `http_proxy`: HTTP 正向代理
- `socks5`: SOCKS5 代理
- `static_file`: 静态文件服务器
- `unix_domain_socket`: Unix 域套接字转发
- `http2https`: HTTP 到 HTTPS 的转换
- `https2http`: HTTPS 到 HTTP 的转换
- `secret_key`: 密钥验证

## 常用命令/操作

### 服务端命令（frps）

启动 FRP 服务端：

```bash
frps -c frps.toml
```

常用启动参数：

| 参数 | 说明 |
|------|------|
| `-c file` | 指定配置文件路径 |
| `--log-level level` | 日志级别（trace/debug/info/warn/error） |
| `--log-file file` | 日志输出文件 |
| `--log-max-days days` | 日志保留天数 |
| `-h` | 显示帮助信息 |

### 客户端命令（frpc）

启动 FRP 客户端：

```bash
frpc -c frpc.toml
```

常用启动参数：

| 参数 | 说明 |
|------|------|
| `-c file` | 指定配置文件路径 |
| `--log-level level` | 日志级别 |
| `--log-file file` | 日志输出文件 |
| `-h` | 显示帮助信息 |

### 服务端配置示例（frps.toml）

FRP v0.51.3 使用 TOML 格式配置文件。Scoop 安装时会自动创建默认配置文件 `frps.toml`：

```toml
bindPort = 7000
auth.token = "your_secret_token_here"

webServer.addr = "0.0.0.0"
webServer.port = 7500
webServer.user = "admin"
webServer.password = "admin"

transport.maxPoolCount = 10
transport.tcpMux = true
```

关键配置说明：

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `bindPort` | 服务端监听端口 | 7000 |
| `auth.token` | 认证令牌 | - |
| `webServer.port` | Dashboard 端口 | 7500 |
| `transport.maxPoolCount` | 最大连接池大小 | 10 |
| `transport.tcpMux` | TCP 多路复用 | true |

### 客户端配置示例（frpc.toml）

Scoop 安装时会自动创建默认配置文件 `frpc.toml`：

```toml
serverAddr = "your_server_ip"
serverPort = 7000
auth.token = "your_secret_token_here"

[[proxies]]
name = "ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 22
remotePort = 6000

[[proxies]]
name = "web"
type = "http"
localIP = "127.0.0.1"
localPort = 80
customDomains = ["your-domain.com"]
```

### 代理类型配置

**TCP 代理：**

```toml
[[proxies]]
name = "tcp_proxy"
type = "tcp"
localIP = "127.0.0.1"
localPort = 3306
remotePort = 3306
```

**HTTP 代理：**

```toml
[[proxies]]
name = "http_proxy"
type = "http"
localIP = "127.0.0.1"
localPort = 8080
customDomains = ["example.com"]
```

**UDP 代理：**

```toml
[[proxies]]
name = "dns"
type = "udp"
localIP = "127.0.0.1"
localPort = 53
remotePort = 53
```

**P2P 代理（XTCP）：**

```toml
[[proxies]]
name = "p2p_ssh"
type = "xtcp"
secretKey = "p2p_secret_key"
localIP = "127.0.0.1"
localPort = 22
```

### 服务管理

在 Windows 上可以使用 NSSM 将 FRP 注册为系统服务：

```powershell
nssm install frps "C:\path\to\frps.exe" "-c" "C:\path\to\frps.toml"
nssm start frps
```

或使用 Windows 自带的 sc 命令创建计划任务实现开机自启。

### 版本信息

查看版本：

```bash
frps --version
frpc --version
```

## 常见问题

### Q: 客户端无法连接到服务端？

排查步骤：
1. 检查服务端是否正常运行，端口是否开放
2. 检查防火墙是否放行了 bindPort 端口（默认 7000）
3. 确认客户端配置中的 serverAddr 和 serverPort 正确
4. 确认 auth.token 在服务端和客户端一致

### Q: HTTP 代理的域名如何配置？

需要将域名的 DNS 解析指向 FRP 服务端的公网 IP。然后在 frpc.toml 中设置
customDomains 为该域名即可。

### Q: 如何通过 FRP 实现 HTTPS 访问？

在服务端配置中启用 KCP 和 TLS 支持，并在客户端配置中使用 HTTPS 代理类型：

```toml
[[proxies]]
name = "https_proxy"
type = "https"
localIP = "127.0.0.1"
localPort = 443
customDomains = ["your-domain.com"]
```

### Q: 如何限制代理的带宽使用？

在客户端配置中设置带宽限制：

```toml
[[proxies]]
name = "web"
type = "http"
localPort = 80
transport.bandwidthLimit = "10MB"
transport.bandwidthLimitMode = "server"
```

### Q: Dashboard 页面无法访问？

检查服务端配置中 webServer 的端口是否正确，以及防火墙是否放行了该端口。
默认地址为 `http://server_ip:7500`。

### Q: 多个客户端如何共用一个服务端？

多个客户端可以使用相同的 auth.token 连接同一个 FRP 服务端，只需确保每个客户端的
代理名称（name）和远程端口不冲突即可。

### Q: 如何配置多个相同类型的代理？

在 frpc.toml 中使用 `[[proxies]]` 数组定义多个代理：

```toml
[[proxies]]
name = "ssh1"
type = "tcp"
localPort = 22
remotePort = 6000

[[proxies]]
name = "ssh2"
type = "tcp"
localPort = 22
remotePort = 6001
```

## 相关资源

- **GitHub 仓库**: https://github.com/fatedier/frp
- **官方文档**: https://github.com/fatedier/frp#readme
- **Release 下载**: https://github.com/fatedier/frp/releases
- **配置示例**: https://github.com/fatedier/frp/tree/dev/conf
- **Scoop 包管理器**: https://scoop.sh
- **NSSM 服务管理**: https://nssm.cc
- **中文社区讨论**: https://github.com/fatedier/frp/issues
