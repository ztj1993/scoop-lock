# 常用运行时安装指南

本文档介绍如何通过本 bucket 安装和管理常用编程语言运行时。

## Python

使用 `uv` 管理 Python 版本：

```powershell
scoop install uv

uv python install 3.8
uv python install 3.13

python3.8 --version
python3.13 --version
```

## Go

使用 `g` 管理 Go 版本：

```powershell
scoop install g

g install 1.18
g install 1.23
g use 1.23

go version
```

## Node.js

使用 `nvm` 管理 Node.js 版本：

```powershell
scoop install nvm

nvm install lts
nvm use lts

node --version
```
