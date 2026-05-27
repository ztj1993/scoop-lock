# WebStorm 使用指南

## 简介

WebStorm 是 JetBrains 公司出品的专业跨平台 JavaScript 集成开发环境（IDE），被广大前端开发者誉为"最智能的 JavaScript IDE"。

它为现代 JavaScript、TypeScript、React、Vue、Angular、Node.js 等技术栈提供了全面的开发支持。

当前通过 Scoop 安装的版本为 **v2026.1.2**，采用 **Proprietary**（商业专有）许可。

项目定位为 **"Cross-Platform IDE for JavaScript by JetBrains"**。

官方网站：https://www.jetbrains.com/webstorm/

WebStorm 基于 JetBrains 的 IntelliJ 平台构建，继承了 IntelliJ 系列 IDE 的强大代码分析能力。

它提供了开箱即用的开发体验，无需安装大量插件即可支持主流前端框架和工具链。

无论是前端开发、Node.js 后端开发还是全栈开发，WebStorm 都能提供高效的开发体验。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v2026.1.2                             |
| 许可证     | Proprietary（商业专有）               |
| 项目主页   | https://www.jetbrains.com/webstorm/   |
| 快捷方式   | webstorm64.exe                        |

### 许可说明

WebStorm 是商业软件，需要购买许可证或使用免费试用版。

JetBrains 为开源项目维护者、学生和教师提供免费许可证。

30 天免费试用期可用于评估和学习。

### 系统要求

WebStorm 对系统资源有一定要求，建议配置：

- 内存：8GB 以上（推荐 16GB）
- 磁盘：SSD 硬盘，至少 3.5GB 可用空间
- 分辨率：1024x768 以上
- JDK：内置 JetBrains Runtime，无需额外安装

## 主要功能

### 智能代码编辑

WebStorm 提供业界领先的智能代码编辑功能。

**代码补全**：基于项目上下文的智能补全，支持 JavaScript、TypeScript、HTML、CSS 等语言。能够识别变量类型、函数签名和 API 文档，提供精确的补全建议。

**代码分析**：实时代码质量检查，在编写代码的同时发现潜在问题。支持 ESLint、Stylelint 等代码检查工具的集成。

**重构支持**：提供安全的重命名、提取变量/函数、内联变量等重构操作。所有重构操作会自动检查影响范围，避免引入错误。

**代码格式化**：支持 Prettier、ESLint 等格式化工具的集成，一键格式化代码。

**意图操作**：通过 `Alt+Enter` 快捷键访问上下文相关的代码改进建议。

### 框架支持

WebStorm 对主流前端框架提供了深度集成支持。

**React**：支持 JSX/TSX 语法、React Hooks、组件属性类型检查、React Router 等。

**Vue.js**：支持 Vue 3 Composition API、单文件组件（SFC）、Vue Router、Vuex/Pinia 等。

**Angular**：支持 Angular 模板语法、依赖注入、Angular CLI 集成等。

**Next.js/Nuxt.js**：对全栈框架也有良好的支持。

**TypeScript**：完整的 TypeScript 支持，包括类型检查、代码补全和重构。

### 调试与测试

内置功能强大的调试器和测试运行器。

**JavaScript 调试器**：支持断点设置、变量监视、调用堆栈查看、表达式求值等。

**Node.js 调试**：直接在 IDE 中调试 Node.js 应用，支持子进程调试。

**浏览器调试**：支持在 Chrome 和 Firefox 中调试前端应用，无需额外插件。

**测试集成**：支持 Jest、Mocha、Karma、Cypress、Playwright 等主流测试框架。

**覆盖率报告**：可以生成代码覆盖率报告，直观显示测试覆盖情况。

### 版本控制集成

WebStorm 内置了完善的版本控制工具。

**Git 集成**：可视化差异比较、分支管理、合并冲突解决、Git 日志查看。

**GitHub 集成**：直接在 IDE 中创建 Pull Request、查看 Code Review。

**其他 VCS**：支持 Mercurial、Subversion 等版本控制系统。

**变更列表**：可以将修改分组管理，支持部分提交。

### 内置终端与工具

WebStorm 集成了多种开发工具，减少在不同应用间切换的需要。

**内置终端**：支持 PowerShell、Git Bash 等多种终端类型。

**数据库工具**：内置数据库客户端，支持连接和查询多种数据库。

**HTTP 客户端**：可以在 IDE 中发送 HTTP 请求并查看响应。

**Docker 集成**：支持 Docker 容器的管理和运行。

**npm/yarn 集成**：可以直接在 IDE 中运行 npm 和 yarn 命令。

### 部署与远程开发

WebStorm 支持多种部署方式和远程开发场景。

**FTP/SFTP 部署**：配置远程服务器，一键上传文件。

**Docker 部署**：通过 Docker 容器部署和调试应用。

**WSL 支持**：完整支持在 Windows Subsystem for Linux 环境中开发。

**SSH 远程开发**：通过 SSH 连接到远程服务器进行开发。

### 代码导航

强大的代码导航功能帮助开发者快速理解和浏览代码库。

**跳转到定义**：`Ctrl+Click` 跳转到变量、函数或类的定义处。

**查找用法**：快速查找某个符号在项目中的所有使用位置。

**文件结构**：通过 `Ctrl+F12` 快速查看当前文件的结构大纲。

**全局搜索**：支持按文件名、符号名或文本内容进行全局搜索。

## 常用操作

### 安装

通过 Scoop 安装 WebStorm：

```powershell
scoop install WebStorm
```

安装完成后，可以通过以下方式启动：

- 双击桌面上的 `webstorm64.exe` 快捷方式
- 在命令行输入 `webstorm64 .` 在当前目录打开 WebStorm

### 创建新项目

1. 启动 WebStorm，选择"New Project"
2. 选择项目模板（如 Vue.js、React、Angular、Node.js 等）
3. 配置项目名称、位置和初始化参数
4. 点击"Create"创建项目

### 打开已有项目

通过菜单"File" → "Open"选择项目目录：

```powershell
webstorm64 C:\path\to\your\project
```

WebStorm 会自动检测项目类型并配置相应的支持。

### 常用快捷键

WebStorm 提供了丰富的快捷键，以下是 Windows/Linux 下最常用的操作：

| 快捷键               | 功能                   |
| -------------------- | ---------------------- |
| `Ctrl+N`             | 查找类                 |
| `Ctrl+Shift+N`       | 查找文件               |
| `Ctrl+Shift+F`       | 全局文本搜索           |
| `Ctrl+F`             | 当前文件搜索           |
| `Ctrl+R`             | 当前文件替换           |
| `Ctrl+Shift+R`       | 全局替换               |
| `Ctrl+G`             | 跳转到指定行           |
| `Ctrl+E`             | 最近打开的文件         |
| `Ctrl+Shift+E`       | 最近编辑的文件         |
| `Alt+F7`             | 查找用法               |
| `Ctrl+F12`           | 文件结构               |
| `Ctrl+Alt+L`         | 格式化代码             |
| `Ctrl+/`             | 注释/取消注释行        |
| `Ctrl+Shift+/`       | 注释/取消注释块        |
| `Ctrl+D`             | 复制当前行             |
| `Ctrl+Y`             | 删除当前行             |
| `Ctrl+Shift+Up/Down` | 移动代码行             |
| `F2`                 | 跳转到下一个错误       |
| `Shift+F2`           | 跳转到上一个错误       |
| `Ctrl+Shift+A`       | 查找所有操作           |
| `Double Shift`       | 全局搜索（Search Everywhere）|

### 配置 ESLint

1. 打开"Settings" → "Languages & Frameworks" → "JavaScript" → "Code Quality Tools" → "ESLint"
2. 选择"Manual ESLint configuration"
3. 指定 ESLint 包路径（通常自动检测）
4. 配置配置文件路径（.eslintrc.js 或 .eslintrc.json）
5. 勾选"Run eslint --fix on save"启用保存时自动修复

### 配置 Prettier

1. 打开"Settings" → "Languages & Frameworks" → "JavaScript" → "Prettier"
2. 指定 Prettier 包路径
3. 勾选"On 'Reformat Code' action"和"On save"
4. 配置 Prettier 配置文件路径

### 调试 Node.js 应用

1. 在代码中设置断点（点击行号左侧）
2. 右键点击文件或选择"Run" → "Debug '文件名'"
3. 调试器会在断点处暂停，可以查看变量值和调用堆栈
4. 使用调试工具栏进行单步执行（F8）、步入（F7）、步出（Shift+F8）

### 运行和调试测试

1. 打开测试文件
2. 点击测试函数左侧的绿色三角形运行单个测试
3. 点击文件顶部的绿色三角形运行整个测试文件
4. 使用"Run"工具窗口查看测试结果和覆盖率

### 配置代码模板

1. 打开"Settings" → "Editor" → "Live Templates"
2. 选择语言分组或创建新分组
3. 添加缩写和模板代码
4. 配置模板变量和适用上下文

### 使用内置终端

1. 使用 `Alt+F12` 打开内置终端
2. 可以在终端中运行 npm、yarn、git 等命令
3. 终端默认使用项目根目录作为工作目录

## 常见问题

### IDE 启动缓慢

**问题**：WebStorm 启动需要很长时间。

**解决方法**：
- 增加 IDE 的内存分配：修改 `Help` → `Edit Custom VM Options`
- 设置 `-Xmx4096m` 增加最大堆内存
- 排除不必要的目录（如 node_modules）：在"Settings" → "Directories"中标记为"Excluded"
- 禁用不需要的插件：在"Settings" → "Plugins"中管理
- 确保使用 SSD 存储项目文件

### 代码补全不工作

**问题**：输入代码时没有补全提示。

**解决方法**：
- 确认项目已正确配置 TypeScript/JavaScript 版本
- 检查"Power Save Mode"是否开启（关闭以启用代码分析）
- 删除 `.idea` 目录并重新打开项目
- 执行"File" → "Invalidate Caches / Restart"
- 确认 node_modules 已正确安装

### TypeScript 类型检查报错

**问题**：编辑器显示不正确的 TypeScript 错误。

**解决方法**：
- 确认项目中的 TypeScript 版本与 IDE 使用的版本一致
- 在"Settings" → "Languages & Frameworks" → "TypeScript"中配置正确的 tsconfig.json
- 执行"TypeScript" → "Restart TypeScript Service"重新加载
- 确认 @types 包已正确安装

### 内存不足错误

**问题**：IDE 显示"Out of Memory"错误。

**解决方法**：
- 增加 VM 选项中的 `-Xmx` 值
- 减少打开的项目数量
- 排除大型目录（如 node_modules、dist）
- 关闭不需要的工具窗口和编辑器标签页
- 考虑增加物理内存

### Git 操作缓慢

**问题**：Git 相关操作（如提交、更新）响应很慢。

**解决方法**：
- 在"Settings" → "Version Control" → "Background"中调整刷新间隔
- 排除不需要版本控制的目录
- 确认 .gitignore 文件正确配置
- 对于大型仓库，考虑使用 Git 的 sparse checkout

### 插件安装失败

**问题**：安装或更新插件时出错。

**解决方法**：
- 检查网络连接和代理设置
- 在"Settings" → "Appearance & Behavior" → "System Settings" → "HTTP Proxy"中配置代理
- 尝试手动下载插件文件并安装
- 确认 IDE 版本与插件版本兼容

### WSL 环境配置问题

**问题**：在 WSL 环境中使用 WebStorm 时遇到路径或执行问题。

**解决方法**：
- 确认已安装"Remote Development"插件
- 配置 WSL 发行版的正确路径
- 确认 WSL 中的 Node.js 已正确安装
- 使用 WebStorm 的 WSL 集成功能而非直接映射路径

## 相关资源

### 官方资源

- WebStorm 官方网站：https://www.jetbrains.com/webstorm/
- WebStorm 文档：https://www.jetbrains.com/help/webstorm/
- WebStorm 快捷键参考：https://www.jetbrains.com/help/webstorm/reference-keymap-index.html
- JetBrains 博客：https://blog.jetbrains.com/webstorm/
- WebStorm 教程：https://www.jetbrains.com/webstorm/learn/

### 学习资源

- JetBrains 学习中心：https://www.jetbrains.com/learn/
- WebStorm 官方 YouTube 频道：https://www.youtube.com/c/JetBrainsTV
- JetBrains Academy：https://academy.jetbrains.com/

### 社区资源

- JetBrains 社区论坛：https://intellij-support.jetbrains.com/hc/en-us/community/topics
- Stack Overflow WebStorm 标签：https://stackoverflow.com/questions/tagged/webstorm
- YouTrack 问题追踪：https://youtrack.jetbrains.com/issues/WEB

### 许可证获取

- 购买许可证：https://www.jetbrains.com/webstorm/buy/
- 学生免费许可证：https://www.jetbrains.com/community/education/
- 开源项目免费许可证：https://www.jetbrains.com/community/opensource/
- 30 天试用：https://www.jetbrains.com/webstorm/download/

### 相关工具推荐

- **VS Code**：免费开源的轻量级代码编辑器
- **Sublime Text**：轻量级文本编辑器
- **IntelliJ IDEA**：JetBrains 的全功能 Java/Kotlin IDE，包含 Web 开发支持
- **PhpStorm**：JetBrains 的 PHP IDE，同样支持前端开发
