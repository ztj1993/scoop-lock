# 7-Zip 使用指南

## 简介

7-Zip 是一款开源的文件压缩工具，支持多种压缩格式，具有高压缩比率。

**版本**: 26.00  
**官网**: https://www.7-zip.org/  
**许可证**: LGPL-2.1-or-later

## 主要功能

- 支持多种压缩格式：7z, XZ, BZIP2, GZIP, TAR, ZIP, WIM, ARJ, CAB, CHM, CPIO, CramFS, DEB, DMG, FAT, HFS, ISO, LZH, LZMA, MBR, MSI, NSIS, NTFS, RAR, RPM, SquashFS, UDF, VHD, WIM, XAR, Z
- 高压缩比率（使用 LZMA 和 LZMA2 算法）
- 支持 AES-256 加密
- 支持创建自解压文件
- 与 Windows Shell 集成

## 常用命令

### 基本压缩和解压

```bash
# 压缩文件
7z a archive.7z file1.txt file2.txt

# 压缩整个目录
7z a archive.7z folder/

# 解压文件
7z x archive.7z

# 解压到指定目录
7z x archive.7z -o./output

# 查看压缩包内容
7z l archive.7z
```

### 压缩格式指定

```bash
# 使用 ZIP 格式压缩
7z a -tzip archive.zip file1.txt

# 使用 7z 格式压缩（默认）
7z a -t7z archive.7z file1.txt

# 使用 TAR 格式打包
7z a -ttar archive.tar file1.txt

# 使用 GZIP 压缩
7z a -tgzip archive.gz file1.txt
```

### 压缩级别设置

```bash
# 设置压缩级别（0-9，0=存储，9=最大压缩）
7z a -mx=9 archive.7z file1.txt

# 快速压缩
7z a -mx=1 archive.7z file1.txt

# 存储模式（不压缩）
7z a -mx=0 archive.7z file1.txt
```

### 加密和密码保护

```bash
# 使用密码加密
7z a -p"mypassword" archive.7z file1.txt

# 使用 AES-256 加密
7z a -p"mypassword" -mhe=on archive.7z file1.txt
```

### 分卷压缩

```bash
# 分卷压缩（每卷 100MB）
7z a -v100m archive.7z largefile.iso

# 分卷压缩（每卷 1GB）
7z a -v1g archive.7z largefile.iso
```

## 图形界面使用

### 启动图形界面

```bash
# 启动 7-Zip 文件管理器
7zFM.exe
```

### 图形界面操作

1. **打开文件**: 文件 → 打开 → 选择压缩文件
2. **压缩文件**: 选中文件 → 添加 → 设置参数 → 确定
3. **解压文件**: 选中压缩包 → 提取 → 选择目标路径 → 确定
4. **测试压缩包**: 选中压缩包 → 测试

## 高级用法

### 批量处理

```bash
# 批量压缩当前目录下所有 .txt 文件
7z a archive.7z *.txt

# 批量解压多个压缩包
7z x *.7z
```

### 排除文件

```bash
# 排除特定文件
7z a archive.7z folder/ -x!*.tmp

# 排除特定目录
7z a archive.7z folder/ -x!folder/temp/*
```

### 保留目录结构

```bash
# 保留完整目录结构
7z a archive.7z folder/

# 不保留根目录
7z a archive.7z folder/*
```

## 集成到右键菜单

安装后可以通过注册表添加右键菜单选项：

```bash
# 添加右键菜单
reg import "$dir\install-context.reg"

# 移除右键菜单
reg import "$dir\uninstall-context.reg"
```

## 常见问题

### 1. 如何查看支持的格式？

```bash
7z i
```

### 2. 如何测试压缩包完整性？

```bash
7z t archive.7z
```

### 3. 如何修复损坏的压缩包？

```bash
7z x archive.7z -y
```

### 4. 如何设置默认压缩格式？

在图形界面中：工具 → 选项 → 7-Zip → 默认压缩格式

## 性能优化

### 多线程压缩

```bash
# 使用多线程压缩（默认使用所有CPU核心）
7z a archive.7z file1.txt

# 指定线程数
7z a -mmt=4 archive.7z file1.txt
```

### 内存设置

```bash
# 设置字典大小（影响压缩率和内存使用）
7z a -md=64m archive.7z file1.txt
```

## 脚本示例

### 自动备份脚本

```bash
@echo off
set BACKUP_DIR=C:\Backups
set SOURCE_DIR=C:\ImportantFiles
set DATE=%date:~0,4%%date:~5,2%%date:~8,2%

7z a -t7z "%BACKUP_DIR%\backup_%DATE%.7z" "%SOURCE_DIR%\*" -mx=9
```

### 批量解压脚本

```bash
@echo off
for %%f in (*.7z) do (
    7z x "%%f" -o"%%~nf"
)
```

## 相关资源

- [7-Zip 官方网站](https://www.7-zip.org/)
- [7-Zip 文档](https://7zip.bugacz.com/7zip/7zip.htm)
- [7-Zip 命令行版本](https://www.7-zip.org/manual/)