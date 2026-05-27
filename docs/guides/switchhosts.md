# SwitchHosts 使用指南

## 简介

SwitchHosts 是一款开源的 hosts 文件管理工具，允许用户轻松管理和切换不同的 hosts 文件配置。它提供了直观的图形界面，支持多套 hosts 配置方案的快速切换。

**版本**: v5.0.0  
**官网**: https://switchhosts.app  
**许可证**: MIT  
**主要功能**: Hosts 管理与切换

## 主要功能

- 图形化管理 hosts 文件
- 支持多套 hosts 配置方案
- 一键切换 hosts 配置
- 支持 hosts 配置的导入导出
- 支持远程 hosts 文件（通过 URL）
- 支持系统 hosts 文件的备份和恢复
- 支持 hosts 配置的语法高亮
- 支持正则表达式匹配
- 支持注释和分组管理
- 跨平台支持（Windows、macOS、Linux）

## 常用操作

### 启动 SwitchHosts

直接运行 SwitchHosts.exe 即可启动程序。

```bash
# 直接运行
SwitchHosts.exe
```

### 创建新的 hosts 方案

1. **点击左上角的"+"按钮**
2. **选择方案类型**:
   - 本地方案: 本地存储的 hosts 配置
   - 远程方案: 从 URL 获取的 hosts 配置
3. **输入方案名称**
4. **点击"确定"**

### 编辑 hosts 配置

1. **在左侧列表中选择方案**
2. **在右侧编辑区域输入 hosts 内容**
3. **使用标准 hosts 格式**:
   ```
   # 注释行
   127.0.0.1 localhost
   192.168.1.100 myserver.local
   ```
4. **点击"保存"或按 Ctrl+S**

### 激活 hosts 方案

1. **在左侧列表中选择要激活的方案**
2. **点击方案名称旁边的开关按钮**
3. **方案被激活后会显示为高亮状态**

### 添加远程 hosts

1. **点击"+"按钮**
2. **选择"远程方案"**
3. **输入远程 hosts 文件的 URL**
4. **设置刷新间隔**（可选）
5. **点击"确定"**

### 导入 hosts 配置

1. **点击"文件"菜单**
2. **选择"导入"**
3. **选择要导入的 hosts 文件**
4. **配置将被添加到方案列表**

### 导出 hosts 配置

1. **在左侧列表中选择要导出的方案**
2. **点击"文件"菜单**
3. **选择"导出"**
4. **选择保存位置和文件名**

## hosts 文件格式

### 基本格式

```
# 这是注释
IP地址 主机名 [主机名2 主机名3 ...]

# 示例
127.0.0.1 localhost
192.168.1.100 myserver.local api.myserver.local
```

### 常见用法

```
# 屏蔽广告网站
0.0.0.0 ad.doubleclick.net
0.0.0.0 ads.google.com

# 本地开发环境
127.0.0.1 myapp.local
127.0.0.1 api.myapp.local

# 内网服务器
192.168.1.100 fileserver
192.168.1.101 printserver

# 重定向域名
123.45.67.89 old-domain.com
```

### 注释和分组

```
# ====================
# 开发环境配置
# ====================
127.0.0.1 dev.myapp.local
127.0.0.1 api.dev.myapp.local

# ====================
# 测试环境配置
# ====================
# 192.168.1.200 test.myapp.local
# 192.168.1.200 api.test.myapp.local
```

## 高级功能

### 方案组合

SwitchHosts 支持同时激活多个方案，配置会按顺序合并：

1. **激活第一个方案**
2. **激活第二个方案**
3. **后面的方案会覆盖前面的同名配置**

### 正则表达式支持

支持使用正则表达式进行批量操作：

```regex
# 匹配所有 .local 域名
.*\.local$

# 匹配特定 IP 段
192\.168\.1\.\d+
```

### 定时刷新

对于远程 hosts 方案，可以设置自动刷新：

1. **编辑远程方案**
2. **设置刷新间隔**（如 30 分钟）
3. **方案会自动更新**

### 快捷键

- `Ctrl+N`: 新建方案
- `Ctrl+S`: 保存当前方案
- `Ctrl+E`: 编辑方案
- `Ctrl+D`: 删除方案
- `Ctrl+F`: 搜索
- `Ctrl+Z`: 撤销
- `Ctrl+Y`: 重做

## 使用场景

### 场景 1：Web 开发

为不同项目创建不同的 hosts 配置：

```
# 项目 A
127.0.0.1 project-a.local
127.0.0.1 api.project-a.local

# 项目 B
127.0.0.1 project-b.local
127.0.0.1 api.project-b.local
```

### 场景 2：测试环境切换

在开发、测试、生产环境之间快速切换：

```
# 开发环境
127.0.0.1 myapp.local

# 测试环境
192.168.1.200 myapp.test.com

# 生产环境
# 直接使用域名解析
```

### 场景 3：广告屏蔽

使用第三方广告屏蔽 hosts 列表：

```
# 来源: https://someonewhocares.org/hosts/
0.0.0.0 ad.doubleclick.net
0.0.0.0 ads.facebook.com
0.0.0.0 analytics.google.com
```

### 场景 4：内网服务管理

管理内网服务器的域名映射：

```
# 内网服务器
192.168.1.10 fileserver
192.168.1.11 printserver
192.168.1.12 mediaserver
192.168.1.13 gitserver
```

### 场景 5：网站屏蔽

临时屏蔽某些网站：

```
# 屏蔽社交媒体（工作时间）
0.0.0.0 facebook.com
0.0.0.0 twitter.com
0.0.0.0 instagram.com
```

## 配置管理

### 备份配置

1. **点击"文件"菜单**
2. **选择"备份"**
3. **选择备份保存位置**

### 恢复配置

1. **点击"文件"菜单**
2. **选择"恢复"**
3. **选择备份文件**

### 导出所有方案

```bash
# 配置文件位置
Windows: %APPDATA%\SwitchHosts\
macOS: ~/Library/Application Support/SwitchHosts/
Linux: ~/.config/SwitchHosts/
```

## 系统集成

### 开机自启动

1. **打开设置**
2. **勾选"开机时自动启动"**

### 系统托盘

1. **最小化时隐藏到系统托盘**
2. **双击托盘图标显示主窗口**
3. **右键托盘图标显示菜单**

### 管理员权限

SwitchHosts 需要管理员权限来修改系统 hosts 文件：

1. **右键点击 SwitchHosts.exe**
2. **选择"以管理员身份运行"**
3. **或在属性中设置始终以管理员身份运行**

## 常见问题

### 1. 无法修改 hosts 文件

**可能原因**:
- 没有管理员权限
- 文件被其他程序占用
- 文件权限设置问题

**解决方案**:
- 以管理员身份运行 SwitchHosts
- 关闭可能占用 hosts 文件的程序
- 检查文件权限设置

### 2. hosts 配置不生效

**可能原因**:
- DNS 缓存未清除
- hosts 文件格式错误
- 方案未激活

**解决方案**:
```powershell
# 清除 DNS 缓存
ipconfig /flushdns

# 检查 hosts 文件格式
# 确保激活了正确的方案
```

### 3. 远程 hosts 加载失败

**可能原因**:
- 网络连接问题
- URL 无效
- 防火墙阻止

**解决方案**:
- 检查网络连接
- 验证 URL 是否有效
- 检查防火墙设置

### 4. 程序启动失败

**可能原因**:
- 缺少运行时环境
- 配置文件损坏
- 权限问题

**解决方案**:
- 重新安装 SwitchHosts
- 删除配置文件后重试
- 以管理员身份运行

### 5. 方案切换后不生效

**可能原因**:
- hosts 文件写入失败
- 需要管理员权限
- 系统保护机制

**解决方案**:
- 确保以管理员身份运行
- 手动检查 hosts 文件内容
- 重启网络服务

## 故障排除

### 检查 hosts 文件位置

```powershell
# Windows hosts 文件位置
notepad C:\Windows\System32\drivers\etc\hosts

# macOS/Linux hosts 文件位置
sudo nano /etc/hosts
```

### 验证 hosts 配置

```powershell
# 使用 nslookup 检查解析
nslookup myapp.local

# 使用 ping 测试连接
ping myapp.local
```

### 查看日志

1. **点击"帮助"菜单**
2. **选择"查看日志"**
3. **分析错误信息**

## 最佳实践

### 1. 合理命名方案

使用有意义的名称，如：
- "开发环境 - 项目A"
- "测试环境 - 内网"
- "广告屏蔽 - 基础"

### 2. 使用注释

为每个配置添加注释说明：

```
# 本地开发服务器
# 用于项目A的前端开发
127.0.0.1 project-a.local
```

### 3. 定期备份

定期导出和备份 hosts 配置方案。

### 4. 测试配置

激活新配置后，测试域名解析是否正确：

```powershell
nslookup myapp.local
ping myapp.local
```

### 5. 保持简洁

避免在一个方案中添加过多配置，按用途拆分多个方案。

## 相关资源

- [SwitchHosts 官方网站](https://switchhosts.app)
- [SwitchHosts GitHub 仓库](https://github.com/oldj/SwitchHosts)
- [hosts 文件说明](https://en.wikipedia.org/wiki/Hosts_(file))
- [常见广告屏蔽 hosts 列表](https://github.com/StevenBlack/hosts)
- [Windows hosts 文件位置](https://support.microsoft.com/en-us/windows/reset-hosts-file)