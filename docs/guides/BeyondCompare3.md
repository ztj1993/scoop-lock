# Beyond Compare 3 使用指南

## 简介

Beyond Compare 是一款专业的文件和文件夹比较工具，用于比较、合并和同步文件。

**版本**: 3.3.14  
**官网**: https://www.scootersoftware.com/  
**许可证**: 商业软件（有试用期）

## 主要功能

- 文件比较和合并
- 文件夹比较和同步
- 十六进制比较
- 图片比较
- 注册表比较
- 版本控制集成
- 自动化脚本

## 启动和界面

### 启动方式

```bash
# 启动 Beyond Compare
BCompare.exe

# 比较两个文件
BCompare.exe file1.txt file2.txt

# 比较两个文件夹
BCompare.exe folder1 folder2

# 打开会话
BCompare.exe session.bcpkg
```

### 主界面

```
1. 菜单栏: 文件、编辑、视图等菜单
2. 工具栏: 常用操作按钮
3. 会话栏: 显示打开的会话
4. 比较面板: 左右两个面板显示比较内容
5. 状态栏: 显示当前状态信息
```

## 文件比较

### 文本文件比较

```
1. 打开 Beyond Compare
2. 选择"文本比较"
3. 拖放文件到左右面板
4. 查看差异
```

### 差异显示

```
红色: 不同的行
蓝色: 修改过的行
灰色: 相同的行
白色: 空行
```

### 导航操作

```
下一个差异: Ctrl+Down
上一个差异: Ctrl+Up
第一个差异: Ctrl+Home
最后一个差异: Ctrl+End
```

### 编辑操作

```
复制到左侧: Ctrl+Left
复制到右侧: Ctrl+Right
删除: Del
撤销: Ctrl+Z
重做: Ctrl+Y
```

## 文件夹比较

### 比较文件夹

```
1. 选择"文件夹比较"
2. 输入左右文件夹路径
3. 点击"比较"
4. 查看差异文件
```

### 过滤设置

```
文件名过滤: *.txt, *.doc
大小过滤: >1MB, <100KB
日期过滤: 今天, 昨天, 本周
状态过滤: 新增, 修改, 删除
```

### 同步操作

```
同步到左侧: 将右侧文件复制到左侧
同步到右侧: 将左侧文件复制到右侧
双向同步: 智能同步两个文件夹
```

## 合并操作

### 三方合并

```
1. 打开三方合并会话
2. 加载三个文件
3. 解决冲突
4. 保存合并结果
```

### 冲突解决

```
选择左侧: 使用左侧版本
选择右侧: 使用右侧版本
选择两者: 使用两个版本
手动编辑: 手动修改
```

## 高级功能

### 十六进制比较

```
1. 选择"十六进制比较"
2. 加载二进制文件
3. 查看字节差异
4. 编辑十六进制数据
```

### 图片比较

```
1. 选择"图片比较"
2. 加载图片文件
3. 查看视觉差异
4. 调整比较设置
```

### 注册表比较

```
1. 选择"注册表比较"
2. 输入注册表路径
3. 比较注册表项
4. 导出差异
```

## 会话管理

### 保存会话

```
文件 → 保存会话
输入会话名称
选择保存位置
```

### 加载会话

```
文件 → 打开会话
选择会话文件
点击打开
```

### 会话设置

```
比较规则: 设置比较算法
显示选项: 设置显示方式
过滤器: 设置文件过滤
操作: 设置同步操作
```

## 脚本自动化

### 命令行参数

```bash
# 比较文件
BCompare.exe /silent file1.txt file2.txt

# 同步文件夹
BCompare.exe /silent /left=folder1 /right=folder2

# 生成报告
BCompare.exe /silent /output=report.html file1.txt file2.txt
```

### 脚本示例

```bash
# 比较脚本
@echo off
BCompare.exe /silent "file1.txt" "file2.txt"
if errorlevel 1 (
    echo 文件不同
) else (
    echo 文件相同
)
```

### 自动化脚本

```bash
# 文件夹同步脚本
@echo off
set BC="C:\Program Files\Beyond Compare 3\BCompare.exe"
set LEFT=C:\Source
set RIGHT=D:\Backup

%BC% /silent /left=%LEFT% /right=%RIGHT% /sync=mirror
```

## 报告生成

### 生成比较报告

```
1. 完成比较操作
2. 选择"会话" → "比较报告"
3. 选择报告格式
4. 设置报告选项
5. 生成报告
```

### 报告格式

```
HTML: 网页格式
XML: 数据格式
纯文本: 文本格式
CSV: 表格格式
```

## 版本控制集成

### Git 集成

```
1. 配置 Git 使用 Beyond Compare
2. git config --global diff.tool bc3
3. git config --global merge.tool bc3
```

### SVN 集成

```
1. 配置 SVN 使用 Beyond Compare
2. 编辑 SVN 配置文件
3. 设置比较和合并工具
```

## 常见问题

### 1. 如何设置默认比较工具？

```
1. 工具 → 选项
2. 选择"启动"
3. 设置为默认比较工具
```

### 2. 如何比较大文件？

```
1. 增加内存设置
2. 使用快速比较算法
3. 分割大文件
```

### 3. 如何解决编码问题？

```
1. 设置正确的文件编码
2. 使用编码转换
3. 检查系统区域设置
```

### 4. 如何批量处理文件？

```
1. 使用脚本自动化
2. 使用命令行参数
3. 创建批处理文件
```

## 配置选项

### 比较设置

```
工具 → 选项 → 比较
- 忽略大小写
- 忽略空白字符
- 忽略行尾符
- 正则表达式规则
```

### 显示设置

```
工具 → 选项 → 显示
- 字体设置
- 颜色方案
- 行号显示
- 差异高亮
```

### 操作设置

```
工具 → 选项 → 操作
- 自动同步
- 确认操作
- 备份文件
- 日志记录
```

## 快捷键大全

### 文件操作

```
Ctrl+N: 新建会话
Ctrl+O: 打开会话
Ctrl+S: 保存会话
Ctrl+P: 打印
Ctrl+Q: 退出
```

### 编辑操作

```
Ctrl+Z: 撤销
Ctrl+Y: 重做
Ctrl+X: 剪切
Ctrl+C: 复制
Ctrl+V: 粘贴
Del: 删除
```

### 比较操作

```
Ctrl+Down: 下一个差异
Ctrl+Up: 上一个差异
Ctrl+Left: 复制到左侧
Ctrl+Right: 复制到右侧
Ctrl+M: 合并
```

### 视图操作

```
Ctrl++: 放大
Ctrl+-: 缩小
Ctrl+0: 重置缩放
F11: 全屏
```

## 插件扩展

### 安装插件

```
1. 下载插件文件
2. 复制到插件目录
3. 重启 Beyond Compare
```

### 常用插件

```
- 图片比较插件
- 十六进制插件
- 注册表插件
- FTP 插件
```

## 性能优化

### 优化设置

```
1. 调整内存分配
2. 使用快速比较算法
3. 限制比较深度
4. 使用过滤器
```

### 大文件处理

```
1. 分割大文件
2. 使用流式比较
3. 增加缓存大小
4. 使用 SSD 存储
```

## 相关资源

- [Beyond Compare 官方网站](https://www.scootersoftware.com/)
- [Beyond Compare 文档](https://www.scootersoftware.com/support.php)
- [Beyond Compare 论坛](https://www.scootersoftware.com/vbulletin/)
- [Beyond Compare 下载](https://www.scootersoftware.com/download.php)