# gfw-pac 使用指南

## 简介

[gfw-pac](https://github.com/zhiyi7/gfw-pac) 是一个科学上网 PAC (Proxy Auto-Config) 成品文件及生成器。针对国内访问体验优化，使用 Radix Tree 数据结构对国内外 IP/域名进行毫秒级匹配：国内 IP/高频域名直接直连不经过代理，国外流量走代理，并原生支持 IPv6。

本项目在此基础上，为 Windows 用户封装了全自动的 PAC 管理工具命令 `gfw-pac`，支持通过 `file://` 协议直接将本地 PAC 规则应用到 Windows 系统网络设置中，并自动刷新 WinINET 选项即时生效。

- **官方仓库**: https://github.com/zhiyi7/gfw-pac
- **许可证**: GPL-3.0-only
- **建议依赖**: `python`（仅在使用生成器 `gfw-pac.py` 重新编译 PAC 时需要）

---

## 核心特性

1. **精准分流，性能更优**:
   - 规则按 Radix Tree 前置匹配 CNIP，国内请求完全不流经代理客户端，节省连接开销与网络带宽。
   - 原生支持 IPv6，无需关闭 IPv6 或 AAAA 解析。
2. **无需启动额外 HTTP 服务 (`file://` 协议)**:
   - 采用 Windows 原生支持的 `file://` 协议直接加载本地 `gfw.pac` 规则文件，无需占用本地端口或常驻后台 Web 服务。
3. **即时生效无需重启**:
   - 配置时自动调用 Windows 底层 WinINET API (`InternetSetOption`) 广播网络变更通知，Edge、Chrome 及大部分 Windows 应用即刻应用新代理，无需重启浏览器。

---

## 安装方法

通过 Scoop 安装：

```powershell
scoop install gfw-pac
```

若国内访问 GitHub 缓慢，可使用加速前缀脚本：

```powershell
.\bin\cn-proxy-url.ps1 gfw-pac
scoop install gfw-pac
```

---

## 常用命令与管理工具

安装完成后，可在终端直接使用 `gfw-pac` 命令：

### 1. 配置代理后端并生成 PAC 文件 (`config` / `generate`)

使用 `config` 命令设定代理后端并生成/更新 `gfw.pac` 规则文件：

```powershell
# 配置代理端口 (默认 SOCKS5 127.0.0.1:7890)
gfw-pac config -ProxyPort 7890

# 指定代理主机与端口 (如局域网代理服务器)
gfw-pac config -ProxyHost "192.168.110.244" -ProxyPort 7890

# 指定代理协议类型 (支持 socks5 或 http/proxy)
gfw-pac config -ProxyType http -ProxyPort 7890

# 自定义完整代理定义
gfw-pac config -Proxy "SOCKS5 127.0.0.1:10808; SOCKS 127.0.0.1:10808; DIRECT"
```

执行后会打印生成的 PAC 文件绝对路径与代理后端信息。

### 2. 开启 Windows PAC 代理 (`enable`)

`enable` 命令**仅负责开启系统配置**，不会修改或重新生成 PAC 文件：

```powershell
gfw-pac enable
```

> **注意**:
> - 开启时会自动读取并打印 PAC 文件的**绝对路径**与**规则代理信息**；
> - 若当前环境不存在 `gfw.pac` 文件，`enable` 会直接报错中断，提示先执行 `gfw-pac config` 生成文件。

### 3. 查看当前 PAC 与系统代理状态 (`status`)

```powershell
gfw-pac status
```
显示 Windows 系统的 `AutoConfigURL` 状态、当前本地 `gfw.pac` 路径、规则中配置的代理后端地址以及后端端口连通性。

### 4. 关闭 Windows PAC 代理 (`disable`)

```powershell
gfw-pac disable
```
清空 Windows 系统的 `AutoConfigURL` 配置并刷新系统网络缓存，即时恢复直连模式。

---

## 自定义域名名单与重新生成 PAC

软件目录下包含以下名单文件（已被 Scoop 持久化，版本升级不会被覆盖）：
- `direct-domains.txt`: 自定义强制直连的域名（每行一个）
- `proxy-domains.txt`: 自定义强制走代理的域名（每行一个）
- `local-tlds.txt`: 本地顶级域名（如 `.test`, `.localhost`）

如需修改名单后重新生成 `gfw.pac`，可在安装目录下运行：

```powershell
cd "$env:USERPROFILE\scoop\apps\gfw-pac\current"
python gfw-pac.py -f gfw.pac -p "SOCKS5 127.0.0.1:7890; DIRECT" --proxy-domains=proxy-domains.txt --direct-domains=direct-domains.txt --localtld-domains=local-tlds.txt --ip-file=cidrs-cn.txt
```
