# Antigravity-Proxy 使用指南

## 简介

Antigravity-Proxy 是专门为 **Google Antigravity** 与 **Antigravity IDE** 量身定制的免 TUN 强制代理注入工具（基于 MinHook + Windows DLL 劫持）。

- **版本**: v2.4
- **许可证**: BSD-2-Clause
- **官方仓库**: https://github.com/yuaotian/antigravity-proxy
- **核心定位**: 解决中国大陆网络环境下 Antigravity 核心后端（如 `language_server_windows_x64.exe`、`node.exe`、`agy.exe` 等）无法走系统代理、只能被迫开启全局 TUN 模式的痛点。

---

## 核心特性与工作原理

### 1. 解决的痛点
- **无需 TUN 模式**: 不需要管理员权限开启 Clash/Mihomo 的全局 TUN 网卡模式。
- **精准进程代理**: 仅对 Antigravity 及其派生的子进程（语言服务器、Node 运行时、CLI 进程）透明重定向网络流量，不干扰系统其他程序。
- **完全透明**: 宿主进程无感知，底层通过 Winsock API Hook 将出站 TCP/UDP 流量桥接至本地 SOCKS5/HTTP 代理。

### 2. 工作原理
- **IDE 桌面端**: 利用 Windows 动态链接库搜索机制，将编译好的 `version.dll` 放置于 Antigravity 安装根目录（与 `Antigravity.exe` 同级），在主程序启动时优先加载并安装 API Hook。
- **CLI 命令行端**: 通过 `dbghelp.dll` 引导加载 `antigravity_proxy.dll`，无缝劫持 `agy.exe` 的网络通信。

---

## 安装方法

通过 Scoop 直接安装：

```powershell
scoop install antigravity-proxy
```

如国内访问 GitHub 不稳定，可通过加速前缀安装：

```powershell
.\bin\cn-proxy-url.ps1 antigravity-proxy
scoop install antigravity-proxy
```

---

## 常用命令与管理工具

安装后即可在终端全局使用 `antigravity-proxy` 命令行工具：

### 1. 查看当前状态

```powershell
antigravity-proxy status
```
自动扫描 Scoop 安装目录及系统全局目录下的 Antigravity，展示各目标的注入状态、当前代理配置以及本地代理端口的连通性。

### 2. 一键启用代理注入

```powershell
# 启用代理注入（自动检测 Antigravity 路径，使用现有配置）
antigravity-proxy enable

# 快捷指定代理端口并启用
antigravity-proxy enable -ProxyPort 7890

# 快捷指定代理主机地址并启用（如指向本地或局域网代理机）
antigravity-proxy enable -ProxyHost "127.0.0.1"

# 同时指定代理主机、端口与协议类型
antigravity-proxy enable -ProxyHost "192.168.110.244" -ProxyPort 7890 -ProxyType socks5

# 针对指定自定义路径启用
antigravity-proxy enable -Target "D:\Tools\Antigravity"

# 针对 Antigravity CLI (agy.exe) 启用
antigravity-proxy enable -Cli
```

> **注意**: 如果 Antigravity 正在运行中，启用注入后请完全退出并重启 Antigravity 以使代理生效。

### 3. 一键停用代理注入

```powershell
antigravity-proxy disable
```
安全移除目标目录中的劫持 DLL 文件（`version.dll` / `dbghelp.dll`），恢复默认直连状态。

### 4. 打开代理配置界面

```powershell
antigravity-proxy config
```
在默认浏览器中打开可视化的配置控制台（`config-web.html`）或直接编辑 `config.json`。

---

## 配置文件说明 (`config.json`)

默认配置文件结构如下：

```json
{
  "proxy": {
    "type": "socks5",
    "host": "127.0.0.1",
    "port": 7890
  },
  "target_processes": [
    "agy.exe",
    "language_server.exe",
    "language_server_windows",
    "Antigravity.exe",
    "Antigravity IDE.exe",
    "node.exe"
  ]
}
```

- `proxy.type`: 代理协议类型，支持 `socks5`（推荐）或 `http`。
- `proxy.host`: 本地代理监听地址，通常为 `127.0.0.1`。
- `proxy.port`: 本地代理端口（如 Clash 的 `7890` / `7891`，v2rayN 的 `10808`）。
- `target_processes`: 目标劫持注入的进程清单。

---

## 故障排查

### 1. 启动报错 0xc0000142
- **原因**: 系统缺少 Microsoft Visual C++ 运行库。
- **解决**: 执行 `scoop install vcredist-aio` 安装完整的微软常用运行库合集。

### 2. 对话报错 `Agent execution terminated due to error`
- **排查建议**:
  1. 检查 `<Antigravity安装目录>\logs\proxy-YYYYMMDD.log`，若看到 `SOCKS5: 隧道建立成功` 说明 DLL 注入正常工作。
  2. 检查 `%APPDATA%\Antigravity\logs\<最新目录>\ls-main.log`，若提示 `FAILED_PRECONDITION (code 400): User location is not supported for the API use.`，说明当前代理节点的出口 IP 不受支持，请更换原生/住宅代理节点或非机房节点。
