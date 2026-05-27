# Xpra 使用指南

## 简介

Xpra（X Persistent Remote Applications）是一个持久化的远程显示服务器和客户端工具，用于转发应用程序和桌面屏幕。

它被誉为"屏幕的 SSH"，可以将远程应用程序的显示安全地转发到本地计算机，同时支持断开后重新连接。

当前通过 Scoop 安装的版本为 **stable（稳定版）**，采用 **GPL-2.0** 许可证。

项目定位为 **"Xpra is a persistent remote display server and client for forwarding applications and desktop screens"**。

官方网站：https://xpra.org/

Xpra 最初基于 X11 协议设计，现已扩展支持 Windows、macOS 和 Linux 多平台。

与传统的远程桌面工具不同，Xpra 可以转发单个应用程序窗口而非整个桌面，实现类似本地应用的使用体验。

会话持久化是 Xpra 的核心特性，即使客户端断开连接，服务端的程序仍然继续运行。

重新连接后可以无缝恢复之前的工作状态，非常适合移动办公和远程开发场景。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | stable（稳定版）                      |
| 许可证     | GPL-2.0                               |
| 项目主页   | https://xpra.org/                     |
| GUI 工具   | Xpra.exe                              |
| CLI 工具   | Xpra_cmd.exe                          |

### 与其他远程工具对比

与 **RDP（远程桌面协议）** 相比，Xpra 支持单应用转发、会话持久化和更好的跨平台支持。

与 **VNC** 相比，Xpra 提供更好的性能、剪贴板支持和音频转发功能。

与 **SSH X11 转发** 相比，Xpra 支持断线重连和更高效的压缩算法。

与 **NoMachine** 相比，Xpra 是完全开源的，且支持更灵活的配置。

## 主要功能

### 应用程序转发

Xpra 最独特的功能是单个应用程序窗口的远程转发。

可以在远程服务器上运行应用程序，将其窗口显示在本地桌面上。

应用程序看起来就像本地程序一样，与本地窗口无缝融合。

支持转发任何 X11 应用程序（在 Linux 服务端）或 Windows 应用程序。

### 桌面屏幕转发

除了单应用转发，Xpra 也支持整个桌面的远程显示。

支持转发完整的桌面环境，包括所有窗口和系统面板。

可以在客户端以窗口模式或全屏模式查看远程桌面。

支持多显示器配置的转发。

### 会话持久化

Xpra 的核心特性是会话的持久化能力。

即使客户端断开连接或关闭，服务端的程序仍然继续运行。

重新连接时可以恢复之前的完整工作状态。

支持在同一会话上连接多个客户端。

可以将会话附加到不同的客户端，实现无缝切换设备。

### 高效编码传输

Xpra 使用多种编码方式优化远程显示的传输效率。

支持 H.264、VP8、VP9 等视频编码用于屏幕内容传输。

支持 PNG、JPEG 等图片编码用于特定场景。

自动根据网络条件和内容类型选择最优编码方式。

支持硬件加速编码（需要 GPU 支持）。

### 音频转发

Xpra 支持在远程和本地之间转发音频。

可以在远程播放音频的同时在本地听到声音。

支持 PulseAudio 和 WASAPI 音频系统。

可以独立控制音频的发送和接收方向。

音频延迟取决于网络条件，局域网环境下通常可接受。

### 剪贴板共享

支持在本地和远程之间共享剪贴板内容。

可以配置剪贴板的同步方向（双向、仅发送、仅接收或禁用）。

支持文本和文件的剪贴板传输。

可以设置剪贴板内容的大小限制，防止传输大文件导致卡顿。

### 文件传输

Xpra 内置了文件传输功能。

可以在远程和本地之间传输文件，无需额外的文件共享配置。

支持通过菜单或命令行触发文件传输。

文件传输使用与主连接相同的加密通道，安全性有保障。

### 打印转发

支持将远程打印任务转发到本地打印机。

远程应用程序执行打印操作时，可以在本地打印机上输出。

适合需要远程办公但本地打印文件的场景。

## 常用操作

### 安装

通过 Scoop 安装 Xpra：

```powershell
scoop install xpra
```

安装完成后，会提供两个可执行文件：
- `Xpra.exe`：GUI 版客户端
- `Xpra_cmd.exe`：命令行版客户端

### 启动服务端会话

在远程 Linux 服务器上启动 Xpra 会话：

```bash
xpra start :100 --start=firefox --bind-tcp=0.0.0.0:10000
```

在 Windows 上启动服务端会话：

```powershell
Xpra_cmd start :100 --start=notepad --bind-tcp=0.0.0.0:10000
```

### 连接到远程会话

使用 TCP 连接到远程 Xpra 会话：

```powershell
Xpra_cmd attach tcp://remote-host:10000
```

使用 SSH 连接：

```powershell
Xpra_cmd attach ssh://user@remote-host/100
```

通过 GUI 连接：

```powershell
Xpra
```

然后在 GUI 界面中输入连接地址。

### 常用命令行参数

#### 服务端命令

启动会话：

```powershell
Xpra_cmd start :DISPLAY --start=APPLICATION
```

停止会话：

```powershell
Xpra_cmd stop :DISPLAY
```

查看会话状态：

```powershell
Xpra_cmd info :DISPLAY
```

列出所有运行中的会话：

```powershell
Xpra_cmd list
```

#### 客户端命令

连接到会话：

```powershell
Xpra_cmd attach CONNECTION_STRING
```

断开连接（保持服务端运行）：

```
Ctrl+C
```

或使用系统托盘图标右键菜单退出。

### 连接地址格式

Xpra 支持多种连接方式：

| 协议      | 地址格式                                |
| --------- | --------------------------------------- |
| TCP       | `tcp://host:port`                       |
| SSH       | `ssh://user@host/display`               |
| SSL/TLS   | `ssl://host:port`                       |
| Unix Socket | `/path/to/socket`                     |

### 加密连接配置

使用密码加密 TCP 连接：

服务端：

```powershell
Xpra_cmd start :100 --start=notepad --bind-tcp=0.0.0.0:10000 --tcp-auth=password --tcp-encryption=AES --tcp-encryption-keyfile=key.pem
```

客户端：

```powershell
Xpra_cmd attach tcp://remote-host:10000 --tcp-encryption=AES --tcp-encryption-keyfile=key.pem
```

### 会话管理

附加到现有会话：

```powershell
Xpra_cmd attach :100
```

共享会话（允许多客户端同时连接）：

```powershell
Xpra_cmd attach --sharing=yes tcp://host:10000
```

暂停会话（客户端断开但不终止应用）：

直接关闭客户端窗口即可暂停，程序在服务端继续运行。

恢复会话：

重新运行 attach 命令即可恢复。

### 控制命令

在已连接的会话中，可以使用以下控制命令：

```powershell
Xpra_cmd control :DISPLAY key press F5
Xpra_cmd control :DISPLAY print hello
Xpra_cmd control :DISPLAY start-app notepad.exe
```

### 性能调优

优化带宽使用：

```powershell
Xpra_cmd attach tcp://host:10000 --encoding=h264 --quality=50 --min-quality=20
```

优化延迟：

```powershell
Xpra_cmd attach tcp://host:10000 --compression=0 --bandwidth-limit=1Gbps
```

设置显示质量：

```powershell
Xpra_cmd attach tcp://host:10000 --quality=80 --min-speed=30
```

### 多显示器支持

启动时指定转发多个显示器：

```powershell
Xpra_cmd start :100 --use-display --start=xfce4-session
```

## 常见问题

### 连接超时

**问题**：尝试连接远程 Xpra 会话时提示连接超时。

**解决方法**：
- 确认远程服务器上的 Xpra 服务端正在运行
- 检查防火墙是否放行了 Xpra 使用的端口
- 验证连接地址和端口是否正确
- 尝试使用 `telnet host port` 测试端口连通性
- 检查服务端是否绑定了正确的网络接口

### 显示模糊或性能差

**问题**：远程应用程序的显示质量差或操作不流畅。

**解决方法**：
- 调整编码设置，尝试使用不同的编码方式
- 增加带宽限制设置
- 降低显示分辨率
- 使用局域网连接以获得更好体验
- 启用硬件加速编码（如果服务端有 GPU）

### 剪贴板不工作

**问题**：无法在本地和远程之间复制粘贴内容。

**解决方法**：
- 检查剪贴板功能是否被禁用
- 在连接参数中添加 `--clipboard=yes`
- 确认剪贴板大小限制设置合理
- 尝试使用纯文本格式进行复制粘贴
- 重启 Xpra 客户端并重新连接

### 音频无法播放

**问题**：远程应用程序的音频无法在本地播放。

**解决方法**：
- 确认连接参数中包含音频转发选项：`--speaker=yes`
- 检查远程服务器是否安装了 PulseAudio
- 确认本地音频设备工作正常
- 调整音频编码设置（Opus 通常效果最好）
- 检查音频缓冲区大小设置

### 应用程序启动失败

**问题**：使用 `--start` 参数指定的应用程序未能启动。

**解决方法**：
- 确认应用程序路径正确且可执行
- 检查应用程序是否需要额外的环境变量
- 查看 Xpra 日志获取错误详情
- 尝试先启动 Xpra 会话，再手动启动应用程序

### 断线后无法重新连接

**问题**：网络中断后无法重新连接到之前的会话。

**解决方法**：
- 确认服务端会话仍然在运行
- 使用 `Xpra_cmd list` 在服务端检查会话状态
- 确认服务端未设置会话超时自动关闭
- 检查连接地址是否变化

### Windows 上某些应用无法转发

**问题**：部分 Windows 应用程序的窗口无法通过 Xpra 转发。

**解决方法**：
- Xpra 在 Windows 上的窗口捕获能力有限
- 某些使用硬件加速渲染的应用可能无法正常转发
- 尝试禁用应用程序的硬件加速选项
- 考虑使用 RDP 作为 Windows 上的替代方案

## 相关资源

### 官方资源

- Xpra 官方网站：https://xpra.org/
- GitHub 仓库：https://github.com/Xpra-org/xpra
- 官方文档：https://xpra.org/trac/wiki
- 发布页面：https://xpra.org/trac/wiki/Download
- 常见问题：https://xpra.org/trac/wiki/FAQ

### 技术文档

- 命令行参考：https://xpra.org/man/
- 网络协议：https://xpra.org/trac/wiki/Network
- 编码选项：https://xpra.org/trac/wiki/Encodings
- 安全配置：https://xpra.org/trac/wiki/Encryption
- 性能调优：https://xpra.org/trac/wiki/Performance

### 社区资源

- Xpra 邮件列表：https://xpra.org/trac/wiki/MailingList
- GitHub Issues：https://github.com/Xpra-org/xpra/issues
- Scoop Main 仓库：https://github.com/ScoopInstaller/Main

### 学习资料

- Xpra 入门教程：https://xpra.org/trac/wiki/GettingStarted
- Xpra 与 VNC 对比：https://xpra.org/trac/wiki/VNC
- SSH 密钥认证配置：https://xpra.org/trac/wiki/SSH

### 相关工具推荐

- **NoMachine**：高性能远程桌面解决方案
- **RustDesk**：开源远程桌面软件
- **TigerVNC**：高性能 VNC 实现
- **Apache Guacamole**：无客户端远程桌面网关
- **SSH X11 转发**：使用 SSH 的原生 X11 转发功能
