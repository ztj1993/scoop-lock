# EasyTier CLI 使用指南

## 简介

EasyTier CLI 是一个简单、去中心化的 Mesh VPN 解决方案的命令行版本，支持 WireGuard。它提供了一种便捷的方式在多台设备之间建立安全的点对点连接，支持 TCP 和 UDP 传输协议。

**版本**: 2.6.4
**官网**: https://github.com/EasyTier/EasyTier
**许可证**: LGPL-3.0
**类型**: 命令行工具 + Web 控制台
**可执行文件**: easytier-cli.exe, easytier-core.exe, easytier-web.exe, easytier-web-embed.exe
**传输协议**: TCP/UDP

## 主要功能

- 去中心化 Mesh VPN 网络
- WireGuard 协议支持
- TCP 传输支持
- UDP 传输支持
- 自动 NAT 穿透
- 端到端加密
- 跨平台兼容
- 命令行管理界面
- Web 控制台管理界面
- 自动节点发现
- 虚拟 IP 地址分配
- 网络拓扑可视化
- 流量加密和压缩

## 安装

### 通过 Scoop 安装

```bash
scoop install easytier
```

### 验证安装

```bash
# 检查核心组件
easytier-core.exe --version

# 检查命令行工具
easytier-cli.exe --version
```

### 组件说明

```
easytier-core.exe         核心服务组件，负责 VPN 隧道建立和数据传输
easytier-cli.exe          命令行管理工具，用于配置和监控
easytier-web.exe          Web API 后端服务（仅后端）
easytier-web-embed.exe    Web 前端 + Web API 后端（完整版）
```

## 基本用法

### 启动核心服务

```bash
# 基本启动
easytier-core.exe

# 指定网络名称
easytier-core.exe -n my-network

# 指定网络密码
easytier-core.exe -n my-network -p my-password

# 指定虚拟 IP
easytier-core.exe -n my-network -i 10.0.0.1
```

### 命令行管理

```bash
# 查看帮助
easytier-cli.exe --help

# 查看版本
easytier-cli.exe --version

# 查看网络状态
easytier-cli.exe status

# 查看节点列表
easytier-cli.exe peers
```

## 网络配置

### 创建网络

```bash
# 创建并加入网络
easytier-core.exe \
  --network-name my-network \
  --network-secret my-password \
  --ip-address 10.0.0.1
```

### 加入现有网络

```bash
# 加入已有网络
easytier-core.exe \
  --network-name existing-network \
  --network-secret network-password \
  --peers tcp://peer-address:11010
```

### 配置参数

```
-n, --network-name     网络名称
-p, --network-secret   网络密码
-i, --ip-address       虚拟 IP 地址
-l, --listeners        监听地址列表
-P, --peers            对等节点地址
-d, --dev-name         虚拟网卡名称
--console-log-level    控制台日志级别
--file-log-level       文件日志级别
```

## 传输协议

### TCP 传输

```bash
# 使用 TCP 协议
easytier-core.exe \
  --network-name my-network \
  --listeners tcp://0.0.0.0:11010 \
  --peers tcp://peer-ip:11010
```

### UDP 传输

```bash
# 使用 UDP 协议
easytier-core.exe \
  --network-name my-network \
  --listeners udp://0.0.0.0:11010 \
  --peers udp://peer-ip:11010
```

### 同时使用 TCP 和 UDP

```bash
# 同时监听 TCP 和 UDP
easytier-core.exe \
  --network-name my-network \
  --listeners tcp://0.0.0.0:11010 udp://0.0.0.0:11010
```

## WireGuard 支持

### 启用 WireGuard

```bash
# 启用 WireGuard 支持
easytier-core.exe \
  --network-name my-network \
  --network-secret my-password \
  --wg-endpoint 0.0.0.0:51820
```

### WireGuard 配置参数

```
--wg-endpoint         WireGuard 监听端点
--wg-private-key      WireGuard 私钥
--wg-public-key       WireGuard 公钥
--wg-keepalive        WireGuard 保活间隔
```

### WireGuard 客户端连接

```ini
# WireGuard 客户端配置示例
[Interface]
PrivateKey = <客户端私钥>
Address = 10.0.0.2/24

[Peer]
PublicKey = <服务端公钥>
Endpoint = server-ip:51820
AllowedIPs = 10.0.0.0/24
PersistentKeepalive = 25
```

## 节点管理

### 查看节点状态

```bash
# 查看所有节点
easytier-cli.exe peers

# 查看节点详情
easytier-cli.exe peer-info <peer-id>
```

### 节点信息输出

```
Peer ID: abc123
Name: node1
IP: 10.0.0.1
Public IP: 203.0.113.1
NAT Type: Cone
Connection: Direct
Latency: 15ms
```

### 节点操作

```bash
# 断开节点
easytier-cli.exe disconnect <peer-id>

# 添加节点
easytier-cli.exe connect tcp://peer-ip:11010

# 删除节点
easytier-cli.exe remove-peer <peer-id>
```

## 网络管理

### 查看网络状态

```bash
# 查看网络概览
easytier-cli.exe status

# 查看网络拓扑
easytier-cli.exe topo

# 查看网络接口
easytier-cli.exe interfaces
```

### 网络状态输出

```
Network: my-network
Virtual IP: 10.0.0.1
Peers: 5
Connections: 8
Upload: 1.2 MB
Download: 3.4 MB
Uptime: 2h 30m
```

### 网络配置管理

```bash
# 修改网络配置
easytier-cli.exe config set network-name new-name
easytier-cli.exe config set network-secret new-password

# 查看当前配置
easytier-cli.exe config show

# 重置配置
easytier-cli.exe config reset
```

## 流量管理

### 流量统计

```bash
# 查看流量统计
easytier-cli.exe traffic

# 查看详细流量
easytier-cli.exe traffic --detail

# 重置流量统计
easytier-cli.exe traffic --reset
```

### 带宽控制

```bash
# 设置带宽限制
easytier-cli.exe config set max-upload 10mbps
easytier-cli.exe config set max-download 50mbps
```

## 日志管理

### 查看日志

```bash
# 查看实时日志
easytier-cli.exe logs

# 查看指定数量的日志
easytier-cli.exe logs -n 100

# 过滤日志
easytier-cli.exe logs --level error

# 搜索日志
easytier-cli.exe logs --grep "connection"
```

### 日志级别

```
trace   最详细的日志
debug   调试信息
info    一般信息（默认）
warn    警告信息
error   错误信息
```

### 日志配置

```bash
# 设置控制台日志级别
easytier-core.exe --console-log-level debug

# 设置文件日志级别
easytier-core.exe --file-log-level info

# 设置日志文件路径
easytier-core.exe --file-log-dir /path/to/logs
```

## 配置文件

### 配置文件位置

```
Windows: %USERPROFILE%\.easytier\config.toml
Linux: ~/.easytier/config.toml
```

### 配置文件示例

```toml
[network]
name = "my-network"
secret = "my-password"
ip = "10.0.0.1"

[listeners]
tcp = "0.0.0.0:11010"
udp = "0.0.0.0:11010"

[peers]
addresses = [
    "tcp://peer1.example.com:11010",
    "tcp://peer2.example.com:11010"
]

[wireguard]
enabled = true
endpoint = "0.0.0.0:51820"

[logging]
console_level = "info"
file_level = "info"
file_dir = "/var/log/easytier"

[advanced]
mtu = 1400
tcp_timeout = 30
udp_timeout = 60
```

### 使用配置文件

```bash
# 使用配置文件启动
easytier-core.exe --config /path/to/config.toml

# 验证配置文件
easytier-core.exe --config /path/to/config.toml --check
```

## Web 控制台

EasyTier 支持使用 Web 控制台来管理节点，包括查看节点状态、配置节点参数、查看节点日志等。

### Web 控制台版本

EasyTier 提供两个版本的 Web 控制台：

```
easytier-web.exe          仅 Web API 后端
easytier-web-embed.exe    Web 前端 + Web API 后端（完整版）
```

### 架构说明

Web 控制台采用前后端分离的架构，包含 3 个服务：

```
Web 前端（默认 11211 端口）
Web API 后端（默认 11211 端口）
配置下发端（默认 22020 端口，UDP 协议）
```

其中，Web 前端与 Web API 后端默认绑定在同一端口，配置下发端则是 Web API 后端的一部分。

### 启动 Web 控制台

#### 使用 easytier-web-embed（推荐）

```bash
# 启动完整版 Web 控制台
easytier-web-embed.exe \
  --api-server-port 11211 \
  --api-host "http://127.0.0.1:11211" \
  --config-server-port 22020 \
  --config-server-protocol udp
```

#### 使用 easytier-web

```bash
# 仅启动 Web API 后端
easytier-web.exe \
  --api-server-port 11211 \
  --config-server-port 22020 \
  --config-server-protocol udp
```

### Web 控制台参数

```
--api-server-port         Web 前后端的端口（默认 11211）
--api-host                Web API 后端的访问地址
--config-server-port      配置下发端的端口（默认 22020）
--config-server-protocol  配置下发端的协议（支持 tcp, udp, ws）
--web-server-port         额外监听 Web 前端的端口
--no-web                  不运行 Web 前端
```

### 访问 Web 控制台

启动成功后，打开浏览器访问：

```
http://127.0.0.1:11211
```

### 注册和登录

Web 控制台提供两个默认账户：

```
用户名: admin
密码: admin

用户名: user
密码: user
```

点击 `Register` 可以注册新账户。如果刷新不出验证码，说明 `--api-host` 设置有误。

### 接入自建 Web 控制台

在 Web 控制台上创建网络后，使用 `easytier-core` 接入：

```bash
# 接入自建 Web 控制台
# protocol: udp, tcp, ws, wss
easytier-core.exe -w udp://127.0.0.1:22020/<用户名>

# 示例
easytier-core.exe -w udp://127.0.0.1:22020/admin
```

### 配置下发协议

支持以下协议：

```
udp    UDP 协议（默认）
tcp    TCP 协议
ws     WebSocket 协议
wss    WebSocket Secure 协议（需要反向代理）
```

### 反向代理配置

当使用反向代理将 ws 升级为 wss 时，连接时可填写 `wss` 协议：

```bash
# 使用 wss 协议连接
easytier-core.exe -w wss://your-domain.com/22020/admin
```

### Web 控制台功能

Web 控制台提供以下功能：

```
节点管理    查看和管理所有节点
网络配置    创建和配置网络
状态监控    实时查看节点状态
日志查看    查看节点日志
配置下发    向节点推送配置
用户管理    管理用户账户
```

### Web 控制台使用示例

#### 1. 启动 Web 控制台

```bash
easytier-web-embed.exe \
  --api-server-port 11211 \
  --api-host "http://127.0.0.1:11211" \
  --config-server-port 22020 \
  --config-server-protocol udp
```

#### 2. 访问 Web 控制台

打开浏览器访问 `http://127.0.0.1:11211`，使用默认账户登录。

#### 3. 创建网络

在 Web 控制台中创建网络，配置网络名称和密码。

#### 4. 接入网络

在其他设备上使用 `easytier-core` 接入网络：

```bash
easytier-core.exe -w udp://服务器IP:22020/admin
```

#### 5. 管理节点

在 Web 控制台中查看和管理所有接入的节点。

### Web 控制台配置文件

Web 控制台支持使用配置文件：

```toml
# web-config.toml
[api]
port = 11211
host = "http://127.0.0.1:11211"

[config_server]
port = 22020
protocol = "udp"

[web]
enabled = true
port = 11211
```

```bash
# 使用配置文件启动
easytier-web-embed.exe --config web-config.toml
```

### Web 控制台故障排除

#### 1. 无法访问 Web 控制台

```
可能原因:
- 端口被占用
- 防火墙阻止
- 配置错误

解决方法:
1. 检查端口是否被占用
2. 检查防火墙设置
3. 验证配置参数
4. 查看日志输出
```

#### 2. 注册时无法获取验证码

```
可能原因:
- --api-host 配置错误
- 网络连接问题

解决方法:
1. 检查 --api-host 参数
2. 确保网络连接正常
3. 查看浏览器控制台错误
```

#### 3. 节点无法连接到 Web 控制台

```
可能原因:
- 配置下发端口未开放
- 协议不匹配
- 网络不通

解决方法:
1. 检查配置下发端口
2. 验证协议设置
3. 测试网络连通性
```

## 高级功能

### NAT 穿透

```bash
# 启用 NAT 穿透
easytier-core.exe \
  --network-name my-network \
  --network-secret my-password \
  --enable-nat-traversal

# 配置 STUN 服务器
easytier-core.exe \
  --stun-server stun.l.google.com:19302
```

### 中继模式

```bash
# 启用中继模式（作为中继节点）
easytier-core.exe \
  --network-name my-network \
  --relay-enabled

# 使用中继节点
easytier-core.exe \
  --network-name my-network \
  --peers tcp://relay-node:11010
```

### 多网络支持

```bash
# 同时加入多个网络
easytier-core.exe \
  --network-name network1 \
  --network-name network2 \
  --ip-address 10.0.0.1
```

## 使用场景

### 远程办公

```bash
# 公司服务器
easytier-core.exe \
  --network-name company-vpn \
  --network-secret secure-password \
  --ip-address 10.0.0.1 \
  --listeners tcp://0.0.0.0:11010

# 员工电脑
easytier-core.exe \
  --network-name company-vpn \
  --network-secret secure-password \
  --peers tcp://company-ip:11010
```

### 游戏联机

```bash
# 房主
easytier-core.exe \
  --network-name game-room \
  --network-secret game-password \
  --ip-address 10.0.0.1

# 玩家
easytier-core.exe \
  --network-name game-room \
  --network-secret game-password \
  --peers tcp://host-ip:11010
```

### 文件共享

```bash
# 共享服务器
easytier-core.exe \
  --network-name file-share \
  --network-secret share-password \
  --ip-address 10.0.0.1

# 访问共享
easytier-core.exe \
  --network-name file-share \
  --network-secret share-password \
  --peers tcp://server-ip:11010
```

### 开发测试

```bash
# 开发环境
easytier-core.exe \
  --network-name dev-env \
  --network-secret dev-password \
  --ip-address 10.0.0.1 \
  --console-log-level debug
```

## 故障排除

### 连接问题

```bash
# 检查网络状态
easytier-cli.exe status

# 检查节点连接
easytier-cli.exe peers

# 测试连接
easytier-cli.exe ping <peer-ip>

# 查看详细日志
easytier-cli.exe logs --level debug
```

### 常见错误

```
错误: 无法连接到对等节点
解决:
1. 检查网络连接
2. 检查防火墙设置
3. 验证端口是否开放
4. 检查网络名称和密码

错误: IP 地址冲突
解决:
1. 使用不同的 IP 地址
2. 检查网络中是否有重复 IP

错误: NAT 穿透失败
解决:
1. 检查 NAT 类型
2. 使用中继节点
3. 配置 STUN 服务器
```

### 诊断命令

```bash
# 网络诊断
easytier-cli.exe diagnose

# 端口测试
easytier-cli.exe test-port 11010

# 速度测试
easytier-cli.exe speed-test <peer-ip>

# 路由表查看
easytier-cli.exe routes
```

## 系统服务

### 注册为系统服务

```bash
# Windows (使用 sc)
sc create EasyTier binPath= "C:\path\to\easytier-core.exe --config C:\path\to\config.toml"
sc start EasyTier

# 使用 NSSM
nssm install EasyTier "C:\path\to\easytier-core.exe" "--config C:\path\to\config.toml"
nssm start EasyTier
```

### 服务管理

```bash
# 启动服务
net start EasyTier

# 停止服务
net stop EasyTier

# 删除服务
sc delete EasyTier
```

### 开机自启

```bash
# 创建启动脚本
# start-easytier.bat
@echo off
start /B easytier-core.exe --config config.toml

# 添加到启动文件夹
# shell:startup
```

## 脚本集成

### PowerShell 脚本

```powershell
# 启动 EasyTier
function Start-EasyTier {
    param(
        [string]$NetworkName,
        [string]$NetworkSecret,
        [string]$IpAddress,
        [string[]]$Peers
    )
    
    $args = @(
        "--network-name", $NetworkName,
        "--network-secret", $NetworkSecret,
        "--ip-address", $IpAddress
    )
    
    foreach ($peer in $Peers) {
        $args += "--peers"
        $args += $peer
    }
    
    Start-Process -FilePath "easytier-core.exe" -ArgumentList $args -NoNewWindow
}

# 使用示例
Start-EasyTier -NetworkName "my-network" `
               -NetworkSecret "password" `
               -IpAddress "10.0.0.1" `
               -Peers @("tcp://peer1:11010", "tcp://peer2:11010")
```

### 批处理脚本

```batch
@echo off
set NETWORK_NAME=my-network
set NETWORK_SECRET=password
set IP_ADDRESS=10.0.0.1

echo Starting EasyTier...
easytier-core.exe ^
  --network-name %NETWORK_NAME% ^
  --network-secret %NETWORK_SECRET% ^
  --ip-address %IP_ADDRESS% ^
  --console-log-level info

pause
```

## 性能优化

### MTU 优化

```bash
# 设置合适的 MTU
easytier-core.exe --mtu 1400
```

### 压缩设置

```bash
# 启用压缩
easytier-core.exe --enable-compression

# 压缩级别
easytier-core.exe --compression-level 6
```

### 连接池

```bash
# 设置连接池大小
easytier-core.exe --connection-pool-size 10
```

## 安全建议

### 密码安全

```
1. 使用强密码（至少 16 字符）
2. 包含大小写字母、数字和特殊字符
3. 定期更换密码
4. 不要在公共网络中共享密码
```

### 网络安全

```
1. 限制网络访问权限
2. 使用防火墙规则
3. 监控网络流量
4. 定期检查节点列表
```

### 最佳实践

```
1. 使用配置文件管理配置
2. 启用日志记录
3. 定期备份配置
4. 测试网络连接
5. 监控系统资源
```

## 常见问题

### 1. 无法加入网络

```
可能原因:
- 网络名称或密码错误
- 网络不存在
- 网络已满

解决方法:
1. 检查网络名称和密码
2. 确认网络已创建
3. 检查网络容量限制
4. 查看日志获取详细信息
```

### 2. 连接速度慢

```
可能原因:
- 网络带宽限制
- 节点距离远
- NAT 类型限制
- 服务器负载高

解决方法:
1. 选择距离近的节点
2. 使用中继节点
3. 优化网络配置
4. 升级网络带宽
```

### 3. 频繁断连

```
可能原因:
- 网络不稳定
- NAT 超时
- 防火墙干扰

解决方法:
1. 检查网络连接
2. 启用保活机制
3. 调整超时设置
4. 配置防火墙例外
```

### 4. 无法访问内网资源

```
可能原因:
- 路由配置错误
- IP 地址冲突
- 防火墙阻止

解决方法:
1. 检查路由表
2. 验证 IP 配置
3. 配置防火墙规则
4. 使用正确的子网
```

### 5. WireGuard 连接失败

```
可能原因:
- 密钥配置错误
- 端口未开放
- 协议不匹配

解决方法:
1. 重新生成密钥对
2. 检查端口开放状态
3. 验证配置文件
4. 查看 WireGuard 日志
```

## 相关资源

- [EasyTier GitHub](https://github.com/EasyTier/EasyTier)
- [EasyTier 文档](https://github.com/EasyTier/EasyTier/wiki)
- [EasyTier 发布页面](https://github.com/EasyTier/EasyTier/releases)
- [WireGuard 官网](https://www.wireguard.com/)
- [WireGuard 文档](https://www.wireguard.com/quickstart/)
