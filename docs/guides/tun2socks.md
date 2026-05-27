# tun2socks 使用指南

## 简介

tun2socks 是一个代理工具，通过创建 TUN 设备将系统网络流量通过 SOCKS 代理进行转发。它使用 wintun 驱动在 Windows 上创建虚拟网络接口，实现全局代理功能。

**版本**: v2.5.0  
**官网**: https://github.com/xjasonlyu/tun2socks  
**主要功能**: TUN 设备代理工具  
**驱动依赖**: wintun

## 主要功能

- 创建 TUN 虚拟网络设备
- 将系统流量通过 SOCKS5 代理转发
- 支持全局代理模式
- 支持 SOCKS5 协议
- 使用 wintun 驱动实现高性能
- 支持 IPv4 和 IPv6
- 支持 TCP 和 UDP 流量
- 命令行界面，适合脚本化使用
- 轻量级，资源占用低
- 支持 Windows 系统

## 安装与配置

### 安装 tun2socks

通过 Scoop 安装：

```powershell
scoop install tun2socks
```

### wintun 驱动

tun2socks 依赖 wintun 驱动，通常会自动安装。如果需要手动安装：

1. 下载 wintun 驱动：https://www.wintun.net/
2. 解压到系统目录
3. 以管理员权限安装驱动

## 常用命令

### 基本启动

```bash
# 使用 SOCKS5 代理启动
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080

# 指定 TUN 设备名称
tun2socks -device "TUN" -proxy socks5://127.0.0.1:1080
```

### 命令行参数

```bash
# 查看帮助
tun2socks -h

# 常用参数说明
-device    # TUN 设备名称
-proxy     # 代理地址 (socks5://ip:port)
-loglevel  # 日志级别 (debug/info/warn/error)
-restapi   # RESTful API 监听地址
```

### 启动示例

```bash
# 基本启动
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080

# 指定日志级别
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel debug

# 启用 REST API
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -restapi 127.0.0.1:8080
```

## 配置详解

### SOCKS5 代理配置

```bash
# 基本 SOCKS5 代理
socks5://127.0.0.1:1080

# 带认证的 SOCKS5 代理
socks5://username:password@127.0.0.1:1080

# 远程 SOCKS5 代理
socks5://proxy.example.com:1080
```

### TUN 设备配置

```bash
# 使用默认 TUN 设备
-device tun0

# 使用自定义名称
-device "MyTUN"

# Windows 上通常使用
-device "tun0"
```

### 网络配置

启动 tun2socks 后，需要配置系统路由：

```powershell
# 查看网络接口
ipconfig /all

# 配置路由（以管理员权限运行）
route add 0.0.0.0 mask 0.0.0.0 <TUN_GATEWAY> metric 1
```

## 使用场景

### 场景 1：全局代理

将所有系统流量通过 SOCKS5 代理转发：

1. **启动 SOCKS5 代理服务**（如 Shadowsocks、V2Ray 等）
2. **启动 tun2socks**:
   ```bash
   tun2socks -device tun0 -proxy socks5://127.0.0.1:1080
   ```
3. **配置系统路由**:
   ```powershell
   # 设置默认路由
   route add 0.0.0.0 mask 0.0.0.0 10.0.0.1 metric 1
   ```

### 场景 2：指定程序代理

配合其他工具实现指定程序代理：

1. **使用 Proxifier 等工具**
2. **配置规则将特定程序流量指向 SOCKS5 代理**
3. **tun2socks 将流量转发到代理服务器**

### 场景 3：游戏加速

为游戏创建低延迟代理通道：

```bash
# 启动 tun2socks
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel info

# 配置游戏流量路由
route add <game_server_ip> mask 255.255.255.255 <TUN_GATEWAY>
```

### 场景 4：开发调试

在开发环境中代理网络请求：

```bash
# 启动带调试日志的 tun2socks
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel debug

# 启用 REST API 查看连接状态
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -restapi 127.0.0.1:8080
```

## 高级配置

### REST API

tun2socks 提供 REST API 接口用于监控和管理：

```bash
# 启用 REST API
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -restapi 127.0.0.1:8080

# 获取连接信息
curl http://127.0.0.1:8080/connections

# 获取统计信息
curl http://127.0.0.1:8080/stats
```

### 日志配置

```bash
# 调试级别日志
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel debug

# 信息级别日志
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel info

# 警告级别日志
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel warn

# 错误级别日志
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel error
```

### 性能优化

```bash
# 使用高性能配置
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -tcp-send-buffer-size 65536 -tcp-receive-buffer-size 65536
```

## 网络配置

### IP 地址配置

启动 tun2socks 后，TUN 设备会获得一个 IP 地址：

```powershell
# 查看 TUN 设备 IP
ipconfig /all

# 手动配置 TUN 设备 IP
netsh interface ip set address "tun0" static 10.0.0.2 255.255.255.0 10.0.0.1
```

### DNS 配置

```powershell
# 配置 TUN 设备 DNS
netsh interface ip set dns "tun0" static 8.8.8.8
netsh interface ip add dns "tun0" 8.8.4.4 index=2
```

### 路由配置

```powershell
# 添加默认路由
route add 0.0.0.0 mask 0.0.0.0 10.0.0.1 metric 1

# 添加特定路由
route add 192.168.1.0 mask 255.255.255.0 10.0.0.1

# 删除路由
route delete 0.0.0.0

# 查看路由表
route print
```

## 与其他工具配合

### 配合 Shadowsocks

```bash
# 1. 启动 Shadowsocks 本地代理（端口 1080）
# 2. 启动 tun2socks
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080
```

### 配合 V2Ray

```bash
# 1. 启动 V2Ray SOCKS5 代理（端口 10808）
# 2. 启动 tun2socks
tun2socks -device tun0 -proxy socks5://127.0.0.1:10808
```

### 配合 Clash

```bash
# 1. 启动 Clash SOCKS5 代理（端口 7891）
# 2. 启动 tun2socks
tun2socks -device tun0 -proxy socks5://127.0.0.1:7891
```

## 常见问题

### 1. TUN 设备创建失败

**可能原因**:
- wintun 驱动未安装
- 权限不足
- 驱动版本不兼容

**解决方案**:
```powershell
# 以管理员权限运行
# 安装 wintun 驱动
# 检查驱动版本
```

### 2. 无法连接代理

**可能原因**:
- SOCKS5 代理未启动
- 代理地址错误
- 防火墙阻止

**解决方案**:
```bash
# 检查代理是否运行
netstat -an | findstr "1080"

# 测试代理连接
curl -x socks5://127.0.0.1:1080 http://www.google.com

# 检查防火墙设置
```

### 3. 网络速度慢

**可能原因**:
- 代理服务器性能问题
- 网络延迟高
- 配置不当

**解决方案**:
- 使用更快的代理服务器
- 优化网络配置
- 调整缓冲区大小

### 4. DNS 解析失败

**可能原因**:
- DNS 配置错误
- DNS 服务器不可达
- DNS 泄露

**解决方案**:
```powershell
# 配置正确的 DNS
netsh interface ip set dns "tun0" static 8.8.8.8

# 清除 DNS 缓存
ipconfig /flushdns

# 测试 DNS 解析
nslookup www.google.com
```

### 5. 程序无法联网

**可能原因**:
- 路由配置错误
- TUN 设备未正确配置
- 程序使用了直接连接

**解决方案**:
```powershell
# 检查路由表
route print

# 重新配置路由
route add 0.0.0.0 mask 0.0.0.0 10.0.0.1 metric 1

# 检查 TUN 设备状态
ipconfig /all
```

### 6. 系统无法上网

**可能原因**:
- 路由配置冲突
- TUN 设备故障
- 代理服务停止

**解决方案**:
```powershell
# 恢复默认路由
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 <original_gateway>

# 停止 tun2socks
# 重启网络适配器
netsh interface set interface "Ethernet" disable
netsh interface set interface "Ethernet" enable
```

## 故障排除

### 检查 TUN 设备状态

```powershell
# 查看网络接口
ipconfig /all

# 检查 TUN 设备是否存在
Get-NetAdapter | Where-Object {$_.Name -like "*tun*"}
```

### 查看日志

```bash
# 启用调试日志
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel debug

# 保存日志到文件
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -loglevel debug > tun2socks.log 2>&1
```

### 网络诊断

```powershell
# 测试网络连通性
ping 8.8.8.8

# 测试 DNS 解析
nslookup www.google.com

# 查看网络连接
netstat -an

# 跟踪路由
tracert 8.8.8.8
```

## 安全注意事项

### 1. 代理安全

- 使用可信赖的 SOCKS5 代理
- 避免使用公共免费代理
- 定期更换代理密码

### 2. 防火墙配置

- 仅允许必要的端口
- 监控异常网络活动
- 定期检查防火墙规则

### 3. 流量监控

- 启用日志记录
- 监控异常流量
- 定期审查连接记录

## 性能优化

### 缓冲区调优

```bash
# 增加 TCP 缓冲区大小
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -tcp-send-buffer-size 131072 -tcp-receive-buffer-size 131072
```

### 连接池配置

```bash
# 配置最大连接数
tun2socks -device tun0 -proxy socks5://127.0.0.1:1080 -max-connections 1000
```

### 系统优化

```powershell
# 优化网络适配器设置
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global dca=enabled
```

## 相关资源

- [tun2socks GitHub 仓库](https://github.com/xjasonlyu/tun2socks)
- [wintun 驱动](https://www.wintun.net/)
- [SOCKS 协议说明](https://en.wikipedia.org/wiki/SOCKS)
- [TUN/TAP 设备说明](https://en.wikipedia.org/wiki/TUN/TAP)
- [网络代理技术](https://en.wikipedia.org/wiki/Proxy_server)