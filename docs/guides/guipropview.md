# GUIPropView 使用指南

## 简介

GUIPropView 是由 NirSoft 开发的一款免费工具（Freeware），用于显示系统中所有已打开窗口的
详细信息。它能够列出每个窗口的各种属性，包括窗口标题、类名、句柄、位置、大小、样式、
进程 ID、线程 ID 等丰富的窗口元数据。

GUIPropView v1.21 是当前版本，支持简体中文在内的多种语言界面。该工具是 Windows 系统管理员、
软件开发人员和 UI 调试人员的得力助手，特别适合用于分析窗口属性、调试窗口相关问题以及
自动化脚本的开发辅助。

GUIPropView 是 NirSoft 众多实用工具中的一款，以其小巧轻量、绿色便携、无需安装的特点
深受 Windows 用户喜爱。

- **版本**: v1.21
- **许可证**: Freeware（免费软件）
- **官方网站**: https://www.nirsoft.net/utils/gui_prop_view.html
- **安装方式**: Scoop 包管理器

## 主要功能

### 窗口属性查看

GUIPropView 能够显示每个窗口的完整属性列表：

- **基本属性**：窗口标题、窗口类名、窗口句柄（HWND）
- **位置信息**：窗口坐标（X、Y）、宽度、高度
- **进程信息**：所属进程 ID（PID）、线程 ID、进程路径
- **窗口样式**：标准样式、扩展样式（如 WS_VISIBLE、WS_EX_TOOLWINDOW 等）
- **父窗口**：父窗口句柄、所有者窗口
- **状态信息**：是否可见、是否最小化、是否最大化、是否禁用
- **类信息**：窗口类的详细信息，包括类样式、图标、光标等
- **菜单信息**：窗口关联的菜单句柄

### 窗口操作

除了查看属性，GUIPropView 还支持对窗口执行基本操作：

- 显示/隐藏窗口
- 启用/禁用窗口
- 最小化/最大化/恢复窗口
- 设置窗口焦点
- 修改窗口标题
- 调整窗口大小和位置
- 设置窗口透明度
- 关闭窗口

### 实时刷新

- 支持自动刷新窗口列表
- 可配置刷新间隔
- 实时反映窗口状态变化
- 高亮显示新创建的窗口
- 标记已关闭的窗口

### 数据导出

支持将窗口信息导出为多种格式：

- 文本文件（TXT）
- CSV 文件
- HTML 报告
- XML 文件
- JSON 格式

### 过滤与搜索

- 按窗口标题过滤
- 按进程名称过滤
- 按窗口类名过滤
- 按窗口可见性过滤
- 支持正则表达式搜索
- 只显示可见窗口或所有窗口

### 多语言支持

GUIPropView 支持多种语言界面，包括：

- 英语
- 简体中文
- 繁体中文
- 日语
- 韩语
- 以及其他多种语言

## 常用命令/操作

### 启动工具

Scoop 安装后直接运行：

```bash
GUIPropView
```

也可以通过开始菜单或 Scoop 快捷方式启动。

### 命令行参数

GUIPropView 支持命令行参数进行自动化操作：

导出窗口列表到文本文件：

```bash
GUIPropView /shtml "C:\output\windows.html"
```

导出为 CSV 格式：

```bash
GUIPropView /scomma "C:\output\windows.csv"
```

导出为纯文本：

```bash
GUIPropView /stext "C:\output\windows.txt"
```

只显示可见窗口：

```bash
GUIPropView /VisibleWindowsOnly 1
```

常用命令行参数：

| 参数 | 说明 |
|------|------|
| `/shtml file` | 导出为 HTML 文件 |
| `/scomma file` | 导出为 CSV 文件 |
| `/stext file` | 导出为纯文本文件 |
| `/sxml file` | 导出为 XML 文件 |
| `/sort column` | 按指定列排序 |
| `/VisibleWindowsOnly 1` | 只显示可见窗口 |
| `/NoConnect 1` | 启动时不自动连接 |

### 界面操作

**查看窗口属性：**

1. 启动 GUIPropView 后，主窗口将列出系统中所有已打开的窗口
2. 点击任意窗口条目，下方的属性面板将显示该窗口的详细属性
3. 使用工具栏按钮切换显示模式（按进程分组/平铺/树形视图）

**窗口操作：**

1. 在窗口列表中右键点击目标窗口
2. 从弹出菜单中选择操作：
   - 显示/隐藏窗口
   - 最小化/最大化/还原
   - 启用/禁用
   - 设置焦点
   - 关闭窗口
   - 修改窗口标题

**查找特定窗口：**

1. 使用菜单 `View` → `Find Window` 打开查找对话框
2. 可以使用搜索框按标题、类名或进程名过滤
3. 支持拖拽查找工具到目标窗口上

**使用拖拽查找功能：**

1. 点击工具栏上的靶心图标
2. 按住鼠标左键拖拽到目标窗口上
3. 释放鼠标后将自动选中并显示该窗口的属性

### 数据导出操作

导出选中窗口的信息：

1. 选中一个或多个窗口
2. 点击 `File` → `Save Selected Items`
3. 选择导出格式和保存路径

导出所有窗口信息：

1. 点击 `File` → `Save All Items`
2. 选择导出格式

批量导出（命令行）：

```powershell
GUIPropView /stext "all_windows.txt"
GUIPropView /VisibleWindowsOnly 1 /shtml "visible_windows.html"
```

### 列自定义

- 右键点击列表头可以显示/隐藏特定列
- 拖拽列头可以调整列顺序
- 点击列头可以按该列排序
- 支持多列排序（按住 Shift 点击）

### 窗口层次分析

GUIPropView 支持以树形视图查看窗口的父子层次关系：

1. 点击 `View` → `Tree View` 切换到树形模式
2. 可以清晰地看到窗口之间的父子关系
3. 折叠/展开节点查看不同层级的窗口
4. 有助于理解复杂应用程序的窗口结构

### 窗口样式分析

查看窗口的 Win32 样式标志：

- **WS_VISIBLE**: 窗口是否可见
- **WS_DISABLED**: 窗口是否被禁用
- **WS_MINIMIZE**: 窗口是否最小化
- **WS_MAXIMIZE**: 窗口是否最大化
- **WS_POPUP**: 是否为弹出窗口
- **WS_CHILD**: 是否为子窗口
- **WS_EX_TOOLWINDOW**: 是否为工具窗口
- **WS_EX_TOPMOST**: 是否为置顶窗口
- **WS_EX_TRANSPARENT**: 是否为透明窗口

理解这些样式标志有助于开发和调试 Windows 桌面应用程序。

### 与其他工具配合使用

GUIPropView 可以与 NirSoft 的其他工具配合使用：

- **NirCmd**: 使用命令行控制窗口（显示、隐藏、移动等）
- **WinLister**: 列出所有窗口的简化视图
- **OpenedFilesView**: 查看进程打开的文件
- **ProcessExplorer**: 深入查看进程详情

## 常见问题

### Q: GUIPropView 显示的窗口信息太多，如何筛选？

使用以下方法进行筛选：
1. 点击 `Options` → `Show Only Visible Windows` 只显示可见窗口
2. 使用工具栏的过滤功能按关键词筛选
3. 使用 `View` 菜单中的过滤选项
4. 使用正则表达式进行高级筛选

### Q: 如何查看某个特定进程的所有窗口？

在过滤框中输入进程名称，或使用 `Options` → `Show All Windows` 并按进程列排序。

### Q: 如何修改窗口属性？

GUIPropView 主要用于查看窗口属性。部分属性（如窗口标题、可见性、位置等）可以修改：
1. 右键点击目标窗口
2. 选择相应的操作菜单项
3. 输入新值并确认

### Q: 工具是否会影响系统性能？

GUIPropView 非常轻量，CPU 和内存占用极低。只有在频繁刷新大量窗口时才会对性能有轻微影响。
可以调整自动刷新间隔来降低资源消耗。

### Q: 为什么某些窗口没有显示？

可能的原因：
1. 窗口设置了 WS_EX_TOOLWINDOW 样式
2. 窗口属于其他用户会话
3. 启用了"只显示可见窗口"选项
4. 窗口属于系统进程（需要管理员权限）

以管理员身份运行 GUIPropView 可以查看更多的系统窗口。

### Q: 如何在中文系统上使用中文界面？

GUIPropView 会自动检测系统语言并加载对应的翻译文件。如果系统语言为简体中文，
工具将自动显示中文界面。如果未自动切换，可以手动下载中文语言文件并放到工具目录下。

### Q: 如何自动化获取窗口信息？

使用命令行参数可以实现自动化导出：

```powershell
# 每小时自动导出窗口信息
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
GUIPropView /stext "C:\logs\windows_$timestamp.txt"
```

## 相关资源

- **官方网站**: https://www.nirsoft.net/utils/gui_prop_view.html
- **NirSoft 工具集**: https://www.nirsoft.net
- **下载页面**: https://www.nirsoft.net/utils/gui_prop_view.html
- **其他窗口工具**: https://www.nirsoft.net/utils/window_information.html
- **NirCmd 命令行工具**: https://www.nirsoft.net/utils/nircmd.html
- **Scoop 包管理器**: https://scoop.sh
