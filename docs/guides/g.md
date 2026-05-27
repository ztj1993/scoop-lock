# g - Go 版本管理器使用指南

## 简介

g 是一个命令行工具，用于方便地管理和切换多个 Go 语言环境版本。它类似于 Node.js 的 nvm，可以帮助开发者在同一台机器上安装和使用不同版本的 Go，并支持使用国内镜像加速下载。

**版本**: 1.8.0
**官网**: https://github.com/voidint/g
**许可证**: MIT
**类型**: 命令行工具
**可执行文件**: g.exe
**镜像**: G_MIRROR=https://mirrors.aliyun.com/golang/

## 主要功能

- 安装多个 Go 版本
- 快速切换 Go 版本
- 使用国内镜像加速下载
- 查看已安装版本列表
- 查看可用版本列表
- 设置默认 Go 版本
- 卸载指定版本
- 支持 Windows/Linux/macOS
- 自动配置环境变量
- 版本自动补全

## 安装

### 通过 Scoop 安装

```bash
scoop install g
```

### 验证安装

```bash
g --version
```

### 环境变量配置

```bash
# 设置镜像源（推荐使用阿里云镜像）
set G_MIRROR=https://mirrors.aliyun.com/golang/

# 设置 Go 安装根目录
set GOROOT=%USERPROFILE%\.g\go
set PATH=%GOROOT%\bin;%PATH%

# 设置 GOPATH
set GOPATH=%USERPROFILE%\go
set PATH=%GOPATH%\bin;%PATH%
```

## 基本用法

### 查看帮助

```bash
# 查看帮助信息
g --help

# 查看子命令帮助
g install --help
```

### 查看版本

```bash
# 查看 g 版本
g --version

# 查看当前 Go 版本
go version
```

## 版本管理

### 查看可用版本

```bash
# 查看所有可用的 Go 版本
g ls-remote

# 查看已安装的版本
g ls

# 查看当前使用的版本
g current
```

### 安装 Go 版本

```bash
# 安装指定版本
g install 1.21.0

# 安装最新稳定版
g install stable

# 安装最新测试版
g install tip

# 安装特定版本
g install go1.21.0
g install 1.20.7
```

### 切换版本

```bash
# 切换到指定版本
g use 1.21.0

# 切换到已安装的版本
g use 1.20.7
```

### 设置默认版本

```bash
# 设置默认版本
g default 1.21.0
```

### 卸载版本

```bash
# 卸载指定版本
g uninstall 1.20.7

# 卸载多个版本
g uninstall 1.19.13 1.20.7
```

## 版本列表

### 查看远程版本

```bash
# 查看所有可用版本
g ls-remote

# 输出示例
# go1.21.0
# go1.20.7
# go1.20.6
# go1.19.13
# ...
```

### 查看本地版本

```bash
# 查看已安装版本
g ls

# 输出示例
# * 1.21.0 (current)
#   1.20.7
#   1.19.13
```

### 版本信息

```bash
# 查看当前版本详细信息
g current

# 输出示例
# go version go1.21.0 windows/amd64
```

## 镜像配置

### 使用国内镜像

```bash
# 设置阿里云镜像
set G_MIRROR=https://mirrors.aliyun.com/golang/

# 设置七牛云镜像
set G_MIRROR=https://golang.google.cn/dl/

# 设置官方镜像
set G_MIRROR=https://go.dev/dl/
```

### 永久配置镜像

```bash
# Windows 系统环境变量
# 控制面板 -> 系统 -> 高级系统设置 -> 环境变量
# 添加系统变量:
# 变量名: G_MIRROR
# 变量值: https://mirrors.aliyun.com/golang/

# PowerShell 配置
[Environment]::SetEnvironmentVariable("G_MIRROR", "https://mirrors.aliyun.com/golang/", "User")
```

### 常用镜像源

```
阿里云:    https://mirrors.aliyun.com/golang/
七牛云:    https://golang.google.cn/dl/
官方:      https://go.dev/dl/
```

## 环境变量

### 相关环境变量

```
GOROOT      Go 安装目录
GOPATH      Go 工作目录
GOPROXY     Go 模块代理
GONOSUMDB   不使用校验的模块
GONOPROXY   不使用代理的模块
GOSUMDB     校验数据库
G_MIRROR    g 下载镜像地址
```

### 配置环境变量

```bash
# 设置 GOROOT
set GOROOT=%USERPROFILE%\.g\go

# 设置 GOPATH
set GOPATH=%USERPROFILE%\go

# 设置 GOPROXY（推荐）
set GOPROXY=https://goproxy.cn,direct

# 添加到 PATH
set PATH=%GOROOT%\bin;%GOPATH%\bin;%PATH%
```

### 持久化配置

```bash
# Windows 持久化环境变量
setx GOROOT "%USERPROFILE%\.g\go"
setx GOPATH "%USERPROFILE%\go"
setx GOPROXY "https://goproxy.cn,direct"
setx G_MIRROR "https://mirrors.aliyun.com/golang/"

# 更新 PATH
setx PATH "%GOROOT%\bin;%GOPATH%\bin;%PATH%"
```

## 使用场景

### 多版本开发

```bash
# 项目 A 需要 Go 1.21
cd project-a
g use 1.21.0
go build .

# 项目 B 需要 Go 1.20
cd project-b
g use 1.20.7
go build .
```

### 版本测试

```bash
# 测试不同版本兼容性
g use 1.21.0
go test ./...

g use 1.20.7
go test ./...

g use 1.19.13
go test ./...
```

### CI/CD 集成

```yaml
# GitHub Actions 示例
- name: Setup Go
  run: |
    g install ${{ matrix.go-version }}
    g use ${{ matrix.go-version }}
```

### 快速切换

```bash
# 切换到最新版
g install stable
g use stable

# 切换到特定版本
g use 1.21.0

# 切换回默认版本
g default 1.21.0
```

## 高级用法

### 批量操作

```bash
# 安装多个版本
g install 1.21.0 1.20.7 1.19.13

# 卸载多个版本
g uninstall 1.19.12 1.19.11
```

### 版本号格式

```bash
# 支持的版本号格式
g install 1.21.0        # 完整版本号
g install go1.21.0      # 带前缀
g install 1.21          # 主版本号
g install stable        # 最新稳定版
g install tip           # 开发版
```

### 自动补全

```bash
# Bash 自动补全
source <(g completion bash)

# Zsh 自动补全
source <(g completion zsh)

# PowerShell 自动补全
g completion powershell | Out-String | Invoke-Expression
```

### 脚本集成

```bash
# 在脚本中使用
#!/bin/bash

# 安装并使用指定版本
g install 1.21.0
g use 1.21.0

# 验证版本
go version

# 运行测试
go test ./...
```

## 配置文件

### 配置文件位置

```
Windows: %USERPROFILE%\.g\config
Linux: ~/.g/config
```

### 配置文件内容

```ini
# 镜像地址
mirror=https://mirrors.aliyun.com/golang/

# 默认版本
default=1.21.0

# Go 安装目录
install_dir=~/.g/go
```

## 常见问题

### 1. 下载速度慢

```
可能原因:
- 使用官方源
- 网络连接问题

解决方法:
1. 设置国内镜像
   set G_MIRROR=https://mirrors.aliyun.com/golang/

2. 使用代理
   set HTTP_PROXY=http://proxy:8080
   set HTTPS_PROXY=http://proxy:8080

3. 检查网络连接
```

### 2. 版本切换失败

```
可能原因:
- 版本未安装
- 环境变量未更新
- 权限问题

解决方法:
1. 确认版本已安装: g ls
2. 重新打开终端
3. 手动设置环境变量
4. 以管理员权限运行
```

### 3. go 命令未找到

```
可能原因:
- 环境变量未配置
- GOROOT 未设置
- PATH 未包含 Go bin 目录

解决方法:
1. 检查 GOROOT 设置
2. 检查 PATH 配置
3. 重新配置环境变量
4. 重启终端或注销重新登录
```

### 4. 安装版本失败

```
可能原因:
- 版本号错误
- 磁盘空间不足
- 网络连接问题

解决方法:
1. 检查版本号格式
2. 清理磁盘空间
3. 检查网络连接
4. 尝试其他镜像源
```

### 5. 环境变量不生效

```
可能原因:
- 未重启终端
- 配置文件未加载
- 环境变量设置错误

解决方法:
1. 重启终端
2. 重新登录系统
3. 手动 source 配置文件
4. 检查环境变量设置
```

### 6. 无法安装特定版本

```
可能原因:
- 版本不存在
- 平台不支持
- 镜像未同步

解决方法:
1. 使用 g ls-remote 查看可用版本
2. 检查平台兼容性
3. 更换镜像源
4. 等待镜像同步
```

## 与其他工具对比

### g vs nvm (Node.js)

```
功能对比:
- g: 管理 Go 版本
- nvm: 管理 Node.js 版本

命令对比:
g install 1.21.0    <-> nvm install 18.0.0
g use 1.21.0        <-> nvm use 18.0.0
g ls                <-> nvm ls
g ls-remote         <-> nvm ls-remote
```

### g vs goenv

```
g 优势:
- 更简单的命令
- 国内镜像支持
- 更快的安装速度

goenv 优势:
- 更多的配置选项
- 更好的插件支持
- 更成熟的社区
```

## 最佳实践

### 版本管理策略

```
1. 使用语义化版本号
2. 定期更新到最新稳定版
3. 为每个项目指定 Go 版本
4. 使用 go.mod 管理依赖版本
```

### 环境配置

```
1. 设置国内镜像加速下载
2. 配置 GOPROXY 加速模块下载
3. 使用 go.mod 管理项目依赖
4. 定期清理旧版本
```

### 团队协作

```
1. 统一团队 Go 版本
2. 在 go.mod 中指定版本
3. 提供安装脚本
4. 文档化版本要求
```

## 故障排除

### 诊断命令

```bash
# 检查 g 状态
g --version
g current
g ls

# 检查 Go 环境
go version
go env

# 检查环境变量
echo %GOROOT%
echo %GOPATH%
echo %GOPROXY%
```

### 重置配置

```bash
# 删除配置文件
del %USERPROFILE%\.g\config

# 重新配置
set G_MIRROR=https://mirrors.aliyun.com/golang/
g default 1.21.0
```

### 清理缓存

```bash
# 清理下载缓存
g clean

# 手动清理
del /s /q %USERPROFILE%\.g\archives\*
```

## 脚本示例

### 批量安装脚本

```bash
#!/bin/bash
# install-go-versions.sh

# 设置镜像
export G_MIRROR=https://mirrors.aliyun.com/golang/

# 安装版本列表
VERSIONS=(
    "1.21.0"
    "1.20.7"
    "1.19.13"
)

# 批量安装
for version in "${VERSIONS[@]}"; do
    echo "Installing Go $version..."
    g install "$version"
done

# 设置默认版本
g default 1.21.0

# 显示已安装版本
echo "Installed versions:"
g ls
```

### 版本切换脚本

```bash
#!/bin/bash
# switch-go-version.sh

# 检查参数
if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.21.0"
    exit 1
fi

# 切换版本
g use "$1"

# 验证
echo "Switched to:"
go version
```

### 环境初始化脚本

```batch
@echo off
REM setup-go-env.bat

REM 设置镜像
set G_MIRROR=https://mirrors.aliyun.com/golang/

REM 安装默认版本
g install stable

REM 设置默认版本
g default stable

REM 配置环境变量
setx GOROOT "%USERPROFILE%\.g\go"
setx GOPATH "%USERPROFILE%\go"
setx GOPROXY "https://goproxy.cn,direct"
setx G_MIRROR "https://mirrors.aliyun.com/golang/"

echo Go environment setup complete!
```

## 项目配置

### go.mod 文件

```go
module myproject

go 1.21

require (
    github.com/example/pkg v1.0.0
)
```

### .go-version 文件

```
1.21.0
```

### Makefile 集成

```makefile
GO_VERSION := 1.21.0

.PHONY: setup
setup:
	g install $(GO_VERSION)
	g use $(GO_VERSION)
	go mod tidy

.PHONY: build
build:
	go build -o bin/app ./cmd/app

.PHONY: test
test:
	go test ./...
```

## IDE 集成

### VS Code 配置

```json
{
    "go.goroot": "${userHome}/.g/go",
    "go.gopath": "${userHome}/go",
    "go.goproxy": "https://goproxy.cn,direct"
}
```

### GoLand 配置

```
1. 打开 Settings -> Go -> GOROOT
2. 设置路径: C:\Users\<username>\.g\go
3. 打开 Settings -> Go -> GOPATH
4. 设置路径: C:\Users\<username>\go
```

## 相关资源

- [g GitHub](https://github.com/voidint/g)
- [g 文档](https://github.com/voidint/g/blob/master/README.md)
- [Go 官网](https://go.dev/)
- [Go 下载](https://go.dev/dl/)
- [Go 文档](https://go.dev/doc/)
- [Go 模块代理](https://goproxy.cn/)
- [阿里云 Go 镜像](https://mirrors.aliyun.com/golang/)
