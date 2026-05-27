# NVM for Windows 使用指南

## 简介

NVM (Node Version Manager) for Windows 是一个用于 Windows 系统的 Node.js 版本管理工具。它允许您在同一台机器上安装和切换多个 Node.js 版本，这对于开发和测试不同版本的 Node.js 应用程序非常有用。

**版本**: v1.2.2  
**许可证**: MIT  
**官方描述**: A node.js version management utility for Windows  
**项目主页**: https://github.com/coreybutler/nvm-windows

### 核心特性

- 支持安装和管理多个 Node.js 版本
- 支持快速切换 Node.js 版本
- 支持全局 npm 包的迁移
- 支持使用国内镜像源加速下载
- 支持 .nvmrc 文件指定项目所需的 Node.js 版本
- 支持 LTS 版本管理

## 主要功能

### 1. Node.js 版本管理

NVM for Windows 提供了完整的 Node.js 版本管理功能：

- **安装 Node.js**: 可以安装任意版本的 Node.js
- **卸载 Node.js**: 可以卸载已安装的 Node.js 版本
- **切换版本**: 可以在已安装的版本之间快速切换
- **查看版本列表**: 可以查看已安装的版本和可用的远程版本

### 2. 镜像源配置

为了加速在中国大陆地区的下载速度，可以配置国内镜像源：

```bash
# 设置环境变量
NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
```

### 3. 项目版本管理

通过项目根目录下的 `.nvmrc` 文件，可以指定项目所需的 Node.js 版本：

```bash
# 在项目根目录创建 .nvmrc 文件
echo "16.13.0" > .nvmrc

# 使用项目指定的版本
nvm use
```

### 4. npm 包管理

NVM 可以在切换版本时自动迁移全局安装的 npm 包：

```bash
# 安装新版本时自动迁移全局包
nvm install 16.13.0 --reinstall-packages-from=14.17.0
```

## 常用命令

### 版本管理命令

#### 查看已安装版本

```bash
# 列出所有已安装的 Node.js 版本
nvm list

# 示例输出
    16.13.0
  * 14.17.0 (Currently using 64-bit executable)
    12.22.0
```

#### 安装 Node.js

```bash
# 安装最新版本
nvm install latest

# 安装指定版本
nvm install 16.13.0

# 安装最新 LTS 版本
nvm install lts

# 安装时同时迁移全局包
nvm install 16.13.0 --reinstall-packages-from=14.17.0
```

#### 切换 Node.js 版本

```bash
# 切换到指定版本
nvm use 16.13.0

# 切换到 32 位版本
nvm use 16.13.0 32

# 切换到 64 位版本
nvm use 16.13.0 64

# 使用 .nvmrc 文件指定的版本
nvm use
```

#### 卸载 Node.js

```bash
# 卸载指定版本
nvm uninstall 14.17.0
```

### 配置命令

#### 查看当前配置

```bash
# 查看 NVM 配置
nvm list
```

#### 设置镜像源

```bash
# 设置 Node.js 下载镜像
nvm node_mirror https://npmmirror.com/mirrors/node

# 设置 npm 下载镜像
nvm npm_mirror https://npmmirror.com/npm
```

#### 设置安装目录

```bash
# 设置 Node.js 安装目录
nvm root [path]
```

### 信息查看命令

#### 查看版本信息

```bash
# 查看 NVM 版本
nvm version

# 查看 Node.js 版本
node -v

# 查看 npm 版本
npm -v
```

#### 查看远程版本

```bash
# 查看可用的 Node.js 版本
nvm list available

# 查看最新的 LTS 版本
nvm list lts
```

## 常见问题

### 1. 安装后 node 命令不可用

**问题**: 安装 NVM 后，`node` 命令无法识别。

**解决方案**:
1. 确保已使用 `nvm use` 命令切换到某个版本
2. 检查系统环境变量是否正确设置
3. 重新打开命令行窗口

### 2. 下载速度慢

**问题**: 安装 Node.js 时下载速度很慢。

**解决方案**:
1. 配置国内镜像源：
   ```bash
   nvm node_mirror https://npmmirror.com/mirrors/node
   nvm npm_mirror https://npmmirror.com/npm
   ```
2. 或者设置环境变量：
   ```bash
   set NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
   ```

### 3. 全局 npm 包丢失

**问题**: 切换 Node.js 版本后，之前安装的全局 npm 包找不到了。

**解决方案**:
1. 使用 `--reinstall-packages-from` 参数安装新版本：
   ```bash
   nvm install 16.13.0 --reinstall-packages-from=14.17.0
   ```
2. 或者手动重新安装全局包

### 4. 权限问题

**问题**: 安装或使用 NVM 时出现权限错误。

**解决方案**:
1. 以管理员身份运行命令行
2. 确保 NVM 安装目录有写入权限
3. 检查用户目录下的 `.nvm` 文件夹权限

### 5. 版本切换不生效

**问题**: 执行 `nvm use` 后版本没有切换成功。

**解决方案**:
1. 确保以管理员身份运行命令行
2. 检查是否安装了目标版本
3. 重新打开命令行窗口
4. 检查环境变量设置

### 6. .nvmrc 文件不生效

**问题**: 项目中的 `.nvmrc` 文件没有被识别。

**解决方案**:
1. 确保在项目根目录下创建了 `.nvmrc` 文件
2. 文件内容只包含版本号，如 `16.13.0`
3. 使用 `nvm use` 命令切换版本

### 7. 32 位和 64 位版本问题

**问题**: 不确定使用 32 位还是 64 位版本。

**解决方案**:
1. 查看系统架构：`wmic os get osarchitecture`
2. 64 位系统推荐使用 64 位版本
3. 切换时指定架构：`nvm use 16.13.0 64`

## 高级用法

### 批量安装版本

```bash
# 安装多个版本
nvm install 14.17.0
nvm install 16.13.0
nvm install 18.0.0
```

### 自动版本切换

在项目根目录创建 `.nvmrc` 文件，内容为所需的 Node.js 版本号：

```
16.13.0
```

然后在项目目录中运行：

```bash
nvm use
```

### 脚本集成

在 PowerShell 脚本中使用 NVM：

```powershell
# 设置 Node.js 版本
nvm use 16.13.0

# 检查当前版本
node -v
```

### 环境变量配置

在系统环境变量中配置：

```
NVM_HOME: C:\Users\<username>\AppData\Roaming\nvm
NVM_SYMLINK: C:\Program Files\nodejs
NVM_NODEJS_ORG_MIRROR: https://npmmirror.com/mirrors/node
```

## 最佳实践

### 1. 使用 LTS 版本

对于生产环境，建议使用 LTS (Long Term Support) 版本：

```bash
# 安装最新的 LTS 版本
nvm install lts

# 切换到 LTS 版本
nvm use lts
```

### 2. 项目版本管理

在项目中维护 `.nvmrc` 文件，确保团队成员使用相同的 Node.js 版本：

```bash
# 创建 .nvmrc 文件
echo "16.13.0" > .nvmrc

# 提交到版本控制
git add .nvmrc
git commit -m "Add .nvmrc for Node.js version management"
```

### 3. 定期清理

定期清理不再使用的 Node.js 版本：

```bash
# 查看已安装版本
nvm list

# 卸载不需要的版本
nvm uninstall 12.22.0
```

### 4. 镜像源配置

配置国内镜像源以加速下载：

```bash
# 永久配置镜像源
nvm node_mirror https://npmmirror.com/mirrors/node
nvm npm_mirror https://npmmirror.com/npm
```

## 相关资源

### 官方资源

- **GitHub 仓库**: https://github.com/coreybutler/nvm-windows
- **官方文档**: https://github.com/coreybutler/nvm-windows#readme
- **问题反馈**: https://github.com/coreybutler/nvm-windows/issues

### Node.js 资源

- **Node.js 官网**: https://nodejs.org/
- **Node.js 下载**: https://nodejs.org/en/download/
- **Node.js LTS 版本**: https://nodejs.org/en/about/releases/

### 国内镜像源

- **npmmirror**: https://npmmirror.com/
- **淘宝 NPM 镜像**: https://npmmirror.com/mirrors/node
- **CNPM**: https://cnpmjs.org/

### 相关工具

- **nvm (Unix/macOS)**: https://github.com/nvm-sh/nvm
- **nvm-windows**: https://github.com/coreybutler/nvm-windows
- **fnm**: https://github.com/Schniz/fnm
- **volta**: https://volta.sh/

### 学习资源

- **Node.js 官方教程**: https://nodejs.org/en/docs/guides/
- **npm 官方文档**: https://docs.npmjs.com/
- **Node.js 最佳实践**: https://github.com/goldbergyoni/nodebestpractices

## 更新日志

### v1.2.2

- 修复了版本切换的稳定性问题
- 改进了错误提示信息
- 优化了下载速度

### v1.2.1

- 添加了对 Node.js 18.x 的支持
- 修复了 32 位系统兼容性问题

### v1.2.0

- 添加了 `.nvmrc` 文件支持
- 改进了镜像源配置
- 添加了 LTS 版本管理功能

## 总结

NVM for Windows 是 Windows 系统上管理 Node.js 版本的必备工具。通过它，您可以：

- 轻松安装和管理多个 Node.js 版本
- 在不同项目间快速切换 Node.js 版本
- 使用国内镜像源加速下载
- 通过 `.nvmrc` 文件管理项目版本

掌握 NVM 的使用，将大大提高您的 Node.js 开发效率。