# Brook 使用指南

## 简介

Brook 是一款跨平台的网络工具，专为开发者设计，当前版本为 v20240606。

Brook 提供了多种网络代理和隧道功能，支持 TCP/UDP 流量转发、WebSocket 协议、TUN 设备等特性。它采用 Go 语言开发，具有高性能、低资源占用的特点，适用于各种网络环境下的开发和调试需求。

**主要特性：**
- 跨平台支持（Windows、macOS、Linux、Android、iOS）
- 支持多种代理协议
- 高性能，低资源占用
- 支持 WebSocket 协议
- 提供 GUI 和 CLI 两种使用方式
- 开源项目，代码透明

**官方网站：** https://github.com/txthinking/brook

---

## 主要功能

### 1. 多协议代理支持
Brook 支持多种代理协议，包括 Brook 协议、SOCKS5、HTTP 代理等，可以满足不同场景下的代理需求。

### 2. WebSocket 代理
支持通过 WebSocket 协议进行代理，可以绕过某些网络限制，提供更稳定的连接。

### 3. TUN 设备支持
支持创建 TUN 虚拟网络设备，实现系统级别的流量代理，支持全局代理和分流规则。

### 4. 端口转发
提供本地和远程端口转发功能，可以将本地端口映射到远程服务器，实现安全的网络访问。

### 5. DNS 代理
支持 DNS 查询代理，可以自定义 DNS 服务器，防止 DNS 污染和泄漏。

### 6. 流量加密
所有代理流量都经过加密处理，保护用户隐私和数据安全。

---

## 常用命令/操作

### 包含的工具

| 工具名称 | 说明 |
|---------|------|
| Brook.exe | Windows GUI 客户端 |
| brook | 命令行工具（CLI） |

### GUI 客户端操作

Brook.exe 是 Windows 平台的图形界面客户端，提供直观的操作界面：

1. **启动 Brook GUI**
   - 双击 Brook.exe 启动
   - 在系统托盘中找到 Brook 图标
   - 右键点击图标查看菜单选项

2. **配置代理服务器**
   - 点击主界面的"添加服务器"
   - 输入服务器地址、端口和密码
   - 选择代理协议类型
   - 点击"连接"按钮

3. **系统代理设置**
   - 启用"系统代理"选项
   - 所有系统流量将通过 Brook 代理
   - 可以选择"仅代理特定应用"

### CLI 命令行操作

```bash
# 查看版本信息
brook --version

# 查看帮助信息
brook --help

# 查看子命令帮助
brook <子命令> --help
```

### 服务器端命令

```bash
# 启动 Brook 服务器
brook server -l :<端口> -p <密码>

# 示例：启动服务器监听 1080 端口
brook server -l :1080 -p mypassword

# 后台运行服务器（Linux）
nohup brook server -l :1080 -p mypassword &

# 使用 systemd 管理服务
# 创建 /etc/systemd/system/brook.service 文件
```

### 客户端命令

```bash
# 启动 SOCKS5 代理
brook client -s <服务器地址>:<端口> -p <密码> -l 127.0.0.1:1080

# 示例：连接到远程服务器
brook client -s example.com:1080 -p mypassword -l 127.0.0.1:1080

# 启动 HTTP 代理
brook client -s <服务器地址>:<端口> -p <密码> --http 127.0.0.1:8080

# 同时启用 SOCKS5 和 HTTP 代理
brook client -s <服务器地址>:<端口> -p <密码> -l 127.0.0.1:1080 --http 127.0.0.1:8080
```

### WebSocket 代理

```bash
# 启动 WebSocket 服务器
brook wsserver -l :<端口> -p <密码>

# 示例
brook wsserver -l :8080 -p mypassword

# 启动 WebSocket 客户端
brook wsclient -s ws://<服务器地址>:<端口> -p <密码> -l 127.0.0.1:1080

# 使用 wss:// 加密连接
brook wsclient -s wss://<服务器地址>:<端口> -p <密码> -l 127.0.0.1:1080
```

### TUN 设备操作

```bash
# 创建 TUN 设备并连接
brook tproxy -s <服务器地址>:<端口> -p <密码>

# 配置 TUN 设备参数
brook tproxy -s <服务器地址>:<端口> -p <密码> --tunname brook0

# 查看 TUN 设备状态
ip addr show brook0
```

### 端口转发

```bash
# 本地端口转发
brook relay -f 127.0.0.1:<本地端口> -t <目标地址>:<目标端口>

# 示例：将本地 8080 端口转发到远程 80 端口
brook relay -f 127.0.0.1:8080 -t example.com:80

# 远程端口转发
brook relay -f :<远程端口> -t <目标地址>:<目标端口>

# 通过代理进行端口转发
brook relay -s <服务器地址>:<端口> -p <密码> -f 127.0.0.1:<本地端口> -t <目标地址>:<目标端口>
```

### DNS 代理

```bash
# 启动 DNS 代理服务器
brook dns -l 127.0.0.1:53 -s <服务器地址>:<端口> -p <密码>

# 指定上游 DNS 服务器
brook dns -l 127.0.0.1:53 --dns 8.8.8.8:53

# 配置系统 DNS
# Windows
netsh interface ip set dns "Wi-Fi" static 127.0.0.1
# Linux
echo "nameserver 127.0.0.1" > /etc/resolv.conf
```

### 配置文件使用

```json
// config.json 示例
{
    "server": "example.com:1080",
    "password": "mypassword",
    "listen": "127.0.0.1:1080",
    "http": "127.0.0.1:8080"
}
```

```bash
# 使用配置文件启动客户端
brook client -c config.json
```

### 系统代理配置

```bash
# Windows PowerShell 设置系统代理
netsh winhttp set proxy 127.0.0.1:1080

# 清除系统代理
netsh winhttp reset proxy

# 设置环境变量
set http_proxy=http://127.0.0.1:8080
set https_proxy=http://127.0.0.1:8080

# Linux/macOS 设置环境变量
export http_proxy=http://127.0.0.1:8080
export https_proxy=http://127.0.0.1:8080
export ALL_PROXY=socks5://127.0.0.1:1080
```

---

## 常见问题

### Q1: Brook 连接失败怎么办？

**排查步骤：**

1. **检查服务器状态**
   - 确认服务器端 Brook 正在运行
   - 检查服务器端口是否开放
   - 验证防火墙设置

2. **检查客户端配置**
   - 确认服务器地址和端口正确
   - 验证密码是否匹配
   - 检查本地代理端口是否被占用

3. **网络连通性测试**
   ```bash
   # 测试服务器连通性
   ping <服务器地址>
   
   # 测试端口是否开放
   telnet <服务器地址> <端口>
   
   # 使用 curl 测试代理
   curl -x socks5://127.0.0.1:1080 https://www.google.com
   ```

### Q2: 如何提高 Brook 代理速度？

**优化建议：**

1. **选择合适的服务器**
   - 选择距离较近的服务器
   - 选择带宽充足的服务器
   - 避免高峰时段使用

2. **优化网络配置**
   - 使用 WebSocket 协议可能更稳定
   - 调整 TCP 参数优化连接
   - 启用 TCP 快速打开

3. **减少不必要的流量**
   - 配置分流规则，只代理必要的流量
   - 使用本地 DNS 减少 DNS 查询延迟

### Q3: Brook 支持哪些平台？

Brook 支持以下平台：
- **Windows**: x86, x64, ARM, ARM64
- **macOS**: x64, ARM64 (Apple Silicon)
- **Linux**: x86, x64, ARM, ARM64, MIPS 等
- **Android**: ARM, ARM64, x86
- **iOS**: ARM64
- **路由器**: OpenWrt, DD-WRT 等

### Q4: 如何在路由器上使用 Brook？

**OpenWrt 路由器：**

1. 下载对应架构的 Brook 二进制文件
2. 上传到路由器
3. 配置启动脚本：

```bash
#!/bin/sh /etc/rc.common
START=99
STOP=10

start() {
    brook client -s <服务器>:<端口> -p <密码> -l :1080 &
}

stop() {
    killall brook
}
```

4. 配置路由器防火墙规则
5. 设置 iptables 代理规则

### Q5: 如何保护 Brook 服务器安全？

**安全建议：**

1. **使用强密码**
   - 使用长且复杂的密码
   - 定期更换密码

2. **限制访问**
   - 配置防火墙只允许特定 IP 访问
   - 使用 fail2ban 防止暴力破解

3. **定期更新**
   - 及时更新到最新版本
   - 关注安全公告

4. **监控日志**
   - 定期检查服务器日志
   - 发现异常及时处理

### Q6: Brook 和其他代理工具有什么区别？

**Brook 的优势：**
- 简单易用，配置简单
- 性能优秀，资源占用低
- 跨平台支持全面
- 代码开源透明

**适用场景：**
- 开发调试
- 临时代理需求
- 资源受限的环境
- 需要快速部署的场景

### Q7: 如何在 Docker 中运行 Brook？

```bash
# 创建 Dockerfile
cat << EOF > Dockerfile
FROM alpine:latest
COPY brook /usr/local/bin/
EXPOSE 1080
CMD ["brook", "server", "-l", ":1080", "-p", "mypassword"]
EOF

# 构建镜像
docker build -t brook .

# 运行容器
docker run -d -p 1080:1080 --name brook brook

# 使用 docker-compose
cat << EOF > docker-compose.yml
version: '3'
services:
  brook:
    image: brook
    ports:
      - "1080:1080"
    command: brook server -l :1080 -p mypassword
    restart: unless-stopped
EOF
```

### Q8: 如何调试 Brook 连接问题？

```bash
# 启用详细日志
brook client -s <服务器>:<端口> -p <密码> -l :1080 --debug

# 检查网络连接
curl -v -x socks5://127.0.0.1:1080 https://www.google.com

# 检查端口监听状态
netstat -tlnp | grep 1080
# 或
ss -tlnp | grep 1080

# 抓包分析
tcpdump -i eth0 port 1080
```

---

## 相关资源

### 官方资源
- [Brook GitHub 仓库](https://github.com/txthinking/brook)
- [Brook 官方文档](https://txthinking.github.io/brook/)
- [Brook 发行页面](https://github.com/txthinking/brook/releases)

### 安装与配置
- [Brook 安装指南](https://github.com/txthinking/brook#install)
- [Scoop 包管理器](https://scoop.sh/)

### 学习资源
- [网络代理基础知识](https://en.wikipedia.org/wiki/Proxy_server)
- [SOCKS 协议说明](https://en.wikipedia.org/wiki/SOCKS)
- [WebSocket 协议说明](https://en.wikipedia.org/wiki/WebSocket)

### 相关工具
- [Clash 代理工具](https://github.com/Dreamacro/clash)
- [V2Ray 代理平台](https://github.com/v2ray/v2ray-core)
- [Shadowsocks 代理工具](https://github.com/shadowsocks/shadowsocks-libev)

### 社区支持
- [GitHub Issues](https://github.com/txthinking/brook/issues)
- [GitHub Discussions](https://github.com/txthinking/brook/discussions)

### 安全相关
- [网络安全最佳实践](https://owasp.org/www-project-web-security-testing-guide/)
- [加密算法介绍](https://en.wikipedia.org/wiki/Encryption)
- [VPN 技术说明](https://en.wikipedia.org/wiki/Virtual_private_network)

---

## 更新日志

### v20240606
- 性能优化
- 修复已知问题
- 改进稳定性
- 更新依赖库

---

*本文档最后更新于：2026年5月27日*
