# PowerToys 使用指南

## 简介

Microsoft PowerToys 是一套由微软开发的 Windows 系统增强工具集，专为高级用户设计，用于自定义和优化 Windows 使用体验。它包含多个实用工具，可以帮助用户提高工作效率。

**版本**: v0.99.1  
**许可证**: MIT  
**官方描述**: A set of utilities for power users to tune and streamline their Windows experience  
**项目主页**: https://github.com/microsoft/PowerToys

### 核心特性

- **窗口管理**: 通过 FancyZones 自定义窗口布局
- **文件重命名**: 使用 PowerRename 批量重命名文件
- **快速启动**: 通过 PowerToys Run 快速启动应用和搜索
- **颜色选择**: 使用 ColorPicker 提取屏幕颜色
- **键盘管理**: 通过 Keyboard Manager 自定义键盘快捷键
- **图片调整**: 使用 Image Resizer 快速调整图片大小

## 主要功能

### 1. FancyZones 窗口管理

FancyZones 是一个窗口布局管理器，允许用户创建自定义的窗口布局：

- **自定义布局**: 创建复杂的窗口布局
- **快速切换**: 通过快捷键快速切换窗口位置
- **多显示器支持**: 支持多显示器配置
- **布局模板**: 预设多种布局模板

### 2. PowerRename 批量重命名

PowerRename 提供了强大的文件批量重命名功能：

- **正则表达式**: 支持正则表达式匹配
- **实时预览**: 重命名前预览结果
- **搜索替换**: 支持搜索和替换操作
- **大小写转换**: 支持大小写转换

### 3. PowerToys Run 快速启动

PowerToys Run 是一个快速启动器，类似于 macOS 的 Spotlight：

- **应用搜索**: 快速搜索和启动应用程序
- **文件搜索**: 搜索文件和文件夹
- **计算器**: 内置计算器功能
- **单位转换**: 支持单位转换

### 4. ColorPicker 颜色选择器

ColorPicker 允许用户从屏幕上提取颜色：

- **屏幕取色**: 从屏幕上任意位置取色
- **颜色格式**: 支持多种颜色格式（HEX、RGB、HSL）
- **颜色历史**: 保存最近使用的颜色
- **颜色编辑**: 编辑和调整颜色值

### 5. File Explorer 增强

File Explorer 添加了额外的预览功能：

- **SVG 预览**: 在资源管理器中预览 SVG 文件
- **Markdown 预览**: 预览 Markdown 文件
- **PDF 预览**: 预览 PDF 文件
- **代码预览**: 预览代码文件

### 6. Keyboard Manager 键盘管理器

Keyboard Manager 允许用户重新映射键盘按键：

- **按键重映射**: 重新映射单个按键
- **快捷键重映射**: 重新映射键盘快捷键
- **应用特定映射**: 为特定应用程序设置不同的映射
- **组合键支持**: 支持复杂的组合键映射

### 7. Image Resizer 图片调整器

Image Resizer 提供了快速调整图片大小的功能：

- **批量调整**: 批量调整多张图片大小
- **预设尺寸**: 预设多种常用尺寸
- **自定义尺寸**: 自定义输出尺寸
- **格式转换**: 支持图片格式转换

### 8. PowerRename 文件重命名

PowerRename 是 Windows 资源管理器的扩展：

- **批量重命名**: 批量重命名文件和文件夹
- **正则表达式**: 支持正则表达式
- **实时预览**: 实时预览重命名结果
- **撤销功能**: 支持撤销重命名操作

## 常用操作

### FancyZones 使用

#### 启动 FancyZones 编辑器

```bash
# 默认快捷键
Win + Shift + `
```

#### 使用 FancyZones

1. 按住 `Shift` 键拖动窗口
2. 窗口会自动吸附到预设的区域
3. 释放鼠标完成窗口放置

#### 自定义布局

1. 打开 PowerToys 设置
2. 选择 FancyZones
3. 点击"启动布局编辑器"
4. 创建自定义布局

### PowerToys Run 使用

#### 启动 PowerToys Run

```bash
# 默认快捷键
Alt + Space
```

#### 搜索应用

1. 按 `Alt + Space` 启动
2. 输入应用名称
3. 从结果中选择应用

#### 使用计算器

1. 启动 PowerToys Run
2. 输入数学表达式
3. 按 Enter 计算结果

### ColorPicker 使用

#### 启动 ColorPicker

```bash
# 默认快捷键
Win + Shift + C
```

#### 取色操作

1. 按 `Win + Shift + C` 启动
2. 移动鼠标到目标位置
3. 点击鼠标左键复制颜色值

### Keyboard Manager 使用

#### 打开设置

1. 打开 PowerToys 设置
2. 选择 Keyboard Manager

#### 重新映射按键

1. 点击"重新映射按键"
2. 添加新的映射规则
3. 选择原始按键和目标按键
4. 保存设置

### Image Resizer 使用

#### 调整图片大小

1. 在资源管理器中选择图片
2. 右键点击选择"调整图片大小"
3. 选择预设尺寸或自定义尺寸
4. 点击"调整大小"

### PowerRename 使用

#### 批量重命名文件

1. 在资源管理器中选择文件
2. 右键点击选择"PowerRename"
3. 输入搜索和替换文本
4. 预览重命名结果
5. 点击"应用"

## 常见问题

### 1. PowerToys 无法启动

**问题**: PowerToys 启动后没有反应或崩溃。

**解决方案**:
1. 检查 Windows 版本是否满足要求（Windows 10 1803 或更高版本）
2. 以管理员身份运行
3. 重新安装 PowerToys
4. 检查是否有其他软件冲突

### 2. FancyZones 不工作

**问题**: FancyZones 窗口吸附功能不工作。

**解决方案**:
1. 确保 FancyZones 功能已启用
2. 检查快捷键是否与其他软件冲突
3. 重启 PowerToys
4. 重新配置布局

### 3. PowerToys Run 搜索不到应用

**问题**: PowerToys Run 无法搜索到已安装的应用。

**解决方案**:
1. 等待索引完成（首次使用需要时间）
2. 检查应用是否在开始菜单中
3. 重建索引：设置 > PowerToys Run > 重建索引
4. 检查搜索路径设置

### 4. ColorPicker 无法取色

**问题**: ColorPicker 无法从屏幕上取色。

**解决方案**:
1. 确保 ColorPicker 功能已启用
2. 检查快捷键设置
3. 尝试以管理员身份运行
4. 检查是否有屏幕保护程序干扰

### 5. Keyboard Manager 映射不生效

**问题**: 设置的键盘映射没有生效。

**解决方案**:
1. 确保 Keyboard Manager 已启用
2. 检查映射是否正确配置
3. 重启相关应用程序
4. 检查是否有其他键盘管理软件冲突

### 6. Image Resizer 选项缺失

**问题**: 右键菜单中没有 Image Resizer 选项。

**解决方案**:
1. 确保 Image Resizer 功能已启用
2. 重启资源管理器
3. 重新安装 PowerToys
4. 检查文件类型支持

### 7. PowerRename 无法使用

**问题**: 右键菜单中没有 PowerRename 选项。

**解决方案**:
1. 确保 PowerRename 功能已启用
2. 重启资源管理器
3. 检查 Windows 版本兼容性
4. 重新安装 PowerToys

## 高级用法

### FancyZones 高级配置

#### 创建复杂布局

```json
{
  "editor-application-last-zones": [
    {
      "zone-index": 0,
      "zone-set": {
        "type": "custom",
        "info": {
          "rows": 2,
          "columns": 3
        }
      }
    }
  ]
}
```

#### 多显示器配置

1. 为每个显示器设置不同的布局
2. 配置跨显示器的窗口移动
3. 设置显示器特定的快捷键

### PowerToys Run 插件

#### 启用插件

1. 打开 PowerToys 设置
2. 选择 PowerToys Run
3. 在插件部分启用所需插件

#### 常用插件

- **程序**: 搜索和启动应用程序
- **计算器**: 数学计算
- **文件搜索**: 搜索文件和文件夹
- **Web 搜索**: 执行网络搜索
- **Shell**: 执行命令行命令

### Keyboard Manager 高级映射

#### 应用特定映射

1. 打开 Keyboard Manager
2. 选择"应用特定映射"
3. 选择目标应用程序
4. 为该应用设置特定的按键映射

#### 组合键映射

```json
{
  "originalKeys": "Ctrl+Shift+A",
  "newKeys": "Ctrl+C"
}
```

### 批量操作脚本

使用 PowerToys 命令行工具：

```bash
# 启动 PowerToys
PowerToys.exe

# 打开特定功能设置
PowerToys.exe --open-settings FancyZones
```

## 最佳实践

### 1. 合理配置快捷键

避免与常用软件的快捷键冲突：

- 检查常用软件的快捷键设置
- 选择不常用的组合键
- 为不同功能使用不同的修饰键

### 2. 定期更新

保持 PowerToys 更新到最新版本：

```bash
# 检查更新
winget upgrade Microsoft.PowerToys
```

### 3. 备份配置

定期备份 PowerToys 配置：

1. 打开 PowerToys 设置
2. 导出配置文件
3. 保存到安全位置

### 4. 性能优化

根据需要启用/禁用功能：

- 禁用不使用的功能
- 调整 FancyZones 的性能设置
- 优化 PowerToys Run 的索引范围

### 5. 团队协作

在团队中统一配置：

1. 导出标准配置
2. 分享配置文件
3. 统一快捷键设置

## 相关资源

### 官方资源

- **GitHub 仓库**: https://github.com/microsoft/PowerToys
- **官方文档**: https://learn.microsoft.com/en-us/windows/powertoys/
- **问题反馈**: https://github.com/microsoft/PowerToys/issues
- **发布页面**: https://github.com/microsoft/PowerToys/releases

### 相关工具

- **Windows Terminal**: https://github.com/microsoft/terminal
- **VS Code**: https://code.visualstudio.com/
- **AutoHotkey**: https://www.autohotkey.com/
- **DisplayFusion**: https://www.displayfusion.com/

### 学习资源

- **PowerToys 使用指南**: https://learn.microsoft.com/en-us/windows/powertoys/
- **FancyZones 教程**: https://learn.microsoft.com/en-us/windows/powertoys/fancyzones
- **PowerToys Run 教程**: https://learn.microsoft.com/en-us/windows/powertoys/run

### 社区资源

- **Reddit 社区**: https://www.reddit.com/r/PowerToys/
- **GitHub Discussions**: https://github.com/microsoft/PowerToys/discussions
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/powertoys

## 更新日志

### v0.99.1

- 修复了 FancyZones 在多显示器上的问题
- 改进了 PowerToys Run 的搜索性能
- 添加了新的键盘映射选项

### v0.99.0

- 添加了新的 FancyZones 布局模板
- 改进了 ColorPicker 的颜色格式支持
- 优化了 Image Resizer 的性能

### v0.98.0

- 添加了新的 PowerToys Run 插件
- 改进了 Keyboard Manager 的稳定性
- 修复了多个 bug

## 总结

Microsoft PowerToys 是一套功能强大的 Windows 系统增强工具，它提供了：

- **窗口管理**: 通过 FancyZones 自定义窗口布局
- **快速启动**: 通过 PowerToys Run 快速访问应用和文件
- **颜色选择**: 使用 ColorPicker 提取屏幕颜色
- **键盘管理**: 通过 Keyboard Manager 自定义键盘映射
- **文件操作**: 使用 PowerRename 和 Image Resizer 处理文件

对于希望提高 Windows 使用效率的高级用户，PowerToys 是一个不可或缺的工具集。