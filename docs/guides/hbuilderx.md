# HBuilderX 使用指南

## 简介

HBuilderX 是由 DCloud 推出的一款面向前端开发者的轻量级 IDE，全称 HBuilderX。
HBuilderX v3.96 是当前的稳定版本，它专注于前端开发，特别是基于 Vue.js 的 uni-app
跨平台应用开发。

HBuilderX 的核心优势在于其极致的启动速度和流畅的编辑体验，号称"飞一样的编码"。
它原生支持 uni-app、Vue、小程序、5+App 等 DCloud 生态的核心技术，同时也支持
HTML、CSS、JavaScript、TypeScript 等主流前端语言。

HBuilderX 是 DCloud 生态中的核心开发工具，特别适合使用 uni-app 进行跨平台应用开发的
团队。通过一套代码，可以同时编译到 iOS、Android、Web、各种小程序（微信/支付宝/百度/
字节跳动/QQ/京东/快手/飞书等）以及快应用等多个平台。

- **版本**: v3.96
- **许可证**: 免费使用
- **官方网站**: https://www.dcloud.io/hbuilderx.html
- **安装方式**: Scoop 包管理器

## 主要功能

### 前端开发支持

HBuilderX 提供全面的前端开发支持：

- **HTML/CSS/JS**: 完整的语法高亮、智能补全、代码提示
- **Vue.js**: 深度支持 Vue 2 和 Vue 3，包括语法高亮、指令补全、组件提示
- **TypeScript**: 内置 TypeScript 编译器支持
- **Less/Sass/SCSS**: CSS 预处理器语法支持
- **ES6+**: 支持最新的 JavaScript 语法特性
- **Emmet**: 内置 Emmet 缩写展开，提高 HTML/CSS 编写效率

### uni-app 开发

HBuilderX 是 uni-app 开发的首选 IDE：

- **项目创建**: 内置 uni-app 项目模板，一键创建项目
- **可视化界面**: uni-app 可视化开发界面
- **组件提示**: uni-app 所有组件和 API 的智能提示
- **条件编译**: 完整支持 uni-app 的条件编译语法
- **真机调试**: 支持连接真机进行实时调试
- **模拟器运行**: 内置 App 模拟器预览
- **多端编译**: 一键编译到多个平台

### 小程序开发

支持多种小程序平台的开发和调试：

- 微信小程序
- 支付宝小程序
- 百度小程序
- 字节跳动小程序
- QQ 小程序
- 京东小程序
- 快手小程序
- 飞书小程序

### App 开发

基于 5+App 和 uni-app 的原生应用开发：

- 内置 App 打包功能
- 真机联调
- 原生插件市场
- 离线打包支持
- 云打包服务

### 内置工具

- **终端**: 内置终端工具，支持运行 npm/yarn 命令
- **Git**: 内置 Git 版本控制支持
- **Markdown**: 内置 Markdown 预览
- **数据库**: 基础的数据库操作工具
- **API 测试**: 简单的 API 调试工具
- **JSON 格式化**: JSON 数据格式化和校验

### 代码效率工具

- **智能补全**: 超强的代码智能提示
- **代码块**: 自定义代码片段，快速生成常用代码
- **语法校验**: 实时语法检查
- **代码格式化**: 一键格式化代码
- **多光标编辑**: 支持多光标同时编辑
- **列选择**: 支持列选择模式编辑
- **代码折叠**: 支持代码块折叠

## 常用命令/操作

### 启动 HBuilderX

Scoop 安装后，使用以下方式启动：

```bash
HBuilderX
```

也可以通过开始菜单或桌面快捷方式启动。

命令行打开项目或文件：

```bash
HBuilderX C:\path\to\project
```

### 项目管理

**创建 uni-app 项目：**

1. 打开 HBuilderX
2. 点击菜单 `文件` → `新建` → `项目`
3. 选择 `uni-app` 项目类型
4. 选择 Vue 版本（Vue2 或 Vue3）
5. 输入项目名称和路径
6. 选择模板（默认模板、Hello uni-app 等）
7. 点击 `创建` 按钮

**导入已有项目：**

1. 点击 `文件` → `导入` → `从本地目录导入`
2. 选择项目根目录
3. 项目将自动识别类型并导入

**项目结构（uni-app）：**

```
project/
├── pages/          # 页面目录
├── components/     # 组件目录
├── static/         # 静态资源
├── store/          # Vuex/Pinia 状态管理
├── App.vue         # 应用入口
├── main.js         # 主入口文件
├── manifest.json   # 应用配置
├── pages.json      # 页面路由配置
└── uni.scss        # 全局样式变量
```

### 编码技巧

**代码块使用：**

输入缩写后按 Tab 键展开：

- `uview` → uView 组件模板
- `ufor` → uni-app v-for 循环
- `uif` → uni-app v-if 条件
- `upage` → uni-app 页面模板
- `ucomp` → uni-app 组件模板

**快捷键：**

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+N` | 新建文件 |
| `Ctrl+S` | 保存文件 |
| `Ctrl+Shift+S` | 另存为 |
| `Ctrl+Z` | 撤销 |
| `Ctrl+Y` | 重做 |
| `Ctrl+/` | 行注释 |
| `Ctrl+Shift+/` | 块注释 |
| `Ctrl+D` | 删除行 |
| `Ctrl+Shift+K` | 删除行 |
| `Ctrl+Enter` | 在下方插入行 |
| `Ctrl+Shift+Enter` | 在上方插入行 |
| `Ctrl+F` | 查找 |
| `Ctrl+H` | 替换 |
| `Ctrl+G` | 跳转到行 |
| `Ctrl+P` | 跳转到匹配的括号 |
| `Ctrl+Shift+F` | 全局搜索 |
| `Ctrl+Shift+O` | 跳转到符号 |
| `Alt+Up/Down` | 上/下移动行 |
| `Ctrl+Shift+Up/Down` | 上/下复制行 |
| `Ctrl+Alt+L` | 格式化代码 |
| `Ctrl+Space` | 触发代码提示 |

### 运行与调试

**运行到浏览器：**

1. 点击菜单 `运行` → `运行到浏览器`
2. 选择目标浏览器
3. 将自动启动本地开发服务器并在浏览器中打开

**运行到模拟器（App）：**

1. 点击 `运行` → `运行到手机或模拟器`
2. 选择连接的设备或模拟器
3. 等待编译完成

**运行到小程序：**

1. 点击 `运行` → `运行到小程序模拟器`
2. 选择微信开发者工具等
3. 首次运行需要配置小程序开发者工具路径

**真机调试：**

1. 手机连接 USB 或使用 Wi-Fi 调试
2. 手机端安装 HBuilder 基座 App
3. 点击 `运行` → `运行到手机或模拟器`
4. 选择目标设备

### 打包发布

**云打包：**

1. 点击 `发行` → `原生App-云打包`
2. 选择打包平台（Android/iOS）
3. 配置应用图标、启动图等
4. 点击打包，等待云端编译完成
5. 下载安装包

**本地打包：**

1. 点击 `发行` → `原生App-本地打包`
2. 需要提前配置 Android Studio 或 Xcode 环境
3. 生成本地打包资源
4. 使用原生 IDE 完成最终打包

**发布为 Web 应用：**

```bash
npm run build
```

生成的文件在 `dist/build/h5` 目录中。

**发布为小程序：**

1. 点击 `发行` → `小程序-微信`
2. 使用微信开发者工具上传代码
3. 在微信公众平台提交审核

### 插件管理

打开插件市场：

1. 点击菜单 `工具` → `插件安装`
2. 浏览或搜索需要的插件
3. 点击安装

推荐插件：

- **scss/sass 编译**: CSS 预处理器支持
- **less 编译**: Less 预处理器支持
- **ESLint**: 代码规范检查
- **uni-app CLI**: uni-app 命令行工具
- **Git 集成增强**: 更强的 Git 支持

## 常见问题

### Q: HBuilderX 启动后如何修改语言为中文？

HBuilderX 默认支持中文。如果显示为英文，可以在 `设置` → `语言` 中切换为简体中文。

### Q: 如何配置 uni-app 的开发环境？

1. 确保 Node.js 已安装（推荐 16.x+）
2. 使用 HBuilderX 创建 uni-app 项目时会自动配置依赖
3. 如需命令行开发，可使用 `@dcloudio/uni-cli`

### Q: 运行到微信小程序报错怎么办？

1. 确认已安装微信开发者工具
2. 在 `设置` → `运行设置` 中配置微信开发者工具路径
3. 确认微信开发者工具中已开启服务端口
4. 检查 AppID 是否正确配置

### Q: 如何解决编译速度慢的问题？

1. 关闭不必要的文件标签
2. 减少同时打开的项目数量
3. 检查是否有大量未保存的文件
4. 增加 HBuilderX 分配的内存

### Q: uni-app 条件编译如何使用？

使用 `#ifdef` 和 `#ifndef` 指令进行条件编译：

```javascript
// #ifdef H5
console.log('只在 H5 平台执行');
// #endif

// #ifdef APP-PLUS
console.log('只在 App 平台执行');
// #endif

// #ifdef MP-WEIXIN
console.log('只在微信小程序执行');
// #endif
```

### Q: 如何更新 HBuilderX？

1. 点击菜单 `帮助` → `检查更新`
2. 如果有新版本，按照提示下载并安装
3. 或使用 Scoop 更新：`scoop update hbuilderx`

## 相关资源

- **官方网站**: https://www.dcloud.io/hbuilderx.html
- **uni-app 官网**: https://uniapp.dcloud.net.cn
- **uni-app 文档**: https://uniapp.dcloud.net.cn/uni-app/
- **DCloud 插件市场**: https://ext.dcloud.net.cn
- **DCloud 社区**: https://ask.dcloud.net.cn
- **uni-app GitHub**: https://github.com/dcloudio/uni-app
- **HBuilderX 快捷键大全**: https://hx.dcloud.net.cn/ShortcutKey
- **Scoop 包管理器**: https://scoop.sh
