# V2Ray 使用指南

## 简介

V2Ray 是一个用于构建网络代理的平台工具，旨在帮助用户绕过网络限制，实现自由访问互联网。

V2Ray 是 Project V 的核心组件，Project V 是一组用于构建特定网络环境的工具集合。

当前通过 Scoop 安装的版本为 **v5.26.0**，采用 **MIT** 许可证。

项目定位为 **"A platform for building proxies to bypass network restrictions"**。

官方网站：https://www.v2fly.org/en_US/

V2Ray 支持多种代理协议，包括 VMess、VLESS、Shadowsocks、Trojan 等。

它具有强大的路由功能，可以根据域名、IP、地理位置等条件灵活地分流流量。

V2Ray 的架构设计高度模块化，支持自定义传输层配置，满足不同网络环境的需求。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v5.26.0                               |
| 许可证     | MIT                                   |
| 项目主页   | https://www.v2fly.org/en_US/          |
| 可执行文件 | v2ray.exe                             |
| 配置目录   | persist/data/v2ray/                   |

### 与 V2Ray 的关系

V2Ray 最初由 V2Ray 社区维护，后由 V2Fly 社区继续发展。

v5.x 版本引入了全新的配置格式（v5 配置），但仍然兼容旧版 v4 配置格式。

Scoop 安装时会持久化配置目录（persist/data/v2ray/），确保升级时不会丢失配置。

### 依赖说明

V2Ray 在 Windows 上依赖 **WinSW** 来注册为 Windows 服务。

通过 Scoop 安装时，WinSW 会作为依赖项自动安装。

## 主要功能

### 多协议支持

V2Ray 原生支持多种代理协议，满足不同的使用场景。

**VMess 协议**：V2Ray 自研协议，基于 UUID 认证，支持动态端口。

**VLESS 协议**：VMess 的轻量级替代方案，去除了加密层，配合 TLS 使用时性能更优。

**Shadowsocks 协议**：兼容传统 Shadowsocks 协议，支持多种加密方式。

**Trojan 协议**：模拟 HTTPS 流量，具有较好的隐蔽性。

**Socks/HTTP**：支持标准的 SOCKS5 和 HTTP 代理协议。

### 传输层配置

支持多种传输方式，包括 TCP、WebSocket、HTTP/2、gRPC、QUIC 等。

每种传输方式都可以进行详细的参数配置。

支持 TLS 加密传输，可配置证书和密钥路径。

WebSocket 传输配合 CDN 可以实现流量中转和伪装。

### 强大的路由系统

内置基于规则的路由引擎，可以灵活地将流量分配到不同的出站代理。

支持基于域名的路由规则（精确匹配、后缀匹配、正则匹配、关键词匹配）。

支持基于 IP 的路由规则（CIDR、GeoIP）。

支持基于协议和端口的路由规则。

内置 GeoIP 和 GeoSite 数据库，支持按国家/地区和域名列表分流。

可以配置直连、代理和阻止三种出站行为。

### 多出站支持

支持同时配置多个出站代理，每个出站可使用不同的协议和服务器。

支持负载均衡策略（随机、轮询、最少连接等）。

支持出站代理链（Freedom 出站、Blackhole 出站等）。

### 内置 DNS 服务器

V2Ray 内置 DNS 服务器，支持域名解析的精细化控制。

可以配置不同的域名使用不同的 DNS 服务器。

支持 DNS over HTTPS (DoH) 和 DNS over TLS (DoT)。

可以配合路由系统实现国内域名直连、国外域名代理的分流策略。

### 流量统计

内置流量统计功能，可以记录上传和下载的数据量。

支持按用户、按入站/出站连接分别统计。

可通过 API 接口查询统计数据。

## 常用操作

### 安装

通过 Scoop 安装 V2Ray：

```powershell
scoop install v2ray
```

安装完成后，`v2ray.exe` 会被添加到系统 PATH 中。

配置目录会被持久化到 `persist/data/v2ray/` 目录中。

### 配置文件

V2Ray 使用 JSON 格式的配置文件。Scoop 安装后配置文件位于持久化目录中。

一个基础的客户端配置文件示例（config.json）：

```json
{
  "log": {
    "loglevel": "warning",
    "access": "./access.log",
    "error": "./error.log"
  },
  "inbounds": [
    {
      "tag": "socks-in",
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true
      }
    },
    {
      "tag": "http-in",
      "port": 10809,
      "protocol": "http",
      "settings": {
        "auth": "noauth"
      }
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "your-server.com",
            "port": 443,
            "users": [
              {
                "id": "your-uuid-here",
                "alterId": 0,
                "security": "auto"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "wsSettings": {
          "path": "/your-path"
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

### 启动 V2Ray

使用默认配置文件启动：

```powershell
v2ray run
```

指定配置文件路径：

```powershell
v2ray run -c C:\path\to\config.json
```

使用旧版 v4 格式配置：

```powershell
v2ray run -c C:\path\to\config_v4.json
```

测试配置文件是否正确：

```powershell
v2ray test -c C:\path\to\config.json
```

### 配置为 Windows 服务

使用 WinSW 将 V2Ray 注册为 Windows 服务：

创建 `v2ray-service.xml` 文件：

```xml
<service>
  <id>v2ray</id>
  <name>V2Ray Service</name>
  <description>V2Ray 网络代理服务</description>
  <executable>%BASE%\v2ray.exe</executable>
  <arguments>run -c %BASE%\config.json</arguments>
  <logpath>%BASE%\logs</logpath>
  <logmode>rotate</logmode>
</service>
```

安装并启动服务：

```powershell
WinSW install v2ray-service.xml
net start v2ray
```

### 生成 UUID

V2Ray 使用 UUID 进行身份验证，可以使用以下命令生成：

```powershell
v2ray uuid
```

### 生成随机端口

```powershell
v2ray randport
```

### 查看版本信息

```powershell
v2ray version
```

### 日志级别配置

V2Ray 支持以下日志级别：

| 级别    | 说明                     |
| ------- | ------------------------ |
| debug   | 输出所有调试信息         |
| info    | 输出一般性信息           |
| warning | 输出警告信息（推荐）     |
| error   | 仅输出错误信息           |
| none    | 不输出任何日志           |

生产环境建议使用 `warning` 或 `error` 级别。

### 常用环境变量

V2Ray 支持通过环境变量影响运行行为：

- `V2RAY_LOCATION_ASSET`：资源文件目录（GeoIP、GeoSite 数据库）
- `V2RAY_LOCATION_CONFIG`：配置文件默认查找目录

## 常见问题

### 配置文件语法错误

**问题**：启动时提示 JSON 解析错误。

**解决方法**：
- 使用 `v2ray test` 命令检查配置文件
- 确保 JSON 格式正确，注意逗号和引号
- 使用在线 JSON 验证工具检查语法
- 特别注意 Windows 路径中的反斜杠需要转义

### 端口被占用

**问题**：启动时提示端口已被占用。

**解决方法**：
- 使用 `netstat -ano | findstr :端口号` 查找占用端口的程序
- 修改配置文件中的端口号
- 停止占用端口的程序后再启动

### 无法连接远程服务器

**问题**：配置完成后无法通过代理访问网络。

**解决方法**：
- 检查服务器地址和端口是否正确
- 确认 UUID 和传输协议与服务端一致
- 检查 TLS 证书配置是否正确
- 查看错误日志获取详细信息
- 确认本地防火墙未阻止连接

### 路由规则不生效

**问题**：配置了路由规则但流量未按预期分流。

**解决方法**：
- 检查路由规则的优先级，规则按配置顺序从上到下匹配
- 确认 GeoIP 和 GeoSite 数据库文件存在且路径正确
- 使用日志功能确认匹配的规则
- 检查 `domainStrategy` 设置

### DNS 泄漏

**问题**：使用代理后 DNS 查询仍然走本地 DNS。

**解决方法**：
- 在配置中启用内置 DNS 服务器
- 配置远程 DNS 服务器地址
- 在路由规则中将 DNS 流量路由到代理出站
- 操作系统层面设置 DNS 为 127.0.0.1

### Scoop 升级后配置丢失

**问题**：通过 `scoop update v2ray` 升级后需要重新配置。

**解决方法**：
- 配置文件应放在 `persist/data/v2ray/` 目录中
- Scoop 会在升级时保留 persist 目录的内容
- 如果手动将配置放在其他位置，建议定期备份

### 性能不佳

**问题**：代理速度较慢或延迟较高。

**解决方法**：
- 尝试不同的传输协议（WebSocket、gRPC 等）
- 启用 mKCP 协议以降低延迟（但可能消耗更多流量）
- 选择地理位置更近的服务器
- 检查是否启用了不必要的日志级别（debug 会影响性能）

## 相关资源

### 官方资源

- V2Fly 官方网站：https://www.v2fly.org/en_US/
- V2Ray GitHub 仓库：https://github.com/v2fly/v2ray-core
- 官方配置指南：https://www.v2fly.org/en_US/v5/config/overview.html
- 发布页面：https://github.com/v2fly/v2ray-core/releases

### 配置参考

- V2Ray v5 配置文档：https://www.v2fly.org/en_US/v5/config/
- 协议详解：https://www.v2fly.org/en_US/v5/config/protocols/
- 传输层配置：https://www.v2fly.org/en_US/v5/config/stream.html
- 路由配置：https://www.v2fly.org/en_US/v5/config/routing.html

### 社区资源

- V2Fly 社区：https://github.com/v2fly
- V2Ray 教程集：https://guide.v2fly.org/
- Awesome V2Ray：https://github.com/v2fly/awesome-v2ray

### 相关工具

- **V2RayN**：Windows 平台的 V2Ray 图形客户端
- **V2RayU**：macOS 平台的 V2Ray 图形客户端
- **Qv2ray**：跨平台 V2Ray 图形客户端
- **Xray**：V2Ray 的分支项目，添加了 XTLS 等功能
- **WinSW**：将 V2Ray 注册为 Windows 服务的工具

### 许可证说明

V2Ray 采用 MIT 许可证，允许自由使用、修改和分发。

使用 V2Ray 时请遵守当地法律法规。
