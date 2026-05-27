# Gemini CLI 使用指南

## 简介

Gemini CLI 是 Google 开发的一款命令行 AI 工具，将 Gemini 大语言模型的强大能力直接带入您的终端环境。

- **版本**: v0.43.0
- **许可证**: Apache-2.0
- **官方描述**: "Brings the power of Gemini directly into your terminal"
- **官方网站**: https://geminicli.com
- **安装方式**: 通过 pnpm 安装
- **依赖项**: pnpm、Node.js

Gemini CLI 允许开发者无需离开终端即可与 Gemini AI 进行交互，支持代码生成、代码解释、问题解答、文本创作等多种任务。它特别适合习惯在命令行环境中工作的开发者，能够无缝集成到日常工作流中。

## 主要功能

### 交互式对话

Gemini CLI 提供了强大的交互式对话界面，支持多轮对话，能够记住上下文，实现连贯的问答体验。您可以在终端中直接与 Gemini AI 进行自然语言交流。

### 代码生成与辅助

- 根据自然语言描述生成代码片段
- 支持多种编程语言（Python、JavaScript、Go、Rust、Java 等）
- 代码补全和优化建议
- 代码重构建议

### 文件与项目理解

- 读取并分析本地文件内容
- 理解项目结构和代码逻辑
- 基于现有代码提供改进建议
- 支持将文件内容作为上下文发送给 AI

### 管道集成

- 支持通过管道（pipe）将其他命令的输出传递给 Gemini CLI
- 可以与其他命令行工具组合使用
- 支持标准输入/输出流操作

### 会话管理

- 支持保存和恢复对话会话
- 可以在多个会话之间切换
- 对话历史记录管理

### 多模态支持

- 支持文本输入和输出
- 支持图片分析（取决于模型版本）
- 支持代码和非代码内容的混合处理

## 常用命令/操作

### 安装

确保已安装 Node.js 和 pnpm，然后执行：

```bash
pnpm install -g @anthropic-ai/gemini-cli
```

或者使用 scoop 安装：

```bash
scoop install gemini-cli
```

### 基本使用

启动交互式对话：

```bash
gemini
```

直接提问（单次模式）：

```bash
gemini "请解释什么是递归函数"
```

### 文件操作

将文件内容作为上下文发送：

```bash
gemini "请解释这段代码" -f ./src/main.py
```

分析多个文件：

```bash
gemini "这些文件之间的关系是什么" -f file1.js -f file2.js
```

### 管道操作

将命令输出传递给 Gemini CLI：

```bash
cat error.log | gemini "请分析这个错误日志"
```

```bash
git diff | gemini "请审查这些代码变更"
```

```bash
ls -la | gemini "请解释这个目录结构"
```

### 会话管理

启动带名称的会话：

```bash
gemini --session my-project
```

恢复已有会话：

```bash
gemini --resume my-project
```

列出所有会话：

```bash
gemini --list-sessions
```

### 配置管理

设置 API 密钥：

```bash
gemini config set api-key YOUR_API_KEY
```

设置默认模型：

```bash
gemini config set model gemini-2.0-flash
```

查看当前配置：

```bash
gemini config list
```

### 高级用法

指定输出格式：

```bash
gemini "生成一个JSON格式的配置文件" --format json
```

设置温度参数（控制创造性）：

```bash
gemini "写一首诗" --temperature 0.8
```

使用系统提示：

```bash
gemini --system "你是一个资深的Python开发者" "如何优化这段代码"
```

## 常见问题

### Q: 安装时提示 Node.js 版本不兼容怎么办？

Gemini CLI 需要 Node.js 18 或更高版本。请检查您的 Node.js 版本：

```bash
node --version
```

如果版本过低，建议使用 nvm 升级：

```bash
nvm install 20
nvm use 20
```

### Q: 如何获取 Gemini API 密钥？

1. 访问 Google AI Studio: https://aistudio.google.com/
2. 登录您的 Google 账号
3. 在 API Keys 页面创建新的密钥
4. 使用 `gemini config set api-key` 命令设置密钥

### Q: 提示 "Authentication failed" 怎么解决？

- 确认 API 密钥是否正确设置
- 检查 API 密钥是否已过期
- 确认网络连接正常，没有被防火墙阻止
- 尝试重新设置密钥：`gemini config set api-key NEW_KEY`

### Q: 响应速度很慢怎么办？

- 检查网络连接质量
- 尝试切换到更快的模型（如 gemini-2.0-flash）
- 减少输入上下文的长度
- 考虑使用代理或 VPN 改善网络状况

### Q: 如何在脚本中使用 Gemini CLI？

Gemini CLI 支持非交互模式，适合在脚本中使用：

```bash
response=$(gemini "你的问题" --format text)
echo "$response"
```

也可以使用 `--no-interactive` 参数避免交互式提示。

### Q: 支持哪些语言的代码生成？

Gemini CLI 基于 Gemini 模型，支持几乎所有主流编程语言，包括但不限于：
- Python、JavaScript、TypeScript
- Java、Kotlin、Scala
- C、C++、C#、Go、Rust
- PHP、Ruby、Swift
- SQL、Shell/Bash
- HTML、CSS、Markdown

### Q: 对话历史保存在哪里？

默认情况下，会话数据保存在用户目录下的 `.gemini` 文件夹中。可以通过以下命令查看：

```bash
gemini config get session-dir
```

### Q: 如何更新 Gemini CLI？

使用 pnpm 更新：

```bash
pnpm update -g @anthropic-ai/gemini-cli
```

或使用 scoop：

```bash
scoop update gemini-cli
```

## 相关资源

- **官方网站**: https://geminicli.com
- **GitHub 仓库**: https://github.com/google-gemini/gemini-cli
- **Gemini API 文档**: https://ai.google.dev/docs
- **Google AI Studio**: https://aistudio.google.com/
- **pnpm 官网**: https://pnpm.io/
- **Node.js 官网**: https://nodejs.org/
- **Scoop 包管理器**: https://scoop.sh/
- **Apache-2.0 许可证**: https://www.apache.org/licenses/LICENSE-2.0
