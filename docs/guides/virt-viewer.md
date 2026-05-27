# Virt Viewer 使用指南

## 简介

Virt Viewer 是一个用于查看虚拟机控制台的图形化工具，是 libvirt 虚拟化生态系统的重要组成部分。

它提供了轻量级的远程显示客户端，可以连接到由 KVM、QEMU、Xen 等虚拟化平台管理的虚拟机。

当前通过 Scoop 安装的版本为 **v11.0-1.0**，采用 **GPL-3.0** 许可证。

项目定位为 **"The virtual machine console viewer"**。

官方网站：https://virt-manager.org

Virt Viewer 基于 SPICE 和 VNC 协议实现远程虚拟机控制台的显示。

它与 virt-manager（虚拟机管理器）紧密集成，但也可以独立使用。

该工具适用于系统管理员和开发人员，需要远程访问和管理虚拟机的场景。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v11.0-1.0                             |
| 许可证     | GPL-3.0                               |
| 项目主页   | https://virt-manager.org              |
| GUI 工具   | virt-viewer.exe, remote-viewer.exe    |

### 包含的可执行文件

- **virt-viewer.exe**：主程序，用于连接 libvirt 管理的虚拟机
- **remote-viewer.exe**：通用远程查看器，支持直接连接 SPICE/VNC 地址

### 与 libvirt 的关系

Virt Viewer 是 libvirt 虚拟化管理工具套件的一部分。

libvirt 提供了统一的 API 来管理不同虚拟化平台（KVM、QEMU、Xen、LXC 等）。

Virt Viewer 负责虚拟机控制台的远程显示部分，而 virt-manager 提供完整的虚拟机管理功能。

在 Windows 上使用时，通常需要连接到远程 Linux 主机上运行的虚拟化服务。

## 主要功能

### SPICE 协议支持

Virt Viewer 对 SPICE 协议提供了出色的支持，这是其核心功能之一。

SPICE（Simple Protocol for Independent Computing Environments）是一个为虚拟化环境设计的远程显示协议。

支持 SPICE 的高级功能，包括双向音频传输、USB 设备重定向、剪贴板共享等。

支持 TLS 加密连接，确保远程控制台通信的安全性。

支持 SPICE 代理连接，适应不同的网络拓扑环境。

### VNC 协议支持

除了 SPICE，Virt Viewer 也支持传统的 VNC（Virtual Network Computing）协议。

支持多种 VNC 编码方式，可根据网络条件选择最优方案。

兼容大多数 VNC 服务器实现。

VNC 协议适用于不需要 SPICE 高级功能的简单场景。

### 虚拟机控制台显示

提供全屏和窗口两种显示模式，可根据需要切换。

支持自动缩放，根据窗口大小调整虚拟机显示分辨率。

支持多显示器配置，在多显示器环境中虚拟机也可以使用多个显示器。

提供发送特殊按键（Ctrl+Alt+Delete 等）到虚拟机的功能。

### USB 设备重定向

通过 SPICE 协议，可以将本地 USB 设备重定向到远程虚拟机中使用。

支持在虚拟机运行时动态添加和移除 USB 设备。

适用于需要在虚拟机中使用加密狗、USB 存储设备等场景。

### 剪贴板共享

支持在本地计算机和远程虚拟机之间共享剪贴板内容。

可以实现文本内容的双向复制粘贴。

通过 SPICE 协议的 agent 功能实现，需要虚拟机中安装 SPICE Guest Agent。

### 远程查看器模式

`remote-viewer.exe` 提供了不依赖 libvirt 的直接连接能力。

可以直接通过 SPICE 或 VNC 地址连接到虚拟机，无需 libvirt 管理层。

适用于连接非 libvirt 管理的虚拟化环境。

支持从 `.vv` 连接文件快速建立连接。

## 常用操作

### 安装

通过 Scoop 安装 Virt Viewer：

```powershell
scoop install virt-viewer
```

安装完成后，`virt-viewer.exe` 和 `remote-viewer.exe` 会被添加到系统 PATH 中。

### 连接到 libvirt 管理的虚拟机

连接到本地 libvirt 管理的虚拟机：

```powershell
virt-viewer vm-name
```

通过 libvirt URI 连接到远程主机的虚拟机：

```powershell
virt-viewer --connect qemu+ssh://user@remote-host/system vm-name
```

使用 QEMU/KVM 连接：

```powershell
virt-viewer --connect qemu:///system vm-name
```

### 命令行参数详解

```powershell
virt-viewer [选项] [域名] [id]
```

常用选项：

- `--connect URI`：指定 libvirt 连接 URI
- `--full-screen`：以全屏模式启动
- `--zoom-percentage PERCENT`：设置缩放百分比
- `--wait`：等待虚拟机启动后再连接
- `--reconnect`：在连接断开时自动重新连接
- `--auto-resize`：自动调整窗口大小以匹配虚拟机分辨率

### 使用 remote-viewer 连接

直接通过 SPICE 地址连接：

```powershell
remote-viewer spice://remote-host:5900
```

直接通过 VNC 地址连接：

```powershell
remote-viewer vnc://remote-host:5900
```

从连接文件连接：

```powershell
remote-viewer connection.vv
```

### 全屏模式操作

进入全屏模式后，可以使用以下快捷键：

- `Ctrl+Alt+F`：退出全屏模式
- `Ctrl+Alt+Enter`：切换全屏/窗口模式
- `Ctrl+Alt+方向键`：在多显示器间切换焦点

### 发送特殊按键

在控制台窗口中，通过菜单栏可以发送特殊按键组合：

- `Ctrl+Alt+Delete`：发送到虚拟机（不会影响宿主机）
- `Ctrl+Alt+Backspace`：发送到虚拟机

也可以通过菜单"Send Key"选项选择更多按键组合。

### 自动连接配置

如果需要频繁连接某个虚拟机，可以使用以下命令创建快捷方式：

```powershell
virt-viewer --connect qemu+ssh://user@host/system --reconnect --auto-resize vm-name
```

### 使用 .vv 连接文件

`.vv` 文件是 SPICE 连接配置文件，内容示例：

```ini
[virt-viewer]
type=spice
host=remote-host
port=5900
tls-port=5901
password=your-password
fullscreen=0
```

双击 `.vv` 文件或使用 `remote-viewer` 命令打开即可快速连接。

## 常见问题

### 无法连接到虚拟机

**问题**：运行 virt-viewer 后提示无法连接或超时。

**解决方法**：
- 确认 libvirt 服务在远程主机上正常运行
- 检查 libvirt 连接 URI 是否正确
- 确认 SSH 密钥已配置且可免密登录
- 验证虚拟机确实正在运行
- 检查防火墙是否放行了相关端口

### 显示模糊或分辨率不正确

**问题**：虚拟机控制台画面模糊或分辨率异常。

**解决方法**：
- 使用 `--zoom-percentage` 调整缩放比例
- 在虚拟机内安装 SPICE Guest Agent 以支持自动分辨率调整
- 使用 `--auto-resize` 选项让窗口自动适应虚拟机分辨率
- 检查虚拟机的显示驱动是否正确安装

### USB 设备重定向失败

**问题**：无法将本地 USB 设备重定向到虚拟机。

**解决方法**：
- 确认使用的是 SPICE 协议（VNC 不支持 USB 重定向）
- 在虚拟机中安装并运行 SPICE Guest Agent
- 确认 Virt Viewer 有足够的权限访问 USB 设备
- 检查 SPICE 服务器端的 USB 重定向配置

### 剪贴板共享不工作

**问题**：无法在本地和虚拟机之间复制粘贴内容。

**解决方法**：
- 确认虚拟机中安装了 SPICE Guest Agent
- 检查 SPICE 连接是否支持剪贴板功能
- 在 SPICE 客户端设置中确认剪贴板功能已启用
- 尝试重启 SPICE Guest Agent 服务

### SPICE 连接断开后无法恢复

**问题**：网络中断后连接无法自动恢复。

**解决方法**：
- 使用 `--reconnect` 参数启动 virt-viewer
- 检查虚拟机是否仍然在运行
- 增加连接超时设置
- 手动重新建立连接

### 远程连接性能差

**问题**：远程控制台操作响应缓慢。

**解决方法**：
- 检查网络带宽和延迟
- 降低虚拟机的显示分辨率
- 减少同时重定向的 USB 设备数量
- 考虑使用 SPICE 代理优化连接
- 在局域网环境下优先使用 SPICE 而非 VNC

### TLS 证书验证失败

**问题**：使用 TLS 加密连接时提示证书错误。

**解决方法**：
- 确认 TLS 证书路径配置正确
- 检查证书是否过期
- 确认客户端和服务器使用兼容的 TLS 版本
- 将 SPICE 服务器的 CA 证书添加到受信任列表

## 相关资源

### 官方资源

- 官方网站：https://virt-manager.org/
- GitHub 仓库：https://gitlab.com/virt-viewer/virt-viewer
- 发布页面：https://virt-manager.org/download.html
- SPICE 项目：https://www.spice-space.org/

### libvirt 生态系统

- libvirt 官方文档：https://libvirt.org/docs.html
- libvirt URI 格式：https://libvirt.org/uri.html
- virt-manager 项目：https://virt-manager.org/
- virsh 命令参考：https://libvirt.org/manpages/virsh.html

### SPICE 相关

- SPICE 协议文档：https://www.spice-space.org/documentation.html
- SPICE Guest Agent：https://www.spice-space.org/download.html
- SPICE 项目主页：https://www.spice-space.org/

### 社区资源

- Libvirt 用户邮件列表：https://libvirt.org/contact.html
- SPICE 社区：https://www.spice-space.org/community.html
- Scoop Extras 仓库：https://github.com/ScoopInstaller/Extras

### 相关工具推荐

- **virt-manager**：完整的虚拟机管理图形界面
- **virsh**：libvirt 命令行管理工具
- **Cockpit**：基于 Web 的服务器管理工具，支持虚拟机管理
- **Proxmox VE**：基于 Debian 的开源虚拟化平台
