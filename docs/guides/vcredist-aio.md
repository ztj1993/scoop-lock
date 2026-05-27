# Visual C++ Redistributable AIO 使用指南

## 简介

Visual C++ Redistributable AIO 是一个整合包，包含了所有最新版本的 Microsoft Visual C++ Redistributable 运行时库。

许多 Windows 应用程序和游戏依赖这些运行时库才能正常运行，本工具提供了一站式安装解决方案。

由 abbodi1406 维护，持续更新以包含最新的安全补丁和功能改进。

### 基本信息

| 项目 | 详情 |
|------|------|
| 版本 | v0.104.0 |
| 许可证 | Unlicense |
| 文件大小 | 约 70-80 MB |
| 官方主页 | https://github.com/abbodi1406/vcredist |
| 系统要求 | Windows 7 及以上版本 |

### 包含的组件

本整合包包含以下 Visual C++ 运行时库：

- Visual C++ 2005 (x86/x64)
- Visual C++ 2008 (x86/x64)
- Visual C++ 2010 (x86/x64)
- Visual C++ 2012 (x86/x64)
- Visual C++ 2013 (x86/x64)
- Visual C++ 2015-2022 (x86/x64/ARM64)

## 主要功能

### 1. 一键安装所有运行时库

无需逐个下载和安装，一个程序即可完成所有 VC++ 运行时库的安装。

节省时间和精力，避免遗漏必要的组件。

### 2. 静默安装支持

支持命令行参数进行静默安装，适合批量部署和自动化脚本。

无需用户交互，可在后台完成安装。

### 3. 自动检测已安装版本

智能检测系统中已安装的 VC++ 版本，避免重复安装。

支持增量更新，只安装缺失或需要更新的组件。

### 4. 修复和卸载功能

提供修复现有安装的功能，解决损坏或不完整的安装问题。

支持选择性卸载特定版本的运行时库。

### 5. 离线安装支持

下载后可完全离线使用，无需网络连接。

适合内网环境或网络受限的场景。

## 常用命令/操作

### 基本使用

#### 图形界面模式

直接双击运行 `vcredist-aio.exe`：

1. 以管理员身份运行程序
2. 在界面中选择要安装的组件
3. 点击"Install"按钮开始安装
4. 等待安装完成
5. 重启计算机（如需要）

#### 命令行安装

安装所有组件（静默模式）：
```
vcredist-aio.exe /ai /gm2
```

安装指定版本：
```
vcredist-aio.exe /ai17 /gm2
```

仅安装 x86 版本：
```
vcredist-aio.exe /aix86 /gm2
```

仅安装 x64 版本：
```
vcredist-aio.exe /aix64 /gm2
```

### 命令行参数详解

#### 安装模式参数

| 参数 | 说明 |
|------|------|
| /ai | 静默安装所有版本 |
| /ai2005 | 仅安装 VC++ 2005 |
| /ai2008 | 仅安装 VC++ 2008 |
| /ai2010 | 仅安装 VC++ 2010 |
| /ai2012 | 仅安装 VC++ 2012 |
| /ai2013 | 仅安装 VC++ 2013 |
| /ai2022 | 仅安装 VC++ 2015-2022 |
| /ai17 | 安装 VC++ 2017 及以上 |

#### 架构选择参数

| 参数 | 说明 |
|------|------|
| /aix86 | 仅安装 32 位版本 |
| /aix64 | 仅安装 64 位版本 |
| /aiarm | 仅安装 ARM64 版本 |

#### 安装行为参数

| 参数 | 说明 |
|------|------|
| /gm2 | 静默模式，无用户交互 |
| /gm1 | 显示基本进度 |
| /h | 显示帮助信息 |
| /s | 完全静默，不显示任何界面 |

### 卸载操作

#### 完全卸载

卸载所有已安装的 VC++ 运行时：
```
vcredist-aio.exe /u
```

#### 选择性卸载

仅卸载 VC++ 2005：
```
vcredist-aio.exe /u2005
```

仅卸载 VC++ 2015-2022：
```
vcredist-aio.exe /u2022
```

### 修复操作

修复所有已安装的运行时：
```
vcredist-aio.exe /r
```

修复指定版本：
```
vcredist-aio.exe /r2022
```

## 管理员权限说明

### 为什么需要管理员权限

Visual C++ Redistributable 安装需要管理员权限的原因：

1. 运行时库需要安装到系统目录（如 System32）
2. 需要修改系统注册表
3. 需要注册 COM 组件
4. 需要创建系统级的环境变量

### 以管理员身份运行

方法一：右键菜单
1. 右键点击 `vcredist-aio.exe`
2. 选择"以管理员身份运行"
3. 在 UAC 提示中点击"是"

方法二：命令提示符
1. 以管理员身份打开命令提示符
2. 导航到程序所在目录
3. 执行安装命令

方法三：PowerShell
1. 以管理员身份打开 PowerShell
2. 运行程序并添加参数

## 常见问题

### 1. 安装失败怎么办？

可能原因及解决方案：

- **权限不足**：确保以管理员身份运行
- **文件损坏**：重新下载安装包
- **系统不兼容**：检查操作系统版本是否满足要求
- **防病毒软件干扰**：暂时禁用防病毒软件后重试

### 2. 如何检查已安装的版本？

通过控制面板查看：
1. 打开"控制面板" → "程序和功能"
2. 在列表中查找"Microsoft Visual C++"
3. 查看已安装的各个版本

通过命令行查看：
```powershell
Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like "*Visual C++*"}
```

### 3. 安装后程序仍提示缺少 DLL

解决方案：
1. 确认安装的架构（x86/x64）与程序匹配
2. 重启计算机
3. 运行 `sfc /scannow` 修复系统文件
4. 重新安装对应的 VC++ 版本

### 4. 可以只安装某个特定版本吗？

可以。使用对应的命令行参数：
```
vcredist-aio.exe /ai2022 /gm2
```

或在图形界面中取消勾选不需要的版本。

### 5. 安装会占用多少磁盘空间？

各版本占用空间约为：
- VC++ 2005: ~6 MB
- VC++ 2008: ~10 MB
- VC++ 2010: ~15 MB
- VC++ 2012: ~15 MB
- VC++ 2013: ~20 MB
- VC++ 2015-2022: ~30 MB

总计约 100 MB 左右。

### 6. 如何在企业环境中批量部署？

使用静默安装命令结合部署工具（如 SCCM、PDQ Deploy）：
```
vcredist-aio.exe /ai /gm2
```

可以通过脚本批量执行，并记录安装日志。

### 7. 安装过程中的错误代码含义

常见错误代码：
- 0: 安装成功
- 1602: 用户取消安装
- 1603: 安装过程中发生致命错误
- 1618: 另一个安装正在进行中
- 3010: 安装成功，需要重启

### 8. 是否支持 Windows 服务器系统？

支持。Visual C++ Redistributable AIO 兼容以下服务器系统：
- Windows Server 2008 R2 及以上
- Windows Server 2012/2012 R2
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022

### 9. 更新版本后旧版本会自动卸载吗？

VC++ 2015-2022 是同一个运行时系列，新版本会覆盖旧版本。

2015 年之前的版本（2005-2013）是独立的，不会被覆盖。

建议保留所有版本以确保兼容性。

### 10. 如何解决"并行配置不正确"错误？

此错误通常是由于缺少对应的 VC++ 运行时导致：

1. 完全卸载现有的 VC++ 运行时
2. 重启计算机
3. 重新安装 Visual C++ Redistributable AIO
4. 再次重启计算机

## 相关资源

### 官方资源

- GitHub 仓库：https://github.com/abbodi1406/vcredist
- 发布页面：https://github.com/abbodi1406/vcredist/releases
- 问题反馈：https://github.com/abbodi1406/vcredist/issues

### Microsoft 官方资源

- Visual C++ 下载页面：https://learn.microsoft.com/zh-cn/cpp/windows/latest-supported-vc-redist
- 运行时库文档：https://learn.microsoft.com/zh-cn/cpp/windows/redistributing-visual-cpp-files
- 系统要求：https://learn.microsoft.com/zh-cn/cpp/windows/platform-support

### 替代工具

- Visual C++ Runtime Installer - 另一个运行时合集工具
- Microsoft Visual Studio - 完整的开发环境
- DirectX End-User Runtime - 游戏运行时库

### 学习资源

- Windows DLL Hell 问题解析
- Visual C++ 运行时库版本历史
- Windows 应用程序部署最佳实践

## 技术细节

### 运行时库的作用

Visual C++ Redistributable 运行时库提供：

- C 运行时库 (CRT)
- C++ 标准库
- MFC (Microsoft Foundation Classes)
- ATL (Active Template Library)
- OpenMP 运行时
- 并发运行时

### 版本号对照表

| 内部版本号 | 产品名称 | 文件版本 |
|-----------|---------|---------|
| VC++ 8.0 | Visual C++ 2005 | 8.0.x |
| VC++ 9.0 | Visual C++ 2008 | 9.0.x |
| VC++ 10.0 | Visual C++ 2010 | 10.0.x |
| VC++ 11.0 | Visual C++ 2012 | 11.0.x |
| VC++ 12.0 | Visual C++ 2013 | 12.0.x |
| VC++ 14.x | Visual C++ 2015-2022 | 14.x.x |

### 安装文件位置

默认安装位置：
- 64 位系统：`C:\Windows\System32\` 和 `C:\Windows\SysWOW64\`
- 32 位系统：`C:\Windows\System32\`

关键 DLL 文件：
- msvcr*.dll - C 运行时库
- msvcp*.dll - C++ 标准库
- vcruntime*.dll - VC 运行时
- vcomp*.dll - OpenMP 运行时
- vcamp*.dll - AMP 运行时

## 最佳实践

### 1. 定期更新

保持运行时库为最新版本，以获取：
- 安全补丁
- 性能改进
- Bug 修复

### 2. 系统备份

在进行大规模更新前：
1. 创建系统还原点
2. 备份重要数据
3. 记录当前已安装的版本

### 3. 问题排查

遇到运行时错误时：
1. 检查错误信息中提到的具体 DLL
2. 确认对应的 VC++ 版本是否已安装
3. 尝试修复或重新安装
4. 查看 Windows 事件日志获取更多信息

### 4. 企业部署建议

- 在测试环境中先行验证
- 使用静默安装参数
- 配合组策略或部署工具
- 建立标准化的安装流程
- 记录安装日志以备审计

## 版本更新日志

### v0.104.0 更新内容

- 更新 VC++ 2015-2022 至最新版本
- 修复 Windows 11 兼容性问题
- 改进安装日志记录
- 优化安装包大小

### 历史重要版本

- v0.100.0 - 添加 ARM64 支持
- v0.90.0 - 重新设计用户界面
- v0.80.0 - 改进静默安装功能
- v0.70.0 - 添加选择性卸载功能

## 注意事项

1. 本工具需要管理员权限才能正常工作
2. 安装前建议关闭正在运行的应用程序
3. 某些防病毒软件可能会误报，建议添加信任
4. 安装完成后可能需要重启计算机
5. 不建议卸载旧版本，除非确定不需要

## 总结

Visual C++ Redistributable AIO 是 Windows 系统维护的必备工具，它简化了 VC++ 运行时库的安装和管理过程。

通过使用此工具，用户可以确保系统具备运行各类应用程序和游戏所需的运行时环境，避免常见的 DLL 缺失错误。
