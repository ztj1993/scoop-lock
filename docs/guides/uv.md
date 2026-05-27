# uv - 极速 Python 包管理工具使用指南

## 简介

uv 是一款由 Rust 编写的超高速 Python 包安装器和解析器，由 Astral 团队开发维护。

它旨在成为 pip、pip-tools 和 virtualenv 的高性能替代方案，提供极致的安装速度和依赖解析能力。

uv 通过并行下载、智能缓存和高效的依赖解析算法，将包安装速度提升 10-100 倍。

### 基本信息

| 项目 | 详情 |
|------|------|
| 版本 | v0.11.7 |
| 许可证 | Apache-2.0 / MIT 双许可 |
| 开发语言 | Rust |
| 官方主页 | https://docs.astral.sh/uv/ |
| 支持平台 | Windows (64bit/32bit/ARM64), macOS, Linux |

### 可执行文件

安装后包含以下可执行文件：

- `uv.exe` - 主程序，用于包管理和虚拟环境操作
- `uvx.exe` - 用于直接运行 Python 工具/脚本
- `uvw.exe` - Windows 专用包装器

## 主要功能

### 1. 极速包安装

uv 的核心优势是其惊人的安装速度：

- 并行下载和安装依赖包
- 全局缓存机制减少重复下载
- 高效的依赖解析算法
- 支持增量更新

### 2. 虚拟环境管理

uv 提供完整的虚拟环境管理功能：

- 快速创建虚拟环境
- 支持指定 Python 版本
- 自动检测和使用项目虚拟环境
- 兼容标准 venv 目录结构

### 3. 依赖管理

全面的依赖管理能力：

- 从 requirements.txt 安装
- 支持 pyproject.toml 项目配置
- 依赖锁定文件生成和同步
- 支持 extras 和可选依赖

### 4. Python 版本管理

内置 Python 版本管理功能：

- 自动下载和安装 Python 解释器
- 支持多版本并行管理
- 项目级别的 Python 版本锁定

### 5. 工具运行

通过 uvx 命令直接运行 Python 工具：

- 无需安装即可运行 CLI 工具
- 自动创建临时隔离环境
- 支持指定工具版本

## 常用命令

### 包安装命令

安装单个包：
```
uv pip install requests
```

安装多个包：
```
uv pip install requests flask django
```

从 requirements.txt 安装：
```
uv pip install -r requirements.txt
```

安装指定版本：
```
uv pip install requests==2.31.0
```

安装带有 extras 的包：
```
uv pip install "requests[security]"
```

升级包：
```
uv pip install --upgrade requests
```

### 包卸载命令

卸载单个包：
```
uv pip uninstall requests
```

批量卸载：
```
uv pip uninstall -r requirements.txt
```

### 包列表和查询

列出已安装的包：
```
uv pip list
```

显示包详细信息：
```
uv pip show requests
```

检查过期的包：
```
uv pip list --outdated
```

### 虚拟环境命令

创建虚拟环境：
```
uv venv
```

创建指定名称的虚拟环境：
```
uv venv myenv
```

创建指定 Python 版本的虚拟环境：
```
uv venv --python 3.11
```

### 依赖锁定

生成锁文件：
```
uv pip compile requirements.in -o requirements.txt
```

同步环境：
```
uv pip sync requirements.txt
```

### 工具运行命令

使用 uvx 运行工具：
```
uvx ruff check .
```

运行指定版本的工具：
```
uvx ruff@0.1.0 check .
```

运行后自动清理：
```
uvx --isolated ruff check .
```

### Python 版本管理

查看可用的 Python 版本：
```
uv python list
```

安装指定版本的 Python：
```
uv python install 3.11
```

固定项目使用的 Python 版本：
```
uv python pin 3.11
```

### 缓存管理

查看缓存目录大小：
```
uv cache dir
```

清理缓存：
```
uv cache clean
```

清理指定包的缓存：
```
uv cache clean requests
```

## 配置说明

### 环境变量

uv 支持通过环境变量进行配置：

- `UV_INDEX_URL` - 设置 PyPI 镜像源
- `UV_EXTRA_INDEX_URL` - 设置额外的索引源
- `UV_CACHE_DIR` - 设置缓存目录
- `UV_PYTHON` - 设置默认 Python 解释器路径

### 配置文件

uv 支持以下配置文件位置：

系统级配置：
- Windows: `%APPDATA%\uv\uv.toml`
- Linux/macOS: `~/.config/uv/uv.toml`

项目级配置：
- `pyproject.toml` 中的 `[tool.uv]` 部分

### 常用配置示例

设置国内镜像源（在 pyproject.toml 中）：
```toml
[tool.uv]
index-url = "https://pypi.tuna.tsinghua.edu.cn/simple"
```

配置 pip 兼容选项：
```toml
[tool.uv.pip]
index-url = "https://pypi.tuna.tsinghua.edu.cn/simple"
trusted-host = ["pypi.tuna.tsinghua.edu.cn"]
```

## 高级用法

### 项目工作流

初始化新项目：
```
uv init myproject
cd myproject
```

添加依赖到项目：
```
uv add requests
uv add pytest --dev
```

移除依赖：
```
uv remove requests
```

安装项目及其所有依赖：
```
uv pip install -e .
```

### 依赖解析策略

使用最低版本解析：
```
uv pip install --resolution lowest requests
```

使用最高版本解析（默认）：
```
uv pip install --resolution highest requests
```

### 导出依赖

导出当前环境的依赖列表：
```
uv pip freeze > requirements.txt
```

从 pyproject.toml 导出：
```
uv pip compile pyproject.toml -o requirements.txt
```

### 跨平台支持

生成跨平台锁文件：
```
uv pip compile --universal requirements.in
```

指定目标平台：
```
uv pip install --python-platform linux requests
```

## 常见问题

### 1. 安装速度慢怎么办？

解决方案：
- 检查网络连接
- 配置国内镜像源（清华源、阿里源等）
- 确保缓存功能已启用
- 检查防火墙设置

### 2. 依赖冲突如何处理？

处理步骤：
1. 使用 `uv pip check` 检查依赖冲突
2. 查看冲突的具体包和版本要求
3. 使用 `--resolution` 参数调整解析策略
4. 必要时手动指定兼容的版本

### 3. 如何从 pip 迁移到 uv？

迁移步骤：
1. 使用 `uv pip install -r requirements.txt` 安装现有依赖
2. 将常用 pip 命令替换为 uv 对应命令
3. pip install → uv pip install
4. pip uninstall → uv pip uninstall
5. pip freeze → uv pip freeze
6. virtualenv → uv venv

### 4. 缓存占用空间过大怎么办？

清理方法：
```
uv cache clean
```

或设置缓存大小限制：
```
UV_CACHE_SIZE_LIMIT=1GB uv pip install requests
```

### 5. 如何使用私有 PyPI 仓库？

配置方法：
```
uv pip install --index-url https://private.pypi.org/simple/ mypackage
```

或在配置文件中设置默认源。

### 6. uv 和 pip 可以同时使用吗？

可以。uv 完全兼容 pip 的行为，可以与 pip 共存。但建议在项目中统一使用一种工具以避免混淆。

### 7. 支持哪些 Python 版本？

uv 支持 Python 3.7 及以上版本。对于更早的 Python 版本，可能需要使用其他工具。

### 8. 如何查看 uv 的版本信息？

```
uv --version
```

或查看详细版本信息：
```
uv version --output-format json
```

## 相关资源

### 官方资源

- 官方文档：https://docs.astral.sh/uv/
- GitHub 仓库：https://github.com/astral-sh/uv
- PyPI 页面：https://pypi.org/project/uv/
- 发布日志：https://github.com/astral-sh/uv/blob/main/CHANGELOG.md

### 社区资源

- Astral 博客：https://astral.sh/blog
- Discord 社区：https://discord.gg/astral-sh
- Stack Overflow 标签：https://stackoverflow.com/questions/tagged/uv

### 相关工具

- Ruff - 由同一团队开发的 Python 代码检查工具
- pip - Python 官方包管理器
- Poetry - Python 依赖管理和打包工具
- PDM - 现代 Python 包管理器

### 学习资源

- uv 快速入门指南：https://docs.astral.sh/uv/getting-started/
- 从 pip 迁移指南：https://docs.astral.sh/uv/pip/migration/
- 项目工作流指南：https://docs.astral.sh/uv/projects/
- Python 版本管理：https://docs.astral.sh/uv/python-versions/

### 镜像源配置

国内常用 PyPI 镜像源：

- 清华大学：https://pypi.tuna.tsinghua.edu.cn/simple
- 阿里云：https://mirrors.aliyun.com/pypi/simple
- 豆瓣：https://pypi.douban.com/simple
- 中科大：https://pypi.mirrors.ustc.edu.cn/simple

配置命令示例：
```
uv pip install --index-url https://pypi.tuna.tsinghua.edu.cn/simple requests
```

## 版本历史

### v0.11.7 主要更新

- 修复了若干依赖解析问题
- 改进了 Windows 平台兼容性
- 优化了缓存管理性能
- 增加了更多 Python 版本支持

### 其他重要版本

- v0.10.0 - 引入项目管理功能
- v0.9.0 - 添加 Python 版本管理
- v0.8.0 - 改进依赖解析算法
- v0.7.0 - 增加 uvx 工具运行功能

## 最佳实践

### 1. 项目初始化

推荐使用 uv 管理项目依赖：
```
uv init
uv add requests flask
uv add pytest ruff --dev
```

### 2. CI/CD 集成

在 CI/CD 流水线中使用 uv 加速构建：
```
uv pip install -r requirements.txt --system
```

### 3. Docker 集成

在 Dockerfile 中使用 uv：
```dockerfile
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv
uv pip install -r requirements.txt
```

### 4. 依赖锁定

定期更新锁文件确保可重复构建：
```
uv pip compile requirements.in -o requirements.txt
```

### 5. 安全审计

定期检查依赖安全性：
```
uv pip audit
```

## 总结

uv 是一个革命性的 Python 包管理工具，它将 Rust 的高性能带入 Python 生态系统。

通过使用 uv，开发者可以显著减少包安装和依赖解析的等待时间，提高开发效率。

无论是个人项目还是企业级应用，uv 都能提供卓越的性能和可靠的依赖管理能力。
