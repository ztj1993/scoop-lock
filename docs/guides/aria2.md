# aria2 使用指南

## 简介

aria2 是一个轻量级的多协议、多来源命令行下载实用程序。它支持 HTTP/HTTPS、FTP、SFTP、BitTorrent 和 Metalink。

**版本**: 1.37.0  
**官网**: https://aria2.github.io/  
**许可证**: GPL-2.0-only

## 主要功能

- 多协议支持：HTTP/HTTPS, FTP, SFTP, BitTorrent, Metalink
- 多连接下载：通过多个连接下载同一文件以加速下载
- 断点续传：支持暂停和恢复下载
- BitTorrent 支持：DHT, PEX, 加密, Magnet URI
- Metalink 支持：P2P 文件下载
- JSON-RPC 和 XML-RPC 接口

## 常用命令

### 基本下载

```bash
# 下载单个文件
aria2c https://example.com/file.zip

# 下载到指定目录
aria2c -d /path/to/downloads https://example.com/file.zip

# 下载并重命名
aria2c -o newname.zip https://example.com/file.zip

# 从文件列表下载
aria2c -i urls.txt
```

### 多连接下载

```bash
# 使用多个连接下载（默认4个）
aria2c -x 16 https://example.com/file.zip

# 设置每个服务器的连接数
aria2c -j 3 -x 16 https://example.com/file.zip

# 设置同时下载数
aria2c -j 5 -i urls.txt
```

### 断点续传

```bash
# 继续未完成的下载
aria2c -c https://example.com/file.zip

# 强制继续下载
aria2c -c --allow-overwrite=true https://example.com/file.zip
```

### 限速下载

```bash
# 限制下载速度（KB/s）
aria2c --max-download-limit=500K https://example.com/file.zip

# 限制上传速度（用于BT下载）
aria2c --max-upload-limit=100K torrent-file.torrent
```

### FTP 下载

```bash
# FTP 下载
aria2c ftp://ftp.example.com/file.zip

# 带用户名密码的 FTP 下载
aria2c --ftp-user=username --ftp-passwd=password ftp://ftp.example.com/file.zip
```

### BitTorrent 下载

```bash
# 从 .torrent 文件下载
aria2c file.torrent

# 从 Magnet 链接下载
aria2c "magnet:?xt=urn:btih:hash值"

# 指定下载目录
aria2c -d /path/to/downloads file.torrent

# 限制上传速度
aria2c --max-upload-limit=100K file.torrent
```

### Metalink 下载

```bash
# 从 Metalink 文件下载
aria2c file.metalink

# 从 HTTP Metalink 下载
aria2c https://example.com/file.metalink
```

## 配置文件

### 默认配置文件位置

- Windows: `%APPDATA%\aria2\aria2.conf`
- Linux: `~/.aria2/aria2.conf`

### 常用配置选项

```ini
# 下载目录
dir=C:\Downloads

# 日志文件
log=aria2.log

# 日志级别（debug, info, notice, warn, error）
log-level=warn

# 最大同时下载任务数
max-concurrent-downloads=5

# 每个服务器最大连接数
max-connection-per-server=16

# 最小文件分片大小
min-split-size=1M

# 分片大小
split=5

# 断点续传
continue=true

# 文件分配方法
file-allocation=falloc

# 最大重试次数
max-tries=5

# 重试等待时间
retry-wait=3

# 超时时间
timeout=60

# 连接超时
connect-timeout=60

# 最大下载速度（0为无限制）
max-overall-download-limit=0

# 单任务最大下载速度
max-download-limit=0

# 最大上传速度
max-overall-upload-limit=1M

# BT 相关设置
bt-max-peers=50
bt-request-peer-speed-limit=50K
bt-tracker=udp://tracker.opentrackr.org:1337/announce

# HTTP/HTTPS 代理
# http-proxy=http://proxy:8080
# https-proxy=http://proxy:8080

# 用户代理
user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36

# 启用 RPC
enable-rpc=true
rpc-listen-all=true
rpc-listen-port=6800
rpc-secret=your-secret

# 禁用 IPv6
disable-ipv6=true

# 文件分配方法
file-allocation=falloc

# 磁盘缓存
disk-cache=64M

# 异步 DNS
async-dns=true

# 最大文件数
max-file-limit=1000
```

## JSON-RPC 接口

### 启动 RPC 服务

```bash
# 启动 aria2 并启用 RPC
aria2c --enable-rpc --rpc-listen-all=true --rpc-listen-port=6800

# 使用配置文件启动
aria2c --conf-path=aria2.conf
```

### RPC 调用示例

```bash
# 添加下载任务
curl -X POST http://localhost:6800/jsonrpc -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"1","method":"aria2.addUri","params":["token:your-secret",["https://example.com/file.zip"]]}'

# 获取下载状态
curl -X POST http://localhost:6800/jsonrpc -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"1","method":"aria2.tellStatus","params":["token:your-secret","下载GID"]}'

# 暂停下载
curl -X POST http://localhost:6800/jsonrpc -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"1","method":"aria2.pause","params":["token:your-secret","下载GID"]}'

# 继续下载
curl -X POST http://localhost:6800/jsonrpc -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"1","method":"aria2.unpause","params":["token:your-secret","下载GID"]}'

# 删除下载
curl -X POST http://localhost:6800/jsonrpc -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":"1","method":"aria2.remove","params":["token:your-secret","下载GID"]}'
```

## 图形界面工具

### WebUI-Aria2

```bash
# 下载 WebUI
git clone https://github.com/nickolaev/webui-aria2.git

# 启动 WebUI
# 在浏览器中打开 index.html
```

### AriaNg

```bash
# 下载 AriaNg
# 从 https://github.com/mayswind/AriaNg/releases 下载

# 解压后打开 index.html
```

## 高级用法

### 批量下载

```bash
# 创建 URL 列表文件 urls.txt
# https://example.com/file1.zip
# https://example.com/file2.zip
# https://example.com/file3.zip

# 批量下载
aria2c -i urls.txt

# 使用通配符
aria2c https://example.com/file{1..10}.zip
```

### 下载后执行命令

```bash
# 下载完成后执行脚本
aria2c --on-download-complete=script.sh https://example.com/file.zip

# 下载失败时执行脚本
aria2c --on-download-error=script.sh https://example.com/file.zip
```

### 使用代理

```bash
# HTTP 代理
aria2c --http-proxy=http://proxy:8080 https://example.com/file.zip

# HTTPS 代理
aria2c --https-proxy=http://proxy:8080 https://example.com/file.zip

# SOCKS 代理
aria2c --all-proxy=socks5://proxy:1080 https://example.com/file.zip
```

### 镜像下载

```bash
# 使用多个镜像下载
aria2c https://mirror1.example.com/file.zip https://mirror2.example.com/file.zip

# 从文件读取镜像
aria2c -M mirrors.txt
```

## 常见问题

### 1. 如何提高下载速度？

```bash
# 增加连接数
aria2c -x 16 -j 3 https://example.com/file.zip

# 使用分片下载
aria2c -s 16 https://example.com/file.zip
```

### 2. 如何恢复中断的下载？

```bash
# 使用 -c 参数
aria2c -c https://example.com/file.zip
```

### 3. 如何下载需要登录的文件？

```bash
# 使用 HTTP 头
aria2c --header="Cookie: session=abc123" https://example.com/file.zip

# 使用用户名密码
aria2c --http-user=username --http-passwd=password https://example.com/file.zip
```

### 4. 如何设置下载完成后关机？

```bash
# 下载完成后关机
aria2c --on-download-complete=shutdown.sh https://example.com/file.zip
```

## 脚本示例

### 自动下载脚本

```bash
#!/bin/bash
# 自动下载脚本

# 设置下载目录
DOWNLOAD_DIR="/downloads"

# 下载文件
aria2c -d "$DOWNLOAD_DIR" -x 16 -s 16 "$1"

# 检查下载结果
if [ $? -eq 0 ]; then
    echo "下载成功: $1"
else
    echo "下载失败: $1"
fi
```

### 批量下载脚本

```bash
#!/bin/bash
# 批量下载脚本

# URL 列表文件
URL_FILE="urls.txt"

# 下载目录
DOWNLOAD_DIR="/downloads"

# 读取 URL 列表并下载
while IFS= read -r url; do
    if [[ ! -z "$url" && ! "$url" =~ ^# ]]; then
        echo "正在下载: $url"
        aria2c -d "$DOWNLOAD_DIR" -x 16 "$url"
    fi
done < "$URL_FILE"
```

## 系统集成

### Windows 服务

```bash
# 使用 NSSM 将 aria2 注册为服务
nssm install aria2 "C:\path\to\aria2c.exe" "--conf-path=C:\path\to\aria2.conf"
nssm start aria2
```

### 开机自启

```bash
# 创建启动脚本
# 将以下内容添加到启动文件夹
aria2c --conf-path=aria2.conf --daemon
```

## 相关资源

- [aria2 官方文档](https://aria2.github.io/manual/en/html/aria2c.html)
- [aria2 配置示例](https://aria2.github.io/manual/en/html/aria2c.html#options)
- [WebUI-Aria2](https://github.com/nickolaev/webui-aria2)
- [AriaNg](https://github.com/mayswind/AriaNg)