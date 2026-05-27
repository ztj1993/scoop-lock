# PuTTY 使用指南

## 简介

PuTTY 是一个免费的 SSH 和 Telnet 客户端，同时也是一个 xterm 终端模拟器。它最初由 Simon Tatham 开发，是 Windows 平台上最流行的 SSH 客户端之一。

**版本**: v0.84  
**许可证**: MIT  
**官方描述**: A free implementation of SSH and Telnet, along with an xterm terminal emulator  
**项目主页**: https://www.chiark.greenend.org.uk/~sgtatham/putty/

### 核心特性

- **SSH 客户端**: 支持 SSH-1 和 SSH-2 协议
- **Telnet 客户端**: 支持 Telnet 协议
- **串口连接**: 支持串口通信
- **密钥管理**: 提供密钥生成和管理工具
- **文件传输**: 支持 SCP 和 SFTP 文件传输
- **会话管理**: 支持保存和加载会话配置

## 主要功能

### 1. SSH 连接

PuTTY 提供了完整的 SSH 客户端功能：

- **SSH-1 和 SSH-2**: 支持两种 SSH 协议版本
- **密码认证**: 支持用户名/密码认证
- **公钥认证**: 支持 SSH 密钥认证
- **端口转发**: 支持本地和远程端口转发

### 2. Telnet 连接

PuTTY 支持 Telnet 协议：

- **标准 Telnet**: 支持标准 Telnet 连接
- **Rlogin**: 支持 Rlogin 协议
- **Raw 连接**: 支持原始 TCP 连接

### 3. 密钥管理

PuTTY 提供了完整的密钥管理工具：

- **密钥生成**: 生成 SSH 密钥对
- **密钥转换**: 在不同格式间转换密钥
- **密钥代理**: 管理已加载的密钥

### 4. 文件传输

PuTTY 支持安全的文件传输：

- **SCP**: 安全复制协议
- **SFTP**: SSH 文件传输协议
- **PSCP**: 命令行 SCP 客户端
- **PSFTP**: 命令行 SFTP 客户端

## 组件介绍

### 1. putty.exe - SSH/Telnet 客户端

PuTTY 的主程序，提供图形界面的 SSH 和 Telnet 客户端。

**主要功能**:
- 建立 SSH 连接
- 建立 Telnet 连接
- 串口连接
- 会话管理

### 2. puttygen.exe - 密钥生成器

PuTTY 密钥生成器，用于生成和管理 SSH 密钥。

**主要功能**:
- 生成 RSA、DSA、ECDSA、Ed25519 密钥
- 转换密钥格式（PPK、OpenSSH、SSH.com）
- 管理密钥注释和密码

### 3. pscp.exe - SCP 客户端

命令行 SCP 客户端，用于安全文件传输。

**主要功能**:
- 上传文件到远程服务器
- 从远程服务器下载文件
- 递归传输目录

### 4. pageant.exe - SSH 代理

PuTTY 的 SSH 代理，用于管理已加载的密钥。

**主要功能**:
- 加载私钥
- 管理多个密钥
- 为其他 PuTTY 工具提供密钥

### 5. psftp.exe - SFTP 客户端

命令行 SFTP 客户端，用于交互式文件传输。

**主要功能**:
- 交互式文件传输
- 目录浏览
- 文件权限管理

### 6. plink.exe - 命令行 SSH 客户端

PuTTY 的命令行 SSH 客户端。

**主要功能**:
- 命令行 SSH 连接
- 远程命令执行
- 脚本集成

## 常用操作

### SSH 连接

#### 使用图形界面连接

1. 启动 PuTTY
2. 输入主机名或 IP 地址
3. 输入端口号（默认 22）
4. 选择连接类型（SSH）
5. 点击"打开"

#### 使用命令行连接

```bash
# 基本连接
putty -ssh user@hostname

# 指定端口
putty -ssh user@hostname -P 22

# 使用密钥文件
putty -ssh user@hostname -i key.ppk

# 保存会话
putty -ssh user@hostname -load "MySession"
```

### 密钥生成

#### 使用 puttygen 生成密钥

1. 启动 puttygen
2. 选择密钥类型（RSA、Ed25519 等）
3. 设置密钥位数
4. 点击"生成"
5. 移动鼠标生成随机性
6. 设置密钥密码
7. 保存私钥（PPK 格式）
8. 复制公钥到服务器

#### 命令行生成密钥

```bash
# 生成 Ed25519 密钥
puttygen -t ed25519 -C "my-key" -O private -O public -o mykey.ppk

# 生成 RSA 密钥
puttygen -t rsa -b 4096 -C "my-key" -O private -O public -o mykey.ppk
```

### 文件传输

#### 使用 PSCP 传输文件

```bash
# 上传文件
pscp -P 22 localfile.txt user@hostname:/remote/path/

# 下载文件
pscp -P 22 user@hostname:/remote/file.txt localfile.txt

# 递归上传目录
pscp -r -P 22 localdir user@hostname:/remote/path/

# 使用密钥文件
pscp -i key.ppk -P 22 localfile.txt user@hostname:/remote/path/
```

#### 使用 PSFTP 传输文件

```bash
# 启动 PSFTP
psftp user@hostname

# 常用命令
psftp> lcd localdir          # 切换本地目录
psftp> cd remotedir          # 切换远程目录
psftp> put localfile.txt     # 上传文件
psftp> get remotefile.txt    # 下载文件
psftp> mput *.txt            # 批量上传
psftp> mget *.txt            # 批量下载
psftp> bye                   # 退出
```

### 会话管理

#### 保存会话

1. 配置连接参数
2. 输入会话名称
3. 点击"保存"

#### 加载会话

```bash
# 加载已保存的会话
putty -load "MySession"

# 命令行加载会话
plink -load "MySession"
```

### 端口转发

#### 本地端口转发

```bash
# 将本地端口 8080 转发到远程服务器的 80 端口
putty -ssh user@hostname -L 8080:localhost:80
```

#### 远程端口转发

```bash
# 将远程端口 8080 转发到本地的 80 端口
putty -ssh user@hostname -R 8080:localhost:80
```

#### 动态端口转发（SOCKS 代理）

```bash
# 创建 SOCKS 代理
putty -ssh user@hostname -D 1080
```

## 常见问题

### 1. 连接超时

**问题**: SSH 连接超时，无法建立连接。

**解决方案**:
1. 检查网络连接
2. 确认服务器 IP 和端口正确
3. 检查防火墙设置
4. 增加连接超时时间
5. 尝试使用其他网络

### 2. 认证失败

**问题**: 输入正确的用户名和密码后认证失败。

**解决方案**:
1. 检查用户名和密码是否正确
2. 确认服务器允许密码认证
3. 检查服务器 SSH 配置
4. 尝试使用密钥认证

### 3. 密钥认证失败

**问题**: 使用密钥文件连接时认证失败。

**解决方案**:
1. 确保密钥文件格式正确（PPK 格式）
2. 检查服务器上的公钥配置
3. 确保密钥文件权限正确
4. 检查服务器 SSH 配置是否允许密钥认证

### 4. 中文乱码

**问题**: 远程服务器上的中文显示为乱码。

**解决方案**:
1. 设置 PuTTY 字符编码为 UTF-8
2. 在会话设置中选择 UTF-8 编码
3. 确保远程服务器使用 UTF-8 编码
4. 设置合适的字体（如 SimSun、Microsoft YaHei）

### 5. 终端大小问题

**问题**: 终端窗口大小调整后显示异常。

**解决方案**:
1. 在 PuTTY 设置中启用"自动调整终端大小"
2. 手动设置终端行数和列数
3. 连接后执行 `stty rows <行数> columns <列数>`
4. 使用 `resize` 命令调整

### 6. 保持连接活跃

**问题**: SSH 连接长时间无操作后断开。

**解决方案**:
1. 在 PuTTY 设置中启用"保持连接活跃"
2. 设置保持连接的时间间隔
3. 使用 `tmux` 或 `screen` 保持会话
4. 配置服务器 SSH 超时设置

### 7. 文件传输权限问题

**问题**: 使用 PSCP 或 PSFTP 传输文件时权限不足。

**解决方案**:
1. 使用 root 用户或 sudo 权限
2. 检查目标目录权限
3. 使用 `-pw` 参数指定密码
4. 确保用户有写入权限

## 高级用法

### 自动化脚本

#### 使用 Plink 执行远程命令

```bash
# 执行单个命令
plink -ssh user@hostname -pw password "ls -la"

# 执行脚本
plink -ssh user@hostname -pw password -m script.sh

# 批量执行命令
echo "command1" > commands.txt
echo "command2" >> commands.txt
plink -ssh user@hostname -pw password -m commands.txt
```

#### 批量文件传输

```bash
# 上传多个文件
for file in *.txt; do
    pscp -pw password "$file" user@hostname:/remote/path/
done

# 下载多个文件
plink -ssh user@hostname -pw password "ls /remote/path/*.txt" | while read file; do
    pscp -pw password "user@hostname:$file" .
done
```

### SSH 隧道

#### 建立 SSH 隧道

```bash
# 本地端口转发
putty -ssh user@hostname -L 3306:database-server:3306

# 远程端口转发
putty -ssh user@hostname -R 8080:localhost:80

# 动态端口转发
putty -ssh user@hostname -D 1080
```

### 多跳连接

通过跳板机连接内网服务器：

```bash
# 使用 Plink 多跳连接
plink -ssh jumpuser@jumphost -L 2222:internalhost:22
putty -ssh user@localhost -P 2222
```

### 配置文件

#### PuTTY 配置文件位置

- **会话配置**: 注册表 `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions`
- **SSH 主机密钥**: 注册表 `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\SshHostKeys`

#### 导出配置

```bash
# 导出所有会话配置
regedit /e putty-sessions.reg HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions
```

## 最佳实践

### 1. 使用密钥认证

避免使用密码认证，使用 SSH 密钥更安全：

1. 生成强密钥（Ed25519 或 RSA 4096 位）
2. 设置密钥密码
3. 将公钥添加到服务器
4. 禁用服务器密码认证

### 2. 定期更新密钥

定期更换 SSH 密钥：

```bash
# 生成新密钥
puttygen -t ed25519 -C "new-key-$(date +%Y%m%d)" -O private -o newkey.ppk

# 更新服务器公钥
pscp -i oldkey.ppk newkey.pub user@hostname:~/.ssh/
```

### 3. 使用 SSH 代理

使用 Pageant 管理密钥：

1. 启动 Pageant
2. 添加私钥到 Pageant
3. 配置 PuTTY 使用 Pageant

### 4. 配置会话超时

合理配置会话超时：

- 设置保持连接活跃间隔（如 60 秒）
- 配置服务器 SSH 超时
- 使用 `tmux` 或 `screen` 保持会话

### 5. 安全配置

加强 SSH 安全：

- 使用强密码
- 限制 SSH 访问 IP
- 配置防火墙规则
- 定期更新 PuTTY

## 相关资源

### 官方资源

- **官方网站**: https://www.chiark.greenend.org.uk/~sgtatham/putty/
- **下载页面**: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
- **文档**: https://www.chiark.greenend.org.uk/~sgtatham/putty/docs.html
- **问题反馈**: https://www.chiark.greenend.org.uk/~sgtatham/putty/feedback.html

### 相关工具

- **WinSCP**: https://winscp.net/
- **MobaXterm**: https://mobaxterm.mobatek.net/
- **KiTTY**: http://www.9bis.net/kitty/
- **Bitvise SSH Client**: https://www.bitvise.com/

### SSH 资源

- **OpenSSH**: https://www.openssh.com/
- **SSH 官方文档**: https://www.ssh.com/ssh/
- **SSH 密钥管理**: https://www.ssh.com/academy/ssh/keygen

### 学习资源

- **SSH 教程**: https://www.ssh.com/academy/ssh
- **PuTTY 使用指南**: https://www.chiark.greenend.org.uk/~sgtatham/putty/docs.html
- **Linux 命令行教程**: https://linuxcommand.org/

## 更新日志

### v0.84

- 修复了多个安全漏洞
- 改进了 SSH 密钥交换算法
- 添加了对新加密算法的支持

### v0.83

- 改进了终端模拟器的兼容性
- 修复了文件传输的稳定性问题
- 添加了新的密钥类型支持

### v0.82

- 改进了 Windows 11 兼容性
- 修复了多个 bug
- 优化了性能

## 总结

PuTTY 是 Windows 平台上最流行的 SSH 客户端之一，它提供了：

- **SSH 连接**: 安全的远程服务器连接
- **密钥管理**: 完整的 SSH 密钥管理工具
- **文件传输**: 安全的文件传输功能
- **会话管理**: 灵活的会话配置管理

对于需要连接远程服务器的用户，PuTTY 是一个可靠的选择。