# pnpm 使用指南

## 简介

pnpm 是一个快速、高效的 Node.js 包管理器，它通过创新的存储机制大大减少了磁盘空间占用并提高了安装速度。与 npm 和 yarn 不同，pnpm 使用硬链接和符号链接来共享依赖，避免了重复存储相同的包。

**版本**: v11.3.0  
**许可证**: MIT  
**官方描述**: A fast and disk space efficient Node package manager  
**项目主页**: https://pnpm.io/

### 核心特性

- **高效存储**: 使用硬链接和符号链接，避免重复存储依赖
- **严格依赖管理**: 默认使用非提升的 node_modules 结构，避免幽灵依赖
- **快速安装**: 通过并行安装和缓存机制提高安装速度
- **磁盘空间节省**: 相同版本的包只存储一次
- **兼容性**: 完全兼容 npm 生态系统
- **工作区支持**: 原生支持 monorepo 项目结构

## 主要功能

### 1. 依赖管理

pnpm 提供了完整的依赖管理功能：

- **安装依赖**: 从 npm registry 安装包
- **更新依赖**: 更新项目中的包到最新版本
- **删除依赖**: 移除不再需要的包
- **全局安装**: 全局安装命令行工具

### 2. 存储管理

pnpm 使用全局存储来管理包：

- **内容寻址存储**: 基于包内容的哈希值存储
- **硬链接共享**: 相同版本的包通过硬链接共享
- **存储清理**: 清理不再使用的包

### 3. 工作区支持

pnpm 原生支持 monorepo 项目：

- **工作区协议**: 使用 `workspace:*` 引用本地包
- **并行执行**: 在多个包中并行执行命令
- **依赖提升**: 智能提升公共依赖

### 4. 脚本执行

pnpm 支持执行 package.json 中的脚本：

- **运行脚本**: 执行项目定义的脚本
- **过滤执行**: 在特定包中执行脚本
- **并行执行**: 并行运行多个脚本

## 常用命令

### 依赖安装命令

#### 安装所有依赖

```bash
# 安装项目所有依赖
pnpm install

# 安装时使用冻结的 lockfile
pnpm install --frozen-lockfile

# 安装时忽略 scripts
pnpm install --ignore-scripts

# 安装可选依赖
pnpm install --no-optional
```

#### 添加依赖

```bash
# 添加生产依赖
pnpm add <package>

# 添加开发依赖
pnpm add -D <package>

# 添加到全局
pnpm add -g <package>

# 添加指定版本
pnpm add <package>@<version>

# 添加到特定工作区
pnpm add <package> --filter <workspace>
```

#### 移除依赖

```bash
# 移除依赖
pnpm remove <package>

# 移除开发依赖
pnpm remove -D <package>

# 移除全局包
pnpm remove -g <package>
```

#### 更新依赖

```bash
# 更新所有依赖
pnpm update

# 更新指定包
pnpm update <package>

# 更新到最新版本
pnpm update --latest

# 交互式更新
pnpm update --interactive
```

### 包执行命令

#### 使用 dlx 执行包

```bash
# 临时安装并执行包
pnpm dlx <package>

# 执行特定版本
pnpm dlx <package>@<version>

# 执行带参数的命令
pnpm dlx <package> -- <args>
```

#### 运行脚本

```bash
# 运行 package.json 中的脚本
pnpm run <script>

# 运行 start 脚本
pnpm start

# 运行 test 脚本
pnpm test

# 运行 build 脚本
pnpm run build

# 在工作区中运行脚本
pnpm run --filter <workspace> <script>
```

### 存储管理命令

#### 查看存储信息

```bash
# 查看存储路径
pnpm store path

# 查看存储状态
pnpm store status
```

#### 清理存储

```bash
# 清理未使用的包
pnpm store prune

# 清理所有缓存
pnpm cache delete
```

### 工作区命令

#### 工作区管理

```bash
# 列出所有工作区
pnpm list --depth 0

# 在所有工作区中执行命令
pnpm -r run <script>

# 在特定工作区中执行
pnpm --filter <workspace> run <script>

# 添加依赖到根工作区
pnpm add -w <package>
```

### 配置命令

#### 配置管理

```bash
# 查看配置
pnpm config list

# 设置配置
pnpm config set <key> <value>

# 删除配置
pnpm config delete <key>

# 编辑配置文件
pnpm config edit
```

### 信息查看命令

#### 查看包信息

```bash
# 查看包信息
pnpm info <package>

# 查看依赖树
pnpm list

# 查看特定包的依赖
pnpm list <package>

# 查看全局安装的包
pnpm list -g --depth 0
```

## 常见问题

### 1. 安装速度慢

**问题**: pnpm install 执行速度很慢。

**解决方案**:
1. 检查网络连接，使用国内镜像源：
   ```bash
   pnpm config set registry https://registry.npmmirror.com
   ```
2. 使用 `--prefer-offline` 优先使用本地缓存
3. 清理缓存后重新安装：
   ```bash
   pnpm store prune
   pnpm install
   ```

### 2. 幽灵依赖问题

**问题**: 项目中使用了未在 package.json 中声明的依赖。

**解决方案**:
1. pnpm 默认使用严格模式，不会提升依赖
2. 如果需要提升依赖，可以配置 `.npmrc`：
   ```ini
   shamefully-hoist=true
   ```
3. 或者显式安装缺失的依赖

### 3. 硬链接问题

**问题**: 在某些系统上硬链接创建失败。

**解决方案**:
1. 确保 pnpm 安装目录和项目在同一文件系统上
2. 使用符号链接替代硬链接：
   ```bash
   pnpm config set use-linking false
   ```
3. 检查文件系统权限

### 4. 版本冲突

**问题**: 不同包依赖同一包的不同版本。

**解决方案**:
1. 使用 `pnpm list` 查看依赖树
2. 使用 `pnpm why <package>` 查看依赖来源
3. 使用 `overrides` 统一版本：
   ```json
   {
     "pnpm": {
       "overrides": {
         "package-name": "version"
       }
     }
   }
   ```

### 5. 全局安装路径问题

**问题**: 全局安装的包找不到。

**解决方案**:
1. 查看全局 bin 目录：
   ```bash
   pnpm bin -g
   ```
2. 确保全局 bin 目录在 PATH 中
3. 重新安装全局包

### 6. lockfile 冲突

**问题**: 团队成员之间的 pnpm-lock.yaml 文件冲突。

**解决方案**:
1. 使用 `--frozen-lockfile` 安装
2. 定期更新 lockfile
3. 使用版本控制解决冲突

### 7. 工作区配置问题

**问题**: 工作区中的包无法相互引用。

**解决方案**:
1. 确保根目录有 `pnpm-workspace.yaml` 文件：
   ```yaml
   packages:
     - 'packages/*'
   ```
2. 使用 `workspace:*` 协议引用本地包
3. 运行 `pnpm install` 重新链接

## 高级用法

### 配置 .npmrc

创建项目级 `.npmrc` 文件：

```ini
# 使用国内镜像
registry=https://registry.npmmirror.com

# 严格模式
strict-peer-dependencies=true

# 自动安装 peer dependencies
auto-install-peers=true

# 设置存储路径
store-dir=~/.pnpm-store
```

### 工作区配置

创建 `pnpm-workspace.yaml` 文件：

```yaml
packages:
  - 'packages/*'
  - 'apps/*'
  - '!**/test/**'
```

### 脚本过滤

在 monorepo 中过滤执行脚本：

```bash
# 在所有包中执行
pnpm -r run build

# 在特定包中执行
pnpm --filter @myorg/package run build

# 在依赖包中执行
pnpm --filter @myorg/package... run build

# 在匹配模式的包中执行
pnpm --filter "./packages/*" run build
```

### 依赖覆盖

在 `package.json` 中覆盖依赖版本：

```json
{
  "pnpm": {
    "overrides": {
      "lodash": "^4.17.21",
      "express": "$express"
    }
  }
}
```

### Hooks

配置 pnpm hooks：

```javascript
// .pnpm-hooks.cjs
module.exports = {
  hooks: {
    readPackage: (pkg) => {
      // 修改 package.json
      return pkg
    }
  }
}
```

## 最佳实践

### 1. 使用严格模式

保持默认的严格依赖管理：

```ini
# .npmrc
shamefully-hoist=false
strict-peer-dependencies=true
```

### 2. 定期更新依赖

使用交互式更新：

```bash
# 交互式更新
pnpm update --interactive

# 更新到最新版本
pnpm update --interactive --latest
```

### 3. 清理未使用的依赖

定期清理项目中未使用的依赖：

```bash
# 使用 depcheck 检查
npx depcheck

# 移除未使用的依赖
pnpm remove <unused-package>
```

### 4. 使用 workspace 协议

在 monorepo 中使用 workspace 协议：

```json
{
  "dependencies": {
    "@myorg/utils": "workspace:*"
  }
}
```

### 5. 配置镜像源

配置国内镜像源以加速下载：

```bash
# 设置 npm 镜像
pnpm config set registry https://registry.npmmirror.com

# 设置 Electron 镜像
pnpm config set electron_mirror https://npmmirror.com/mirrors/electron/
```

## 相关资源

### 官方资源

- **官方网站**: https://pnpm.io/
- **GitHub 仓库**: https://github.com/pnpm/pnpm
- **官方文档**: https://pnpm.io/zh/
- **问题反馈**: https://github.com/pnpm/pnpm/issues

### 对比工具

- **npm**: https://www.npmjs.com/
- **yarn**: https://yarnpkg.com/
- **bun**: https://bun.sh/

### 相关工具

- **nx**: https://nx.dev/
- **turborepo**: https://turbo.build/repo
- **lerna**: https://lerna.js.org/
- **changesets**: https://github.com/changesets/changesets

### 学习资源

- **pnpm 最佳实践**: https://pnpm.io/zh/faq
- **Monorepo 指南**: https://pnpm.io/zh/workspaces
- **npm 配置**: https://docs.npmjs.com/cli/v10/using-npm/config

## 更新日志

### v11.3.0

- 改进了工作区依赖解析
- 优化了安装速度
- 修复了 Windows 系统上的路径问题

### v11.2.0

- 添加了对 Node.js 20 的支持
- 改进了错误提示信息
- 优化了存储管理

### v11.1.0

- 添加了交互式更新功能
- 改进了 monorepo 支持
- 修复了 lockfile 解析问题

## 总结

pnpm 是一个现代化的 Node.js 包管理器，它通过创新的存储机制提供了以下优势：

- **高效存储**: 通过硬链接和符号链接节省磁盘空间
- **严格依赖管理**: 避免幽灵依赖问题
- **快速安装**: 通过缓存和并行安装提高速度
- **Monorepo 支持**: 原生支持工作区项目结构

对于追求效率和严格依赖管理的 Node.js 项目，pnpm 是一个优秀的选择。