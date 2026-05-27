# Git 使用指南

## 简介

Git 是一个分布式版本控制系统，用于跟踪文件更改，协调多人开发。

**版本**: 2.47.1.2  
**官网**: https://gitforwindows.org  
**许可证**: GPL-2.0-only

## 主要功能

- 分布式版本控制
- 分支管理
- 代码合并
- 历史记录跟踪
- 离线工作支持

## 常用命令

### 基本配置

```bash
# 设置用户信息
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 设置默认编辑器
git config --global core.editor notepad++

# 设置凭证管理器
git config --global credential.helper manager

# 查看配置
git config --list
```

### 仓库操作

```bash
# 初始化新仓库
git init

# 克隆远程仓库
git clone https://github.com/user/repo.git

# 克隆到指定目录
git clone https://github.com/user/repo.git my-folder

# 克隆特定分支
git clone -b branch-name https://github.com/user/repo.git
```

### 基本工作流

```bash
# 查看状态
git status

# 添加文件到暂存区
git add filename.txt
git add .  # 添加所有更改

# 提交更改
git commit -m "Commit message"

# 查看提交历史
git log
git log --oneline  # 简洁模式
git log --graph    # 图形化显示

# 推送到远程
git push origin main

# 拉取远程更新
git pull origin main
```

### 分支管理

```bash
# 查看分支
git branch
git branch -a  # 查看所有分支

# 创建新分支
git branch feature-branch

# 切换分支
git checkout feature-branch

# 创建并切换分支
git checkout -b feature-branch

# 删除分支
git branch -d feature-branch

# 合并分支
git checkout main
git merge feature-branch
```

### 远程操作

```bash
# 查看远程仓库
git remote -v

# 添加远程仓库
git remote add origin https://github.com/user/repo.git

# 推送分支
git push -u origin main

# 拉取远程分支
git fetch origin
git checkout -b local-branch origin/remote-branch

# 删除远程分支
git push origin --delete branch-name
```

### 撤销操作

```bash
# 撤销工作区更改
git checkout -- filename.txt

# 撤销暂存区更改
git reset HEAD filename.txt

# 撤销最后一次提交（保留更改）
git reset --soft HEAD~1

# 撤销最后一次提交（丢弃更改）
git reset --hard HEAD~1

# 修改最后一次提交
git commit --amend
```

### 标签管理

```bash
# 查看标签
git tag

# 创建标签
git tag v1.0.0

# 创建带注释的标签
git tag -a v1.0.0 -m "Version 1.0.0"

# 推送标签到远程
git push origin v1.0.0
git push origin --tags  # 推送所有标签
```

### 暂存操作

```bash
# 暂存当前更改
git stash

# 查看暂存列表
git stash list

# 恢复暂存
git stash apply

# 恢复并删除暂存
git stash pop

# 删除暂存
git stash drop
```

### 比较差异

```bash
# 比较工作区和暂存区
git diff

# 比较暂存区和最新提交
git diff --cached

# 比较两个分支
git diff branch1 branch2

# 比较特定文件
git diff filename.txt
```

## 图形界面工具

### Git GUI

```bash
# 启动 Git GUI
git gui
```

### Gitk

```bash
# 启动 Gitk 查看历史
gitk
```

### Git Bash

```bash
# 启动 Git Bash
git-bash.exe
```

## 高级用法

### 变基操作

```bash
# 变基到主分支
git rebase main

# 交互式变基
git rebase -i HEAD~3

# 中止变基
git rebase --abort
```

### Cherry-pick

```bash
# 选择特定提交
git cherry-pick commit-hash

# 选择多个提交
git cherry-pick commit1 commit2
```

### 子模块

```bash
# 添加子模块
git submodule add https://github.com/user/repo.git path/to/submodule

# 初始化子模块
git submodule init

# 更新子模块
git submodule update

# 克隆包含子模块的仓库
git clone --recursive https://github.com/user/repo.git
```

### 大文件存储 (LFS)

```bash
# 安装 Git LFS
git lfs install

# 跟踪大文件
git lfs track "*.psd"

# 查看跟踪的文件
git lfs ls-files
```

## 工作流模式

### Git Flow

```bash
# 开始功能开发
git flow feature start new-feature

# 完成功能开发
git flow feature finish new-feature

# 开始发布
git flow release start v1.0.0

# 完成发布
git flow release finish v1.0.0
```

### GitHub Flow

```bash
# 创建功能分支
git checkout -b feature/new-feature

# 提交更改
git add .
git commit -m "Add new feature"

# 推送分支
git push origin feature/new-feature

# 创建 Pull Request（在 GitHub 网站上）

# 合并后删除分支
git checkout main
git pull
git branch -d feature/new-feature
```

## 常见问题

### 1. 如何解决合并冲突？

```bash
# 查看冲突文件
git status

# 手动编辑冲突文件，解决冲突后
git add resolved-file.txt
git commit -m "Resolve merge conflict"
```

### 2. 如何恢复删除的文件？

```bash
# 从最新提交恢复文件
git checkout HEAD -- filename.txt

# 从特定提交恢复文件
git checkout commit-hash -- filename.txt
```

### 3. 如何查看文件的修改历史？

```bash
# 查看文件的提交历史
git log filename.txt

# 查看文件的详细修改
git log -p filename.txt
```

### 4. 如何忽略文件？

创建 `.gitignore` 文件：

```
# 忽略所有 .log 文件
*.log

# 忽略 build 目录
build/

# 忽略特定文件
config.local.js

# 忽略所有 .txt 文件，但不包括 notes.txt
*.txt
!notes.txt
```

## 性能优化

### 浅克隆

```bash
# 浅克隆（只获取最新提交）
git clone --depth 1 https://github.com/user/repo.git
```

### 部分克隆

```bash
# 部分克隆（只克隆特定目录）
git clone --filter=blob:none --sparse https://github.com/user/repo.git
git sparse-checkout set dir1 dir2
```

## 脚本示例

### 自动部署脚本

```bash
#!/bin/bash
# 部署脚本

# 拉取最新代码
git pull origin main

# 安装依赖
npm install

# 构建项目
npm run build

# 重启服务
sudo systemctl restart my-app
```

### 批量操作脚本

```bash
#!/bin/bash
# 批量删除已合并的分支

git branch --merged main | grep -v "main" | xargs git branch -d
```

## 集成配置

### 添加右键菜单

```bash
# 添加 Git Bash 到右键菜单
reg import "$dir\install-context.reg"

# 添加文件关联
reg import "$dir\install-file-associations.reg"
```

## 相关资源

- [Git 官方文档](https://git-scm.com/doc)
- [Git 教程](https://www.liaoxuefeng.com/wiki/896043488029600)
- [Git Flow 工作流](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [GitHub 帮助](https://docs.github.com/en)