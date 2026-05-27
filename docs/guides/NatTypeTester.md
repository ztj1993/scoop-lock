# NatTypeTester 使用指南

> 版本：v8.0.3 | 许可证：MIT | 官网：https://github.com/HMBSbige/NatTypeTester

---

## 简介

NatTypeTester 是一款用于检测当前网络 NAT 类型的工具，基于 STUN（Session Traversal Utilities for NAT）协议实现。NAT 类型直接影响 P2P 通信、在线游戏、VoIP 通话和远程连接的质量，了解自己的 NAT 类型对于网络调试和优化至关重要。

NAT（Network Address Translation，网络地址转换）是一种将私有 IP 地址转换为公共 IP 地址的技术，广泛应用于家庭和企业网络中。不同的 NAT 类型对网络穿透能力有不同的影响。

### 核心特性

- **快速检测**：几秒内完成 NAT 类型测试
- **STUN 协议**：基于标准 STUN 协议进行检测
- **多种 NAT 类型**：支持检测多种 NAT 类型
- **图形界面**：直观易用的 GUI 界面
- **开源免费**：MIT 许可证，完全开源
- **轻量级**：无需安装，解压即用
- **多服务器支持**：可配置多个 STUN 服务器

### NAT 类型说明

#### NAT 类型分类

| NAT 类型 | 名称 | 描述 |
|---------|------|------|
| Full Cone | 完全锥形 NAT | 最宽松，任何外部主机都可以发送数据到映射的外部地址 |
| Address Restricted Cone | 地址限制锥形 NAT | 只有曾经发送过数据的目标地址才能发送数据回来 |
| Port Restricted Cone | 端口限制锥形 NAT | 只有曾经发送过数据的目标地址和端口才能发送数据回来 |
| Symmetric | 对称 NAT | 最严格，每个不同的目标地址/端口使用不同的映射 |

#### NAT 类型对网络应用的影响

- **Full Cone**：P2P 连接最容易，几乎所有应用都能正常工作
- **Restricted Cone**：大部分 P2P 应用可以正常工作
- **Port Restricted**：需要打洞技术，部分应用可能受限
- **Symmetric**：P2P 连接最困难，可能需要中继服务器

### 适用场景

- 在线游戏联机优化
- P2P 文件传输调试
- VoIP 通话质量诊断
- 远程桌面连接排查
- VPN 网络调试
- 物联网设备通信

---

## 主要功能

### 1. NAT 类型检测

基于 STUN 协议检测当前网络的 NAT 类型：

- Full Cone NAT（完全锥形）
- Address Restricted Cone NAT（地址限制锥形）
- Port Restricted Cone NAT（端口限制锥形）
- Symmetric NAT（对称 NAT）
- 网络可能完全阻断 UDP

### 2. 公网 IP 检测

显示经过 NAT 转换后的公网 IP 地址和端口信息：

- 外部 IP 地址
- 外部端口号
- 本地 IP 地址
- 本地端口号

### 3. STUN 服务器配置

支持自定义 STUN 服务器：

- 内置多个公共 STUN 服务器
- 支持添加自定义 STUN 服务器
- 支持 STUN/TURN 服务器切换

### 4. 测试历史

记录和查看历史测试结果，便于对比分析。

---

## 常用操作

### 启动应用

```powershell
# 直接运行 NatTypeTester
NatTypeTester

# 或从 Scoop 安装目录运行
& "$env:USERPROFILE\scoop\apps\nattyetester\current\NatTypeTester.exe"
```

### 基本使用步骤

1. **启动程序**：双击 NatTypeTester.exe 打开主界面

2. **选择 STUN 服务器**：
   - 默认使用内置的 STUN 服务器
   - 可以下拉选择其他公共 STUN 服务器
   - 也可以手动输入自定义 STUN 服务器地址

3. **开始测试**：
   - 点击「测试」或「Start」按钮
   - 等待几秒钟完成检测

4. **查看结果**：
   - NAT 类型（Type）
   - 公网 IP 地址
   - 公网端口
   - 本地 IP 地址

### STUN 服务器地址

常用的公共 STUN 服务器：

| 服务器地址 | 端口 | 说明 |
|-----------|------|------|
| stun.qq.com | 3478 | 腾讯 STUN 服务器 |
| stun.miwifi.com | 3478 | 小米 STUN 服务器 |
| stun.bige0.com | 3478 | 作者提供的 STUN 服务器 |
| stun.syncthing.net | 3478 | Syncthing STUN 服务器 |
| stun.cloudflare.com | 3478 | Cloudflare STUN 服务器 |
| stun.stunprotocol.org | 3478 | 公共 STUN 服务器 |
| stun.l.google.com | 19302 | Google STUN 服务器 |
| stun1.l.google.com | 19302 | Google STUN 服务器 |
| stun2.l.google.com | 19302 | Google STUN 服务器 |
| stun3.l.google.com | 19302 | Google STUN 服务器 |
| stun4.l.google.com | 19302 | Google STUN 服务器 |

### 添加自定义 STUN 服务器

在程序界面中找到服务器配置选项，输入 STUN 服务器地址和端口：

```
格式：stun:hostname:port
示例：stun:stun.example.com:3478
```

---

## 常见问题

### Q1: 测试结果显示"无法连接"怎么办？

**可能原因及解决方案：**

1. **防火墙阻止**：
   - 检查 Windows 防火墙是否阻止了 NatTypeTester 的 UDP 出站连接
   - 临时关闭防火墙测试
   - 或将 NatTypeTester 添加到防火墙白名单

2. **网络限制**：
   - 某些企业网络或公共 WiFi 会阻止 UDP 流量
   - 尝试切换到其他网络（如手机热点）

3. **STUN 服务器不可用**：
   - 切换到其他 STUN 服务器
   - 尝试使用国内的 STUN 服务器（如 stun.qq.com）

4. **代理或 VPN 干扰**：
   - 临时关闭代理或 VPN 后重试

### Q2: 什么是 NAT 类型？为什么它很重要？

NAT 类型决定了外部网络设备能否主动与你的设备建立连接：

- **游戏**：NAT 类型严格（如 Symmetric）会导致无法与某些玩家联机
- **P2P 下载**：影响 BitTorrent 等 P2P 应用的连接能力
- **VoIP**：影响语音/视频通话的质量和连接成功率
- **远程访问**：影响远程桌面等应用的连通性

### Q3: 如何改善 NAT 类型？

1. **路由器设置**：
   - 启用 UPnP（通用即插即用）
   - 配置端口转发
   - 设置 DMZ 主机（不推荐用于生产环境）

2. **联系网络运营商**：
   - 请求分配公网 IP（而不是 CGNAT）
   - 了解运营商的 NAT 策略

3. **使用 VPN**：
   - 某些 VPN 服务可以改善 NAT 类型
   - 选择支持 Full Cone NAT 的 VPN 服务

4. **更换网络设备**：
   - 某些路由器的 NAT 实现更友好
   - 更新路由器固件

### Q4: Symmetric NAT 和 Cone NAT 的区别是什么？

| 特征 | Cone NAT | Symmetric NAT |
|------|----------|---------------|
| 映射规则 | 同一内部地址映射到同一外部地址 | 不同目标使用不同映射 |
| P2P 穿透 | 相对容易 | 较为困难 |
| 兼容性 | 大部分 P2P 应用正常 | 可能需要 TURN 中继 |
| 常见于 | 家庭路由器 | 运营商级 NAT (CGNAT) |

### Q5: 测试结果不准确怎么办？

- 尝试使用多个不同的 STUN 服务器进行测试
- 确保没有代理、VPN 或其他网络中间设备干扰
- 在不同时间段测试，某些网络配置可能随时间变化
- 确认防火墙未阻止 UDP 流量

### Q6: 为什么有些游戏显示 NAT 严格但 NatTypeTester 显示 Open？

不同的应用和游戏可能使用不同的 STUN 服务器和测试方法，结果可能有所不同。此外，某些游戏还会检测其他网络参数，如端口映射和防火墙规则。

### Q7: 支持哪些操作系统？

NatTypeTester 主要支持 Windows 操作系统。它是一个基于 .NET 开发的桌面应用程序，需要 .NET Framework 或 .NET 运行时支持。

---

## 相关资源

### 官方资源

- NatTypeTester GitHub：https://github.com/HMBSbige/NatTypeTester
- 项目 Releases：https://github.com/HMBSbige/NatTypeTester/releases
- Issues 反馈：https://github.com/HMBSbige/NatTypeTester/issues

### STUN/TURN 相关

- RFC 5389 - STUN 协议规范：https://tools.ietf.org/html/rfc5389
- RFC 5766 - TURN 协议规范：https://tools.ietf.org/html/rfc5766
- RFC 8445 - ICE 协议规范：https://tools.ietf.org/html/rfc8445

### NAT 穿透工具

- FRP（内网穿透工具）：https://github.com/fatedier/frp
- ngrok：https://ngrok.com/
- ZeroTier：https://www.zerotier.com/
- Tailscale：https://tailscale.com/

### 网络调试工具

- Wireshark（网络抓包）：https://www.wireshark.org/
- Nmap（端口扫描）：https://nmap.org/
- iperf3（网络带宽测试）：https://github.com/esnet/iperf
- Traceroute（路由追踪）：系统内置工具

### 学习资源

- NAT 类型详解：https://www.juniper.net/documentation/en_US/junos/topics/concept/nat-types.html
- STUN/TURN/ICE 入门：https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API/Protocols
- P2P 网络穿透原理：https://tailscale.com/blog/how-nat-traversal-works/
