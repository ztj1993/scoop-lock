# Xray 使用指南

## 简介

Xray 是一个用于构建网络代理的平台工具，是 V2Ray 的社区分支项目，在 V2Ray 基础上增加了 XTLS 等性能优化技术。

它继承了 V2Ray 的所有核心功能，并在此基础上进一步提升了代理连接的性能和隐蔽性。

当前通过 Scoop 安装的版本为 **v25.1.30**，采用 **MPL-2.0** 许可证。

项目定位为 **"A platform for building proxies to bypass network restrictions"**。

官方网站：https://github.com/XTLS/Xray-core

Xray 的最大特色是 XTLS（eXtended Transport Layer Security）技术。

XTLS 可以在 TLS 加密的基础上进一步优化数据传输效率，显著减少 CPU 和内存的使用。

对于大流量传输场景，XTLS 的性能优势尤为明显，可以大幅降低延迟和资源消耗。

Xray 完全兼容 V2Ray 的配置格式和协议，可以无缝替代 V2Ray 使用。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v25.1.30                              |
| 许可证     | MPL-2.0                               |
| 项目主页   | https://github.com/XTLS/Xray-core    |
| 可执行文件 | xray.exe                              |
| 配置目录   | persist/data/xray/                    |

### 与 V2Ray 的关系

Xray 是 V2Ray-core 的分支，由 XTLS 社区维护。

Xray 完全兼容 V2Ray 的 v4 配置格式。

同时 Xray 引入了新的协议和功能，如 VLESS + XTLS、Reality 等。

Xray 的更新频率通常高于 V2Ray，新功能引入更快。

Scoop 安装时会持久化配置目录（persist/data/xray/），确保升级时保留配置。

### 核心优势

- XTLS 技术大幅优化 TLS 传输性能
- Reality 协议提供无需证书的伪装能力
- 完全兼容 V2Ray 配置和协议
- 更活跃的社区和更频繁的更新
- 更低的资源消耗和更高的传输效率

## 主要功能

### XTLS 传输技术

XTLS 是 Xray 的核心技术，是对标准 TLS 的扩展优化。

在标准 TLS 连接中，每个数据包都需要加解密，即使数据本身已经是加密的（如 HTTPS）。

XTLS 可以识别并跳过已加密数据的重复加解密，显著减少 CPU 开销。

对于视频流、文件下载等大流量场景，性能提升尤为明显。

支持 Vision 模式，无需特殊客户端即可享受 XTLS 加速。

### Reality 协议

Reality 是 Xray 引入的一种革命性代理协议，无需 TLS 证书即可实现伪装。

它可以将代理流量伪装成访问真实网站（如 yahoo.com）的 TLS 流量。

不需要域名、不需要 TLS 证书，大大降低了部署难度。

流量特征与真实 HTTPS 网站完全一致，具有极强的隐蔽性。

适用于对隐蔽性要求极高的使用场景。

### VLESS 协议增强

Xray 对 VLESS 协议进行了增强，支持 XTLS 和 Reality 传输。

VLESS + XTLS + Vision：高性能的 TLS 代理方案。

VLESS + Reality：无需证书的隐蔽代理方案。

VLESS + gRPC + TLS：利用 gRPC 传输的代理方案。

保留了对传统 VMess 协议的完整支持。

### 多协议兼容

Xray 支持 V2Ray 的所有代理协议。

**VLESS**：轻量级协议，Xray 重点优化的协议。

**VMess**：V2Ray 自研协议，Xray 完全兼容。

**Shadowsocks**：兼容 Shadowsocks 协议的多种加密方式。

**Trojan**：支持 Trojan 协议，与 TLS 深度集成。

**Socks/HTTP**：标准代理协议支持。

### 强大的路由功能

继承 V2Ray 的完整路由功能，支持基于域名、IP、协议等条件的流量分流。

内置 GeoIP 和 GeoSite 数据库，支持按地区和域名列表进行分流。

支持完整的路由规则配置，实现国内外分流等常见需求。

### DNS 解析控制

内置 DNS 服务器，支持精细化的域名解析控制。

支持 DNS over HTTPS (DoH) 和 DNS over TLS (DoT)。

可以配置不同的域名使用不同的 DNS 服务器。

配合路由系统实现完善的 DNS 分流策略。

## 常用操作

### 安装

通过 Scoop 安装 Xray：

```powershell
scoop install xray
```

安装完成后，`xray.exe` 会被添加到系统 PATH 中。

配置目录会被持久化到 `persist/data/xray/` 目录中。

### 配置文件

Xray 使用 JSON 格式的配置文件，兼容 V2Ray v4 配置格式。

一个基础的客户端配置文件示例（config.json）：

```json
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "tag": "socks-in",
      "port": 10808,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true
      }
    },
    {
      "tag": "http-in",
      "port": 10809,
      "listen": "127.0.0.1",
      "protocol": "http",
      "settings": {
        "auth": "noauth"
      }
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "your-server.com",
            "port": 443,
            "users": [
              {
                "id": "your-uuid-here",
                "flow": "xtls-rprx-vision",
                "encryption": "none"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "serverName": "your-server.com",
          "fingerprint": "chrome"
        }
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom"
    },
    {
      "tag": "block",
      "protocol": "blackhole"
    }
  ],
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "rules": [
      {
        "type": "field",
        "outboundTag": "direct",
        "domain": [
          "geosite:cn"
        ]
      },
      {
        "type": "field",
        "outboundTag": "direct",
        "ip": [
          "geoip:cn",
          "geoip:private"
        ]
      }
    ]
  }
}
```

### Reality 协议配置示例

服务端配置（outbounds 为 freedom，inbounds 为 VLESS + Reality）：

```json
{
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "your-uuid-here",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "reality",
        "realitySettings": {
          "show": false,
          "dest": "www.yahoo.com:443",
          "xver": 0,
          "serverNames": [
            "www.yahoo.com",
            "yahoo.com"
          ],
          "privateKey": "your-private-key",
          "shortIds": [
            "your-short-id"
          ]
        }
      }
    }
  ]
}
```

客户端对应配置：

```json
{
  "streamSettings": {
    "network": "tcp",
    "security": "reality",
    "realitySettings": {
      "serverName": "www.yahoo.com",
      "fingerprint": "chrome",
      "publicKey": "your-public-key",
      "shortId": "your-short-id",
      "spiderX": ""
    }
  }
}
```

### 启动 Xray

使用默认配置文件启动：

```powershell
xray run
```

指定配置文件路径：

```powershell
xray run -c C:\path\to\config.json
```

测试配置文件：

```powershell
xray run -test -c C:\path\to\config.json
```

### 生成工具

生成 UUID：

```powershell
xray uuid
```

生成 UUID 带短 ID：

```powershell
xray uuid -i "my-unique-string"
```

生成 TLS 证书：

```powershell
xray tls cert --domain example.com
```

生成 X25519 密钥对（用于 Reality）：

```powershell
xray x25519
```

### 查看版本信息

```powershell
xray version
```

### 配置为 Windows 服务

使用 WinSW 将 Xray 注册为 Windows 服务：

创建 `xray-service.xml` 文件：

```xml
<service>
  <id>xray</id>
  <name>Xray Service</name>
  <description>Xray 网络代理服务</description>
  <executable>%BASE%\xray.exe</executable>
  <arguments>run -c %BASE%\config.json</arguments>
  <logpath>%BASE%\logs</logpath>
  <logmode>rotate</logmode>
</service>
```

安装并启动服务：

```powershell
WinSW install xray-service.xml
net start xray
```

### 日志级别配置

Xray 支持以下日志级别：

| 级别    | 说明                     |
| ------- | ------------------------ |
| debug   | 输出所有调试信息         |
| info    | 输出一般性信息           |
| warning | 输出警告信息（推荐）     |
| error   | 仅输出错误信息           |
| none    | 不输出任何日志           |

### 常用命令行参数

```powershell
xray run                         # 使用默认配置启动
xray run -c config.json          # 指定配置文件
xray run -test                   # 测试配置文件
xray run -format json            # 指定配置文件格式
xray version                     # 查看版本
xray uuid                        # 生成 UUID
xray x25519                      # 生成 X25519 密钥对
```

## 常见问题

### 与 V2Ray 配置兼容性

**问题**：从 V2Ray 迁移到 Xray 后配置文件是否可以直接使用。

**解决方法**：
- Xray 完全兼容 V2Ray v4 配置格式，可以直接使用
- 将 V2Ray 的 config.json 直接复制到 Xray 的配置目录即可
- 如需使用 XTLS、Reality 等新功能，需要修改相关配置
- 建议迁移后使用 `xray run -test` 验证配置

### XTLS 连接失败

**问题**：配置 XTLS 后客户端无法连接。

**解决方法**：
- 确认服务端支持并启用了 XTLS
- 检查 `flow` 参数是否正确设置为 `xtls-rprx-vision`
- 确认 TLS 证书配置正确
- 验证客户端和服务端的 XTLS 版本兼容
- 检查 serverName 是否与证书匹配

### Reality 协议配置错误

**问题**：配置 Reality 协议后连接失败。

**解决方法**：
- 确认使用 `xray x25519` 生成的密钥对配置正确
- 公钥放在客户端，私钥放在服务端
- 检查 `serverNames` 和 `dest` 配置是否一致
- 确认 `shortIds` 配置在客户端和服务端一致
- 验证目标网站（如 yahoo.com）可正常访问

### 配置文件语法错误

**问题**：启动时提示 JSON 解析错误。

**解决方法**：
- 使用 `xray run -test` 检查配置文件语法
- 确保 JSON 格式正确，检查多余的逗号和缺失的引号
- 注意 Windows 路径中的反斜杠需要转义
- 使用在线 JSON 校验工具进行检查

### 端口被占用

**问题**：启动时提示端口已被占用。

**解决方法**：
- 使用 `netstat -ano | findstr :端口号` 查找占用进程
- 修改配置中的端口号
- 停止占用端口的程序
- 检查是否有其他 Xray 或 V2Ray 实例在运行

### GeoIP/GeoSite 数据库缺失

**问题**：路由规则中的 geosite: 和 geoip: 引用不生效。

**解决方法**：
- 确认 GeoIP 和 GeoSite 数据库文件存在于 Xray 资源目录中
- 下载最新的 geoip.dat 和 geosite.dat 文件
- 设置环境变量 `XRAY_LOCATION_ASSET` 指向资源文件目录
- 从 GitHub Release 页面下载最新的资源文件

### Scoop 升级后配置丢失

**问题**：升级 Xray 后需要重新配置。

**解决方法**：
- 配置文件应放在 `persist/data/xray/` 目录中
- Scoop 在升级时会保留 persist 目录内容
- 如手动将配置放在其他位置，建议定期备份
- 使用 `scoop pin xray` 可以锁定版本防止自动升级

## 相关资源

### 官方资源

- Xray GitHub 仓库：https://github.com/XTLS/Xray-core
- Xray 官方文档：https://xtls.github.io/
- Xray 配置指南：https://xtls.github.io/config/
- 发布页面：https://github.com/XTLS/Xray-core/releases
- 问题反馈：https://github.com/XTLS/Xray-core/issues

### V2Ray 相关

- V2Fly 官方网站：https://www.v2fly.org/en_US/
- V2Ray GitHub 仓库：https://github.com/v2fly/v2ray-core
- V2Ray 配置参考：https://www.v2fly.org/en_US/v5/config/overview.html

### 社区资源

- XTLS 项目：https://github.com/XTLS
- Xray 教程集：https://xtls.github.io/document/level-0/
- Awesome Xray：https://github.com/XTLS/awesome-xray

### 相关工具

- **V2RayN**：Windows 平台的 V2Ray/Xray 图形客户端
- **V2RayU**：macOS 平台的 V2Ray/Xray 图形客户端
- **Clash**：跨平台规则化代理工具，支持 Xray
- **Sing-box**：通用代理平台，支持 Xray 协议
- **WinSW**：将 Xray 注册为 Windows 服务的工具

### 许可证说明

Xray 采用 MPL-2.0 许可证，允许自由使用、修改和分发。

使用 Xray 时请遵守当地法律法规。
