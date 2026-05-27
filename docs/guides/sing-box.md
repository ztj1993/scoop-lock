# sing-box v1.11.1 使用指南

## 简介

sing-box 是一个通用的代理平台，提供了多种代理协议和网络工具。版本 v1.11.1 提供了最新的代理功能和性能优化，是网络代理和隐私保护的强大工具。

sing-box 由 SagerNet 团队开发，使用 Go 语言编写，具有高性能、跨平台、易于配置等特点。它支持多种代理协议，包括 Shadowsocks、VMess、VLESS、Trojan、Hysteria 等。

该工具提供了丰富的网络功能，包括透明代理、TUN 模式、DNS 代理、路由规则等。它可以用于网络加速、隐私保护、访问控制等多种场景。

sing-box 支持多种操作系统，包括 Windows、macOS、Linux、Android、iOS 等。它的配置文件采用 JSON 格式，易于理解和修改。

本指南将详细介绍 sing-box 的安装、配置和使用方法，帮助用户充分利用这个强大的代理平台工具。

## 主要功能

### 代理协议支持

sing-box 支持多种主流的代理协议，每种协议都有其特点和适用场景。Shadowsocks 是一种轻量级的代理协议，具有简单、高效的特点。

VMess 是 V2Ray 的传输协议，提供了更好的安全性和性能。VLESS 是 VMess 的改进版本，去除了加密头部，提供了更低的延迟。

Trojan 协议模拟 HTTPS 流量，具有很好的伪装性。Hysteria 协议基于 QUIC，提供了高速的传输性能。

还支持 WireGuard、SSH、HTTP、SOCKS 等多种协议，满足不同的使用需求。

### 传输协议支持

sing-box 支持多种传输协议，包括 TCP、WebSocket、HTTP/2、gRPC、QUIC 等。不同的传输协议适用于不同的网络环境和需求。

TCP 是最基础的传输协议，适用于大多数网络环境。WebSocket 协议可以穿越 WebSocket 代理，适用于 CDN 和反向代理场景。

HTTP/2 协议支持多路复用，可以提高传输效率。gRPC 协议基于 HTTP/2，提供了更好的性能和流式传输支持。

QUIC 协议基于 UDP，提供了更低的延迟和更好的拥塞控制。Hysteria 协议就是基于 QUIC 实现的。

### 伪装和混淆

sing-box 提供了多种伪装和混淆功能，可以隐藏代理流量的特征。TLS 伪装可以将代理流量伪装成 HTTPS 流量。

WebSocket 伪装可以将代理流量伪装成 WebSocket 流量，适用于 CDN 和反向代理场景。HTTP/2 伪装可以将代理流量伪装成 HTTP/2 流量。

还支持流量混淆，可以打乱流量的统计特征，增加检测难度。包括随机填充、流量分割等混淆方式。

### 路由规则

sing-box 提供了强大的路由规则功能，可以根据不同的条件将流量路由到不同的出口。支持基于域名、IP、端口、协议等条件的路由。

域名路由支持精确匹配、后缀匹配、正则表达式匹配等多种匹配方式。IP 路由支持 CIDR 匹配、GeoIP 匹配等。

端口路由可以将特定端口的流量路由到指定出口。协议路由可以根据 HTTP、HTTPS、DNS 等协议进行路由。

还支持规则集，可以导入和管理大量的路由规则。支持 GeoIP 和 GeoSite 数据库，可以基于地理位置和域名分类进行路由。

### DNS 功能

sing-box 提供了完整的 DNS 功能，可以作为本地 DNS 服务器使用。支持 DNS over HTTPS (DoH)、DNS over TLS (DoT)、DNS over QUIC (DoQ) 等加密 DNS 协议。

支持 DNS 缓存，可以缓存 DNS 查询结果，提高解析速度。支持 DNS 劫持，可以将 DNS 查询重定向到指定的 DNS 服务器。

支持 DNS 路由，可以根据域名将 DNS 查询路由到不同的 DNS 服务器。支持 FakeIP，可以为域名分配假的 IP 地址，用于实现域名级别的路由。

### TUN 模式

sing-box 支持 TUN 模式，可以创建虚拟网卡接管系统流量。TUN 模式可以实现透明代理，无需配置应用程序的代理设置。

支持 IPv4 和 IPv6 双栈，可以处理所有类型的网络流量。支持 TCP 和 UDP 流量，可以代理所有类型的网络应用。

TUN 模式支持自动配置，可以自动设置路由和 DNS。支持排除特定应用程序或 IP 范围，避免代理不需要的流量。

### 服务模式

sing-box 支持多种运行模式，包括客户端模式、服务器模式和中继模式。客户端模式用于连接远程代理服务器。

服务器模式用于提供代理服务，可以接受客户端的连接。中继模式用于转发流量，可以实现多级代理。

支持混合模式，可以在一个实例中同时运行客户端和服务器模式。支持多用户管理，可以为不同的用户配置不同的权限。

### 配置管理

sing-box 使用 JSON 格式的配置文件，结构清晰，易于理解。支持配置文件的导入和导出，方便备份和迁移。

支持环境变量，可以在配置文件中使用环境变量，提高配置的灵活性。支持配置文件的验证，可以在启动前检查配置文件的正确性。

支持热重载，可以在运行时重新加载配置文件，无需重启服务。支持 API 接口，可以通过 HTTP API 管理 sing-box 实例。

## 常用命令/操作

### 安装和启动

通过 Scoop 安装 sing-box：
```bash
scoop install sing-box
```

查看版本信息：
```bash
sing-box version
```

检查配置文件：
```bash
sing-box check -c config.json
```

启动服务：
```bash
sing-box run -c config.json
```

以服务模式运行：
```bash
sing-box service install -c config.json
sing-box service start
```

### 配置文件结构

**基本配置结构**：
```json
{
  "log": {
    "level": "info",
    "timestamp": true
  },
  "dns": {
    "servers": [],
    "rules": []
  },
  "inbounds": [],
  "outbounds": [],
  "route": {
    "rules": [],
    "final": "direct"
  }
}
```

### 入站配置

**HTTP 入站**：
```json
{
  "type": "http",
  "tag": "http-in",
  "listen": "127.0.0.1",
  "listen_port": 8080
}
```

**SOCKS 入站**：
```json
{
  "type": "socks",
  "tag": "socks-in",
  "listen": "127.0.0.1",
  "listen_port": 1080
}
```

**混合入站**：
```json
{
  "type": "mixed",
  "tag": "mixed-in",
  "listen": "127.0.0.1",
  "listen_port": 2080
}
```

**TUN 入站**：
```json
{
  "type": "tun",
  "tag": "tun-in",
  "interface_name": "tun0",
  "inet4_address": "172.19.0.1/30",
  "auto_route": true,
  "strict_route": true,
  "stack": "system"
}
```

### 出站配置

**Shadowsocks 出站**：
```json
{
  "type": "shadowsocks",
  "tag": "ss-out",
  "server": "server.example.com",
  "server_port": 8388,
  "method": "aes-256-gcm",
  "password": "password"
}
```

**VMess 出站**：
```json
{
  "type": "vmess",
  "tag": "vmess-out",
  "server": "server.example.com",
  "server_port": 443,
  "uuid": "uuid",
  "security": "auto",
  "transport": {
    "type": "ws",
    "path": "/ws"
  },
  "tls": {
    "enabled": true,
    "server_name": "server.example.com"
  }
}
```

**VLESS 出站**：
```json
{
  "type": "vless",
  "tag": "vless-out",
  "server": "server.example.com",
  "server_port": 443,
  "uuid": "uuid",
  "flow": "xtls-rprx-vision",
  "transport": {
    "type": "grpc",
    "service_name": "grpc"
  },
  "tls": {
    "enabled": true,
    "server_name": "server.example.com"
  }
}
```

**Trojan 出站**：
```json
{
  "type": "trojan",
  "tag": "trojan-out",
  "server": "server.example.com",
  "server_port": 443,
  "password": "password",
  "transport": {
    "type": "ws",
    "path": "/trojan"
  },
  "tls": {
    "enabled": true,
    "server_name": "server.example.com"
  }
}
```

**Hysteria 出站**：
```json
{
  "type": "hysteria",
  "tag": "hysteria-out",
  "server": "server.example.com",
  "server_port": 443,
  "up_mbps": 100,
  "down_mbps": 100,
  "password": "password",
  "tls": {
    "enabled": true,
    "server_name": "server.example.com"
  }
}
```

**WireGuard 出站**：
```json
{
  "type": "wireguard",
  "tag": "wg-out",
  "server": "server.example.com",
  "server_port": 51820,
  "local_address": [
    "10.0.0.2/32",
    "fd00::2/128"
  ],
  "private_key": "private_key",
  "peer_public_key": "peer_public_key"
}
```

**直连出站**：
```json
{
  "type": "direct",
  "tag": "direct"
}
```

**阻断出站**：
```json
{
  "type": "block",
  "tag": "block"
}
```

**DNS 出站**：
```json
{
  "type": "dns",
  "tag": "dns-out"
}
```

### DNS 配置

**DNS 服务器配置**：
```json
{
  "servers": [
    {
      "tag": "google",
      "address": "tls://8.8.8.8",
      "detour": "proxy"
    },
    {
      "tag": "local",
      "address": "223.5.5.5",
      "detour": "direct"
    }
  ]
}
```

**DNS 规则配置**：
```json
{
  "rules": [
    {
      "domain": [
        "google.com",
        "youtube.com"
      ],
      "server": "google"
    },
    {
      "domain_suffix": ".cn",
      "server": "local"
    }
  ],
  "final": "local"
}
```

**FakeIP 配置**：
```json
{
  "fakeip": {
    "enabled": true,
    "inet4_range": "198.18.0.0/15",
    "inet6_range": "fc00::/18"
  }
}
```

### 路由规则配置

**域名规则**：
```json
{
  "domain": [
    "google.com",
    "youtube.com"
  ],
  "outbound": "proxy"
}
```

**域名后缀规则**：
```json
{
  "domain_suffix": ".cn",
  "outbound": "direct"
}
```

**域名正则规则**：
```json
{
  "domain_regex": "^ads\\.",
  "outbound": "block"
}
```

**IP 规则**：
```json
{
  "ip_cidr": [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ],
  "outbound": "direct"
}
```

**GeoIP 规则**：
```json
{
  "geoip": "cn",
  "outbound": "direct"
}
```

**GeoSite 规则**：
```json
{
  "geosite": "category-ads-all",
  "outbound": "block"
}
```

**端口规则**：
```json
{
  "port": [80, 443],
  "outbound": "proxy"
}
```

**协议规则**：
```json
{
  "protocol": "dns",
  "outbound": "dns-out"
}
```

**规则集配置**：
```json
{
  "rule_set": [
    {
      "tag": "geosite-cn",
      "type": "remote",
      "format": "binary",
      "url": "https://example.com/geosite-cn.srs",
      "download_detour": "direct"
    }
  ]
}
```

### TLS 配置

**基本 TLS 配置**：
```json
{
  "tls": {
    "enabled": true,
    "server_name": "server.example.com",
    "insecure": false
  }
}
```

**TLS 指纹配置**：
```json
{
  "tls": {
    "enabled": true,
    "server_name": "server.example.com",
    "utls": {
      "enabled": true,
      "fingerprint": "chrome"
    }
  }
}
```

**Reality 配置**：
```json
{
  "tls": {
    "enabled": true,
    "server_name": "www.microsoft.com",
    "reality": {
      "enabled": true,
      "public_key": "public_key",
      "short_id": "short_id"
    }
  }
}
```

### 传输配置

**WebSocket 传输**：
```json
{
  "transport": {
    "type": "ws",
    "path": "/ws",
    "headers": {
      "Host": "server.example.com"
    }
  }
}
```

**HTTP/2 传输**：
```json
{
  "transport": {
    "type": "http",
    "host": "server.example.com",
    "path": "/h2"
  }
}
```

**gRPC 传输**：
```json
{
  "transport": {
    "type": "grpc",
    "service_name": "grpc"
  }
}
```

**QUIC 传输**：
```json
{
  "transport": {
    "type": "quic"
  }
}
```

### 服务管理

**安装服务**：
```bash
sing-box service install -c config.json
```

**启动服务**：
```bash
sing-box service start
```

**停止服务**：
```bash
sing-box service stop
```

**卸载服务**：
```bash
sing-box service uninstall
```

**查看服务状态**：
```bash
sing-box service status
```

### API 接口

**获取服务状态**：
```bash
curl http://127.0.0.1:9090/status
```

**获取连接信息**：
```bash
curl http://127.0.0.1:9090/connections
```

**关闭连接**：
```bash
curl -X DELETE http://127.0.0.1:9090/connections
```

**重新加载配置**：
```bash
curl -X POST http://127.0.0.1:9090/reload
```

## 常见问题

### 启动失败

**问题描述**：sing-box 无法启动或启动后立即退出。

**解决方案**：
1. 检查配置文件语法
2. 验证端口是否被占用
3. 检查权限设置
4. 查看错误日志

**配置检查**：
```bash
sing-box check -c config.json
```

**查看日志**：
```bash
sing-box run -c config.json -D /var/log/sing-box
```

### 连接问题

**问题描述**：无法连接到代理服务器。

**解决方案**：
1. 检查服务器地址和端口
2. 验证认证信息
3. 检查网络连接
4. 查看连接日志

**测试连接**：
```bash
curl -x socks5://127.0.0.1:1080 https://www.google.com
```

### DNS 解析问题

**问题描述**：DNS 解析失败或解析缓慢。

**解决方案**：
1. 检查 DNS 配置
2. 验证 DNS 服务器可达性
3. 调整 DNS 缓存设置
4. 使用本地 DNS 服务器

**DNS 测试**：
```bash
nslookup google.com 127.0.0.1
```

### TUN 模式问题

**问题描述**：TUN 模式无法正常工作。

**解决方案**：
1. 检查管理员权限
2. 验证 TUN 驱动安装
3. 检查路由配置
4. 查看系统日志

**权限检查**：
```bash
# Windows 需要管理员权限
# Linux 需要 root 权限
sudo sing-box run -c config.json
```

### 性能问题

**问题描述**：代理速度慢或延迟高。

**解决方案**：
1. 选择合适的代理协议
2. 优化传输配置
3. 使用就近的服务器
4. 调整缓冲区大小

**性能优化**：
```json
{
  "experimental": {
    "clash_api": {
      "external_controller": "127.0.0.1:9090"
    }
  }
}
```

### 规则匹配问题

**问题描述**：路由规则不生效或匹配错误。

**解决方案**：
1. 检查规则语法
2. 验证规则顺序
3. 使用日志调试
4. 测试规则匹配

**规则调试**：
```json
{
  "log": {
    "level": "debug"
  }
}
```

### 兼容性问题

**问题描述**：与其他软件冲突或不兼容。

**解决方案**：
1. 检查端口冲突
2. 避免同时使用多个代理
3. 调整网络配置
4. 更新软件版本

## 相关资源

### 官方资源

- **官方网站**：https://sing-box.sagernet.org/
- **文档**：https://sing-box.sagernet.org/configuration/
- **下载页面**：https://sing-box.sagernet.org/installation/
- **版本历史**：https://sing-box.sagernet.org/changelog/

### 学习资源

- **快速入门**：https://sing-box.sagernet.org/quick-start/
- **配置示例**：https://sing-box.sagernet.org/configuration/
- **协议文档**：https://sing-box.sagernet.org/configuration/outbound/
- **常见问题**：https://sing-box.sagernet.org/faq/

### 社区资源

- **GitHub**：https://github.com/SagerNet/sing-box
- **Telegram**：https://t.me/sagernet
- **Discord**：https://discord.gg/sagernet

### 相关工具

- **sing-box for Android**：Android 客户端
- **sing-box for iOS**：iOS 客户端
- **Clash Verge**：图形界面客户端
- **NekoBox**：跨平台客户端

### 许可信息

- **许可证**：GPL-3.0
- **版权声明**：Copyright 2022-2024 SagerNet
- **分发条款**：可以自由使用、修改和分发，但需要开源

### 技术支持

- **问题报告**：https://github.com/SagerNet/sing-box/issues
- **功能请求**：https://github.com/SagerNet/sing-box/issues
- **安全报告**：https://github.com/SagerNet/sing-box/security

### 版本信息

- **当前版本**：v1.11.1
- **发布日期**：2024 年
- **更新频率**：定期发布
- **支持平台**：Windows、macOS、Linux、Android、iOS

### 系统要求

**Windows**：
- Windows 10/11（64 位）
- 1GB RAM
- 50MB 磁盘空间

**macOS**：
- macOS 10.15 或更高版本
- 1GB RAM
- 50MB 磁盘空间

**Linux**：
- Linux 2.6 或更高版本
- 1GB RAM
- 50MB 磁盘空间

### 功能对比

| 协议 | 加密 | 伪装 | 速度 | 安全性 |
|------|------|------|------|--------|
| Shadowsocks | 强 | 弱 | 快 | 高 |
| VMess | 强 | 强 | 中 | 高 |
| VLESS | 强 | 强 | 快 | 高 |
| Trojan | 强 | 强 | 快 | 高 |
| Hysteria | 强 | 中 | 极快 | 高 |
| WireGuard | 强 | 中 | 极快 | 高 |

### 最佳实践

**配置优化**：
1. 使用合理的路由规则
2. 配置 DNS 缓存
3. 启用流量统计
4. 定期更新配置

**安全建议**：
1. 使用强密码
2. 启用 TLS 加密
3. 定期更换端口
4. 监控连接日志

**性能优化**：
1. 选择合适的协议
2. 使用就近服务器
3. 调整缓冲区大小
4. 启用多路复用

### 故障排除清单

- [ ] 检查配置文件语法
- [ ] 验证服务器连接
- [ ] 检查端口占用
- [ ] 查看错误日志
- [ ] 测试网络连接
- [ ] 验证认证信息
- [ ] 检查防火墙设置
- [ ] 更新软件版本

### 快速入门示例

**基本客户端配置**：
```json
{
  "log": {
    "level": "info",
    "timestamp": true
  },
  "inbounds": [
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "127.0.0.1",
      "listen_port": 2080
    }
  ],
  "outbounds": [
    {
      "type": "shadowsocks",
      "tag": "proxy",
      "server": "server.example.com",
      "server_port": 8388,
      "method": "aes-256-gcm",
      "password": "password"
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "rules": [
      {
        "domain_suffix": ".cn",
        "outbound": "direct"
      },
      {
        "geoip": "cn",
        "outbound": "direct"
      }
    ],
    "final": "proxy"
  }
}
```

**TUN 模式配置**：
```json
{
  "inbounds": [
    {
      "type": "tun",
      "tag": "tun-in",
      "interface_name": "tun0",
      "inet4_address": "172.19.0.1/30",
      "auto_route": true,
      "strict_route": true,
      "stack": "system",
      "sniff": true
    }
  ]
}
```

**DNS 配置示例**：
```json
{
  "dns": {
    "servers": [
      {
        "tag": "proxy-dns",
        "address": "tls://8.8.8.8",
        "detour": "proxy"
      },
      {
        "tag": "direct-dns",
        "address": "223.5.5.5",
        "detour": "direct"
      }
    ],
    "rules": [
      {
        "domain": [
          "google.com",
          "youtube.com"
        ],
        "server": "proxy-dns"
      },
      {
        "domain_suffix": ".cn",
        "server": "direct-dns"
      }
    ],
    "final": "direct-dns",
    "fakeip": {
      "enabled": true,
      "inet4_range": "198.18.0.0/15"
    }
  }
}
```

### 高级配置

**多服务器负载均衡**：
```json
{
  "outbounds": [
    {
      "type": "selector",
      "tag": "proxy",
      "outbounds": [
        "server1",
        "server2",
        "server3"
      ],
      "default": "server1"
    },
    {
      "type": "shadowsocks",
      "tag": "server1",
      "server": "server1.example.com",
      "server_port": 8388,
      "method": "aes-256-gcm",
      "password": "password1"
    },
    {
      "type": "shadowsocks",
      "tag": "server2",
      "server": "server2.example.com",
      "server_port": 8388,
      "method": "aes-256-gcm",
      "password": "password2"
    }
  ]
}
```

**URLTest 自动选择**：
```json
{
  "type": "urltest",
  "tag": "auto",
  "outbounds": [
    "server1",
    "server2",
    "server3"
  ],
  "url": "https://www.gstatic.com/generate_204",
  "interval": "3m",
  "tolerance": 50
}
```

**链式代理**：
```json
{
  "outbounds": [
    {
      "type": "selector",
      "tag": "proxy",
      "outbounds": [
        "direct-chain",
        "proxy-chain"
      ]
    },
    {
      "type": "direct",
      "tag": "direct-chain",
      "detour": "entry"
    },
    {
      "type": "shadowsocks",
      "tag": "proxy-chain",
      "detour": "entry",
      "server": "final.example.com",
      "server_port": 8388,
      "method": "aes-256-gcm",
      "password": "password"
    },
    {
      "type": "shadowsocks",
      "tag": "entry",
      "server": "entry.example.com",
      "server_port": 8388,
      "method": "aes-256-gcm",
      "password": "password"
    }
  ]
}
```

### 测试和调试

**配置测试**：
```bash
sing-box check -c config.json
```

**日志级别**：
```json
{
  "log": {
    "level": "debug",
    "output": "error.log",
    "timestamp": true
  }
}
```

**连接测试**：
```bash
curl -x socks5://127.0.0.1:1080 https://www.google.com
curl -x http://127.0.0.1:8080 https://www.google.com
```

**性能测试**：
```bash
# 使用 iperf3 测试速度
iperf3 -c server.example.com -p 5201
```

### 监控和统计

**API 监控**：
```bash
# 获取服务状态
curl http://127.0.0.1:9090/status

# 获取连接信息
curl http://127.0.0.1:9090/connections

# 获取内存使用
curl http://127.0.0.1:9090/memory
```

**日志分析**：
```bash
# 查看实时日志
tail -f /var/log/sing-box/error.log

# 分析连接日志
grep "connection" /var/log/sing-box/error.log
```

### 安全配置

**访问控制**：
```json
{
  "experimental": {
    "clash_api": {
      "external_controller": "127.0.0.1:9090",
      "external_ui": "ui",
      "external_ui_download_url": "https://github.com/MetaCubeX/metacubexd/archive/refs/heads/gh-pages.zip",
      "secret": "your_secret_key"
    }
  }
}
```

**TLS 配置**：
```json
{
  "tls": {
    "enabled": true,
    "server_name": "server.example.com",
    "alpn": ["h2", "http/1.1"],
    "min_version": "1.2",
    "max_version": "1.3"
  }
}
```