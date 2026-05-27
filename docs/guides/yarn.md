# Yarn 使用指南

## 简介

Yarn 是由 Facebook（现 Meta）开发的 Node.js 依赖管理工具，旨在解决 npm 在早期版本中面临的性能和安全性问题。

它提供了快速、可靠和安全的依赖管理体验，是 JavaScript 生态系统中最重要的包管理器之一。

当前通过 Scoop 安装的版本为 **v1.22.19**（经典版），采用 **BSD-2-Clause** 许可证。

项目定位为 **"Node.js dependency manager"**。

官方网站：https://yarnpkg.com/

Yarn v1（经典版）是目前使用最广泛的版本，以稳定性和向后兼容性著称。

Yarn 2+（Berry）是新一代版本，引入了 Plug'n'Play（PnP）等创新特性。

本指南主要介绍通过 Scoop 安装的 Yarn v1 经典版。

### 版本信息

| 项目       | 值                                    |
| ---------- | ------------------------------------- |
| 版本       | v1.22.19                              |
| 许可证     | BSD-2-Clause                          |
| 项目主页   | https://yarnpkg.com/                  |
| 可执行文件 | yarn.cmd                              |

### Yarn vs npm

与 npm 相比，Yarn 具有以下优势：

- **速度更快**：并行安装和本地缓存机制大幅提升安装速度
- **确定性安装**：yarn.lock 文件确保不同环境下安装相同的依赖版本
- **离线模式**：可以从本地缓存安装之前下载过的包
- **安全校验**：内置校验和验证，确保包的完整性
- **扁平化依赖**：减少重复依赖，优化 node_modules 结构

### Yarn v1 vs Yarn v2+

Yarn v1（经典版）：
- 使用 node_modules 目录存放依赖
- 与 npm 生态完全兼容
- 学习成本低，迁移成本小
- 已进入维护模式，不再添加新功能

Yarn v2+（Berry）：
- 默认使用 Plug'n'Play（PnP），不创建 node_modules
- 需要适配现有工具链
- 性能更优，磁盘占用更小
- 持续开发新功能

## 主要功能

### 依赖安装与管理

Yarn 的核心功能是安装和管理 Node.js 项目的依赖包。

支持从 npm 注册表安装超过百万个可用的 JavaScript 包。

支持安装指定版本、版本范围、Git 仓库或本地路径的依赖。

可以区分生产依赖（dependencies）和开发依赖（devDependencies）。

支持全局安装命令行工具和开发工具。

### 确定性安装

Yarn 通过 yarn.lock 文件实现确定性安装。

yarn.lock 文件记录了每个依赖包的精确版本号和下载地址。

无论在哪个环境下运行 `yarn install`，都会安装完全相同的依赖版本。

这保证了团队协作和部署环境中依赖的一致性。

### 离线安装

Yarn 维护了一个本地缓存目录，存储所有下载过的包。

如果某个包之前已下载过，再次安装时会直接从缓存读取，无需网络请求。

可以配置缓存目录的位置和大小。

支持在完全离线的环境下安装已缓存的依赖。

### 脚本执行

Yarn 支持执行 package.json 中定义的脚本命令。

通过 `yarn run <script>` 或简写的 `yarn <script>` 执行自定义脚本。

支持在脚本执行前后的钩子（pre/post）中插入自定义逻辑。

可以执行 node_modules 中安装的命令行工具。

### Workspaces（工作区）

Yarn 支持 monorepo（单仓库多项目）的管理方式。

通过 Workspaces 功能，可以在一个仓库中管理多个相互依赖的包。

Workspaces 会自动提升共同依赖到根目录的 node_modules，避免重复安装。

支持跨工作区的命令执行和依赖链接。

### 安全特性

Yarn 内置了包完整性校验机制。

安装时自动验证每个包的校验和（checksum），确保下载内容未被篡改。

支持使用 checksums 文件进行离线完整性校验。

支持自动审计已安装依赖中的已知安全漏洞。

### 版本管理

支持语义化版本（SemVer）的灵活指定。

可以使用精确版本、范围版本、波浪号（~）和脱字号（^）等语法。

`yarn upgrade` 命令可以将依赖升级到符合版本约束的最新版本。

`yarn outdated` 命令可以查看有可用更新的依赖。

## 常用操作

### 安装

通过 Scoop 安装 Yarn：

```powershell
scoop install yarn
```

安装完成后，`yarn` 命令会被添加到系统 PATH 中。

Yarn 需要 Node.js 运行环境，如果尚未安装 Node.js，Scoop 会提示安装。

### 初始化项目

在当前目录初始化一个新的 Node.js 项目：

```powershell
yarn init
```

按照提示填写项目信息（名称、版本、描述等），会自动生成 package.json 文件。

使用默认值快速初始化：

```powershell
yarn init -y
```

### 安装依赖

安装 package.json 中的所有依赖：

```powershell
yarn install
```

简写形式：

```powershell
yarn
```

安装并添加为生产依赖：

```powershell
yarn add <package-name>
```

安装并添加为开发依赖：

```powershell
yarn add <package-name> --dev
```

或简写：

```powershell
yarn add <package-name> -D
```

安装指定版本的包：

```powershell
yarn add <package-name>@1.2.3
```

安装指定版本范围的包：

```powershell
yarn add <package-name>@^2.0.0
```

安装 Git 仓库中的包：

```powershell
yarn add <package-name>@https://github.com/user/repo.git
```

### 移除依赖

移除生产依赖：

```powershell
yarn remove <package-name>
```

移除开发依赖：

```powershell
yarn remove <package-name>
```

Yarn 会自动更新 package.json 和 yarn.lock 文件。

### 升级依赖

升级所有依赖到符合版本约束的最新版本：

```powershell
yarn upgrade
```

升级指定包到最新版本：

```powershell
yarn upgrade <package-name>
```

升级指定包到指定版本：

```powershell
yarn upgrade <package-name>@^3.0.0
```

交互式升级（列出可升级的包供选择）：

```powershell
yarn upgrade-interactive
```

### 查看依赖

查看项目中已安装的依赖列表：

```powershell
yarn list
```

查看指定包的详细信息：

```powershell
yarn info <package-name>
```

查看指定包的当前版本：

```powershell
yarn list --pattern <package-name>
```

查看有可用更新的包：

```powershell
yarn outdated
```

### 运行脚本

执行 package.json 中定义的脚本：

```powershell
yarn run <script-name>
```

对于 start、test 等常用脚本，可以省略 `run`：

```powershell
yarn start
yarn test
yarn build
```

查看所有可用的脚本命令：

```powershell
yarn run
```

### 全局安装

全局安装命令行工具：

```powershell
yarn global add <package-name>
```

全局移除工具：

```powershell
yarn global remove <package-name>
```

查看全局安装的包列表：

```powershell
yarn global list
```

查看全局 bin 目录路径：

```powershell
yarn global bin
```

### 缓存管理

查看缓存目录位置：

```powershell
yarn cache dir
```

查看缓存中的包列表：

```powershell
yarn cache list
```

清理缓存：

```powershell
yarn cache clean
```

### 常用版本语法

| 语法     | 示例       | 说明                              |
| -------- | ---------- | --------------------------------- |
| 精确版本 | `1.2.3`    | 只安装指定版本                    |
| ^        | `^1.2.3`   | 允许同主版本号的更新（1.x.x）     |
| ~        | `~1.2.3`   | 允许同次版本号的更新（1.2.x）     |
| >=       | `>=1.2.3`  | 大于等于指定版本                  |
| *        | `*`        | 任意版本                          |
| latest   | `latest`   | 安装最新版本                      |

### 安全审计

检查已安装依赖中的安全漏洞：

```powershell
yarn audit
```

自动修复有安全更新的漏洞：

```powershell
yarn audit fix
```

## 常见问题

### yarn install 速度慢

**问题**：执行 `yarn install` 时下载速度非常慢。

**解决方法**：
- 配置国内镜像源：`yarn config set registry https://registry.npmmirror.com`
- 使用代理：设置 `HTTP_PROXY` 和 `HTTPS_PROXY` 环境变量
- 清理缓存后重试：`yarn cache clean && yarn install`
- 确认网络连接正常，尝试切换网络环境
- 对于大型项目，考虑使用 Workspaces 拆分依赖

### yarn.lock 冲突

**问题**：多人协作时 yarn.lock 文件频繁产生合并冲突。

**解决方法**：
- 使用 `git checkout --theirs yarn.lock` 然后重新运行 `yarn install`
- 避免手动编辑 yarn.lock 文件
- 团队成员统一使用相同版本的 Yarn
- 使用 `git diff yarn.lock` 了解变化原因
- 考虑使用 `.gitattributes` 设置合并策略

### 包安装后找不到

**问题**：安装包后在代码中 import 时报错找不到模块。

**解决方法**：
- 确认 node_modules 目录存在
- 运行 `yarn install` 重新安装
- 检查 import 路径是否正确
- 删除 node_modules 和 yarn.lock 后重新安装
- 确认包名拼写正确

### 权限问题

**问题**：全局安装包时提示权限不足。

**解决方法**：
- Scoop 安装的 Yarn 通常不会有权限问题
- 如遇到问题，检查全局 bin 目录的写入权限
- 使用 `yarn global bin` 查看全局安装目录
- 确认目录在 PATH 环境变量中

### node_modules 目录过大

**问题**：node_modules 目录占用大量磁盘空间。

**解决方法**：
- 检查是否存在重复依赖：`yarn dedupe`（Yarn v1 需要安装插件）
- 确认开发依赖不会进入生产环境
- 使用 `.yarnclean` 文件自动清理不需要的文件：

```
*.md
*.ts
!*.d.ts
docs
test
tests
example
```

### 网络超时

**问题**：安装过程中频繁超时。

**解决方法**：
- 增加网络超时时间：`yarn config set network-timeout 600000`
- 配置镜像源：`yarn config set registry https://registry.npmmirror.com`
- 使用 VPN 或代理
- 检查防火墙设置
- 重试安装命令

### 依赖版本不一致

**问题**：团队成员安装的依赖版本不一致。

**解决方法**：
- 确保 yarn.lock 文件提交到版本控制系统
- 不要手动编辑 yarn.lock 文件
- 统一 Yarn 版本
- 使用 `.yarnrc` 文件锁定注册表地址
- 定期运行 `yarn install --frozen-lockfile` 在 CI/CD 中验证

### 全局安装的命令找不到

**问题**：使用 `yarn global add` 安装的命令无法执行。

**解决方法**：
- 运行 `yarn global bin` 查看全局 bin 目录
- 确认该目录在系统 PATH 环境变量中
- 重新打开终端使 PATH 变更生效
- 如使用 Scoop，全局包通常会被正确链接

### 忽略不需要的文件

在项目根目录创建 `.yarnclean` 文件：

```powershell
yarn autoclean --init
```

编辑 `.yarnclean` 文件，添加要清理的文件模式：

```
__tests__
test
tests
*.test.js
*.spec.js
docs
documentation
```

## 相关资源

### 官方资源

- Yarn 官方网站：https://yarnpkg.com/
- Yarn 文档：https://classic.yarnpkg.com/en/docs
- Yarn GitHub 仓库：https://github.com/yarnpkg/yarn
- Yarn v2+ 文档：https://yarnpkg.com/getting-started
- 发布页面：https://github.com/yarnpkg/yarn/releases

### 配置参考

- Yarn CLI 命令参考：https://classic.yarnpkg.com/en/docs/cli/
- package.json 规范：https://docs.npmjs.com/cli/v10/configuring-npm/package-json
- 语义化版本规范：https://semver.org/
- npm 注册表：https://www.npmjs.com/

### 社区资源

- Yarn GitHub Issues：https://github.com/yarnpkg/yarn/issues
- Yarn RFCs：https://github.com/yarnpkg/rfcs
- Stack Overflow Yarn 标签：https://stackoverflow.com/questions/tagged/yarnpkg
- Scoop Main 仓库：https://github.com/ScoopInstaller/Main

### 学习资料

- Yarn 快速入门：https://classic.yarnpkg.com/en/docs/getting-started
- Yarn vs npm 对比：https://classic.yarnpkg.com/en/docs/migrating-from-npm
- Monorepo 最佳实践：https://classic.yarnpkg.com/en/docs/workspaces
- Yarn 安全最佳实践：https://classic.yarnpkg.com/en/docs/audit

### 相关工具推荐

- **npm**：Node.js 默认包管理器
- **pnpm**：高效的 Node.js 包管理器，使用硬链接和符号链接
- **npm-check-updates**：检查 package.json 中可升级的依赖
- **npx**：直接运行 node_modules 中的命令
- **Node.js**：Yarn 的运行时环境
