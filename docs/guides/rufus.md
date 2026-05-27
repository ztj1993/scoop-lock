# Rufus 使用指南

## 简介

Rufus 是一款免费开源的 USB 启动盘制作工具，可以帮助用户快速创建可启动的 USB 闪存驱动器。它支持从 ISO 镜像文件创建 Windows、Linux 等操作系统的安装介质。

**版本**: v4.14  
**官网**: https://rufus.ie/  
**许可证**: GPL-3.0  
**可执行文件**: rufus.exe

## 主要功能

- 从 ISO 镜像创建可启动 USB 驱动器
- 支持 Windows、Linux、UEFI 等多种操作系统
- 支持 MBR 和 GPT 分区方案
- 支持 UEFI 和 Legacy BIOS 引导模式
- 快速格式化 USB 驱动器
- 支持 FAT32、NTFS、exFAT 等文件系统
- 计算 ISO 文件的 MD5/SHA1/SHA256 校验和
- 支持 Windows To Go 安装
- 支持下载官方 Windows ISO 镜像

## 常用操作

### 启动 Rufus

直接运行 rufus.exe 即可启动程序，无需安装。

```bash
# 直接运行
rufus.exe
```

### 创建 Windows 启动盘

1. **选择设备**: 在"设备"下拉菜单中选择目标 USB 驱动器
2. **选择引导类型**: 点击"选择"按钮，浏览并选择 Windows ISO 文件
3. **分区方案**: 
   - MBR: 用于传统 BIOS 或 UEFI-CSM 引导
   - GPT: 用于纯 UEFI 引导
4. **目标系统**: 
   - BIOS 或 UEFI: 兼容性最好
   - UEFI (非 CSM): 仅支持 UEFI 引导
5. **文件系统**: 
   - FAT32: 兼容性最好，但单个文件不能超过 4GB
   - NTFS: 支持大文件
6. **点击开始**: 等待制作完成

### 创建 Linux 启动盘

1. **选择 ISO 文件**: 选择 Linux 发行版的 ISO 镜像
2. **写入模式**: 
   - ISO 镜像模式 (推荐): 创建标准的可启动 USB
   - DD 镜像模式: 直接写入，某些情况下兼容性更好
3. **点击开始**: 等待写入完成

### 创建 UEFI 启动盘

1. **选择 GPT 分区方案**
2. **选择 UEFI (非 CSM) 目标系统**
3. **选择 FAT32 文件系统** (UEFI 标准要求)
4. **点击开始**

### 快速格式化 USB

1. **选择设备**: 选择要格式化的 USB 驱动器
2. **选择引导类型**: 选择"非引导"
3. **选择文件系统**: FAT32、NTFS 或 exFAT
4. **点击开始**: 确认格式化操作

## 高级选项

### 显示高级选项

点击界面底部的"显示高级选项"复选框，可以访问更多设置：

- **快速格式化**: 快速擦除 USB 驱动器
- **创建扩展标签和图标文件**: 为 USB 驱动器添加标签
- **检查设备坏块**: 扫描 USB 驱动器的坏块
- **使用 Rufus MBR**: 安装自定义主引导记录

### 下载 Windows ISO

Rufus 内置了下载官方 Windows ISO 的功能：

1. 点击"选择"按钮旁边的下拉箭头
2. 选择"下载"
3. 选择 Windows 版本、发行版、语言和架构
4. 点击"下载"按钮

### 使用命令行参数

Rufus 支持命令行参数进行自动化操作：

```bash
# 列出可用的 USB 设备
rufus.exe -l

# 使用指定 ISO 创建启动盘
rufus.exe -i path\to\windows.iso

# 使用 DD 模式写入
rufus.exe --dd -i path\to\linux.iso
```

## 引导模式详解

### MBR (主引导记录)

- 兼容性最好，支持所有操作系统
- 支持 Legacy BIOS 引导
- 最大支持 2TB 磁盘
- 最多 4 个主分区

### GPT (GUID 分区表)

- 现代分区方案，支持 UEFI 引导
- 支持超过 2TB 的磁盘
- 支持更多分区
- Windows 7 及以上版本支持

### UEFI 引导

- 现代计算机的标准引导方式
- 支持安全启动 (Secure Boot)
- 启动速度更快
- 支持图形化启动菜单

## 文件系统选择

### FAT32

- 兼容性最好，所有操作系统都支持
- 最大支持 4GB 单个文件
- 适合 UEFI 启动盘
- 适合小文件存储

### NTFS

- Windows 原生文件系统
- 支持大文件 (超过 4GB)
- 支持文件压缩和加密
- 适合 Windows 安装盘

### exFAT

- 专为闪存设计
- 支持大文件
- 兼容性较好
- 适合大容量 USB 驱动器

## 常见问题

### 1. USB 设备未被识别

**可能原因**:
- USB 驱动器损坏
- USB 端口故障
- 驱动程序问题

**解决方案**:
- 尝试不同的 USB 端口
- 尝试不同的 USB 驱动器
- 更新 USB 驱动程序
- 以管理员身份运行 Rufus

### 2. 启动盘无法启动

**可能原因**:
- BIOS/UEFI 设置不正确
- ISO 文件损坏
- 分区方案选择错误

**解决方案**:
- 检查 BIOS/UEFI 启动顺序设置
- 验证 ISO 文件的完整性 (SHA256 校验和)
- 尝试不同的分区方案 (MBR/GPT)
- 确保 USB 驱动器是第一启动设备

### 3. 写入速度很慢

**可能原因**:
- USB 驱动器速度慢
- USB 2.0 端口
- ISO 文件很大

**解决方案**:
- 使用 USB 3.0 端口和驱动器
- 关闭其他程序释放系统资源
- 使用快速 USB 驱动器

### 4. 提示"设备正在使用"

**可能原因**:
- 其他程序正在访问 USB 驱动器
- 资源管理器打开了 USB 驱动器

**解决方案**:
- 关闭所有访问 USB 驱动器的程序
- 关闭资源管理器窗口
- 安全弹出后重新插入

### 5. 制作完成后 USB 容量变小

**可能原因**:
- 分区表创建错误
- 隐藏分区存在

**解决方案**:
- 使用 Rufus 重新格式化
- 使用磁盘管理工具删除所有分区后重新创建
- 使用 diskpart 工具清理磁盘

## 安全建议

### 验证 ISO 文件

在创建启动盘前，务必验证 ISO 文件的完整性：

```powershell
# 计算 SHA256 校验和
Get-FileHash -Algorithm SHA256 path\to\windows.iso
```

### 备份数据

创建启动盘会清除 USB 驱动器上的所有数据，请提前备份重要文件。

### 使用官方 ISO

尽量从官方网站下载 ISO 文件，避免使用来源不明的镜像。

## 故障排除

### 检查日志

Rufus 会显示详细的操作日志，可以用于诊断问题：

1. 查看界面底部的日志区域
2. 复制日志内容
3. 在 Rufus 官方论坛搜索类似问题

### 重置 Rufus

如果 Rufus 出现异常，可以尝试：

1. 删除 Rufus 配置文件
2. 重新下载最新版本
3. 以管理员身份运行

## 性能优化

### 选择合适的 USB 驱动器

- 使用 USB 3.0 或更高版本的驱动器
- 选择读写速度快的品牌
- 避免使用廉价的杂牌驱动器

### 优化写入设置

- 启用快速格式化
- 根据需要选择合适的文件系统
- 避免在写入过程中进行其他操作

## 相关资源

- [Rufus 官方网站](https://rufus.ie/)
- [Rufus GitHub 仓库](https://github.com/pbatard/rufus)
- [Rufus 常见问题解答](https://github.com/pbatard/rufus/wiki/FAQ)
- [Windows 10 下载](https://www.microsoft.com/software-download/windows10)
- [Windows 11 下载](https://www.microsoft.com/software-download/windows11)