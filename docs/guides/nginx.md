# Nginx 使用指南

> 版本：v1.23.4 | 许可证：BSD-2-Clause | 官网：https://nginx.org

---

## 简介

Nginx（发音为 "engine-x"）是一款高性能的 HTTP 和反向代理服务器，同时也是一个 IMAP/POP3 邮件代理服务器和通用的 TCP/UDP 代理服务器。Nginx 以其高并发处理能力、低内存消耗和丰富的功能而闻名，是全球最流行的 Web 服务器之一。

Nginx 由 Igor Sysoev 于 2004 年创建，采用事件驱动的异步架构，能够以极低的资源消耗处理大量并发连接，特别适合高流量网站和应用。

### 核心特性

- **高并发**：事件驱动架构，支持数万并发连接
- **低内存**：内存占用远低于传统 Web 服务器
- **反向代理**：支持 HTTP、HTTPS、FastCGI、uWSGI、SCGI 协议
- **负载均衡**：支持多种负载均衡算法
- **静态文件服务**：高效的静态文件处理能力
- **SSL/TLS**：完整的 HTTPS 支持
- **URL 重写**：灵活的 rewrite 规则
- **缓存**：代理缓存和 FastCGI 缓存
- **模块化**：丰富的第三方模块扩展

### 与其他服务器对比

| 特性 | Nginx | Apache | IIS |
|------|-------|--------|-----|
| 并发模型 | 事件驱动 | 进程/线程 | 线程池 |
| 内存占用 | 低 | 中高 | 中 |
| 静态文件 | 极快 | 快 | 快 |
| 动态内容 | 通过 FastCGI | 内置模块 | 内置模块 |
| 配置方式 | 集中式 | .htaccess | GUI |
| 平台支持 | 跨平台 | 跨平台 | Windows |

### 适用场景

- 静态网站托管
- 反向代理和负载均衡
- API 网关
- 微服务架构入口
- SSL/TLS 终止
- 视频流媒体服务
- 邮件代理

---

## 主要功能

### 1. HTTP 服务器

作为 HTTP 服务器提供静态文件服务：

- 高效的静态文件处理
- 支持索引自动生成
- 支持目录列表
- 支持虚拟主机
- 支持 gzip 压缩
- 支持 HTTP/2

### 2. 反向代理

将客户端请求转发到后端服务器：

- HTTP/HTTPS 反向代理
- FastCGI 代理
- uWSGI 代理
- SCGI 代理
- gRPC 代理
- WebSocket 代理

### 3. 负载均衡

将请求分发到多个后端服务器：

- 轮询（Round Robin）
- 加权轮询（Weighted Round Robin）
- IP 哈希（IP Hash）
- 最少连接（Least Connections）
- 一致性哈希（Consistent Hashing）

### 4. SSL/TLS

支持 HTTPS 加密通信：

- 自签名证书
- Let's Encrypt 证书
- SNI（Server Name Indication）
- OCSP Stapling
- HTTP/2 over TLS

### 5. URL 重写

灵活的 URL 处理规则：

- 正则表达式匹配
- 条件判断
- 重定向
- 内部跳转

### 6. 缓存

减少后端服务器压力：

- 代理缓存
- FastCGI 缓存
- 缓存控制
- 缓存清除

### 7. 日志

详细的访问和错误日志：

- 自定义日志格式
- 访问日志
- 错误日志
- 日志轮转

---

## 常用命令

### nginx.exe - Nginx 主程序

```powershell
# 启动 Nginx
nginx

# 指定配置文件启动
nginx -c "C:\nginx\conf\nginx.conf"

# 停止 Nginx（快速停止）
nginx -s stop

# 停止 Nginx（优雅停止，等待请求处理完成）
nginx -s quit

# 重新加载配置文件
nginx -s reload

# 重新打开日志文件
nginx -s reopen

# 检查配置文件语法
nginx -t

# 检查配置文件并显示详细信息
nginx -T

# 查看 Nginx 版本
nginx -v

# 查看 Nginx 版本和编译参数
nginx -V

# 显示帮助
nginx -h
```

### 服务管理（Windows）

```powershell
# 注册为 Windows 服务
sc create Nginx binPath= "C:\nginx\nginx.exe" start= auto

# 启动服务
net start Nginx

# 停止服务
net stop Nginx

# 删除服务
sc delete Nginx

# 或者使用 NSSM 工具管理服务
nssm install Nginx C:\nginx\nginx.exe
nssm start Nginx
nssm stop Nginx
nssm remove Nginx confirm
```

### 环境变量

Scoop 安装的 Nginx 会自动设置以下环境变量：

```powershell
# NGINX_HOME 指向 Nginx 安装目录
echo $env:NGINX_HOME

# 可以直接使用 nginx 命令
nginx -v
```

### 配置文件结构

```nginx
# 主配置块
worker_processes auto;
error_log logs/error.log warn;
pid logs/nginx.pid;

# 事件处理模块
events {
    worker_connections 1024;
    use select;
}

# HTTP 配置块
http {
    include mime.types;
    default_type application/octet-stream;

    # 日志格式
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log logs/access.log main;
    sendfile on;
    keepalive_timeout 65;
    gzip on;

    # 虚拟主机配置
    server {
        listen 80;
        server_name localhost;

        location / {
            root html;
            index index.html index.htm;
        }
    }
}
```

### 常用配置示例

#### 静态文件服务

```nginx
server {
    listen 80;
    server_name example.com;
    root C:/www/example;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }
}
```

#### 反向代理配置

```nginx
server {
    listen 80;
    server_name api.example.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

#### 负载均衡配置

```nginx
upstream backend {
    least_conn;
    server 127.0.0.1:3001 weight=3;
    server 127.0.0.1:3002 weight=2;
    server 127.0.0.1:3003 weight=1;
}

server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://backend;
    }
}
```

#### WebSocket 代理配置

```nginx
server {
    listen 80;
    server_name ws.example.com;

    location /ws {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_read_timeout 86400;
    }
}
```

#### HTTPS 配置

```nginx
server {
    listen 443 ssl http2;
    server_name example.com;

    ssl_certificate C:/nginx/ssl/example.com.crt;
    ssl_certificate_key C:/nginx/ssl/example.com.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    location / {
        root html;
        index index.html;
    }
}

# HTTP 重定向到 HTTPS
server {
    listen 80;
    server_name example.com;
    return 301 https://$server_name$request_uri;
}
```

#### PHP FastCGI 配置

```nginx
server {
    listen 80;
    server_name php.example.com;
    root C:/www/php;

    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

#### URL 重写规则

```nginx
server {
    listen 80;
    server_name example.com;

    # 重定向旧 URL 到新 URL
    rewrite ^/old-path$ /new-path permanent;

    # 隐藏 .html 后缀
    rewrite ^(/.*)\.html$ $1 last;

    # 根据条件重写
    if ($http_user_agent ~* "bot") {
        return 403;
    }

    # 将所有请求重定向到 index.php
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
}
```

#### 代理缓存配置

```nginx
http {
    proxy_cache_path C:/nginx/cache levels=1:2 keys_zone=my_cache:10m max_size=1g inactive=60m;

    server {
        listen 80;
        server_name example.com;

        location / {
            proxy_pass http://backend;
            proxy_cache my_cache;
            proxy_cache_valid 200 302 10m;
            proxy_cache_valid 404 1m;
            add_header X-Cache-Status $upstream_cache_status;
        }
    }
}
```

### 日志管理

```powershell
# 查看访问日志
Get-Content "C:\nginx\logs\access.log" -Tail 50

# 实时查看访问日志
Get-Content "C:\nginx\logs\access.log" -Wait

# 查看错误日志
Get-Content "C:\nginx\logs\error.log" -Tail 50

# 查看当前日志格式
nginx -T | Select-String "log_format"
```

### 持久化目录

Scoop 安装时会持久化以下目录：

- `conf` - 配置文件目录
- `html` - 默认网站根目录
- `logs` - 日志文件目录
- `temp` - 临时文件目录

---

## 常见问题

### Q1: Nginx 启动失败怎么办？

**排查步骤：**

1. **检查配置文件语法**：
   ```powershell
   nginx -t
   ```

2. **检查端口占用**：
   ```powershell
   netstat -ano | findstr :80
   ```

3. **检查错误日志**：
   ```powershell
   Get-Content "C:\nginx\logs\error.log" -Tail 20
   ```

4. **常见错误原因**：
   - 配置文件语法错误
   - 端口 80 或 443 已被占用
   - 文件路径不存在或权限不足
   - 其他 Nginx 进程已在运行

### Q2: 如何配置多个虚拟主机？

在 `nginx.conf` 的 `http` 块中添加多个 `server` 块：

```nginx
http {
    server {
        listen 80;
        server_name site1.example.com;
        root C:/www/site1;
    }

    server {
        listen 80;
        server_name site2.example.com;
        root C:/www/site2;
    }
}
```

或者使用 `include` 指令分离配置文件：

```nginx
http {
    include conf.d/*.conf;
}
```

### Q3: 502 Bad Gateway 错误如何解决？

1. **检查后端服务是否运行**：确认反向代理指向的服务正常运行
2. **检查端口配置**：确认 `proxy_pass` 中的端口号正确
3. **检查超时设置**：适当增加 `proxy_read_timeout`
4. **查看错误日志**：分析具体错误原因

### Q4: 如何配置 HTTPS？

1. 获取 SSL 证书（自签名或 CA 颁发）
2. 配置 SSL 相关参数（参考上方 HTTPS 配置示例）
3. 配置 HTTP 到 HTTPS 的重定向
4. 重新加载配置：`nginx -s reload`

### Q5: Nginx 如何实现热部署？

```powershell
# 平滑升级步骤
# 1. 检查新版本配置
nginx -t -c C:\nginx\conf\nginx-new.conf

# 2. 发送 USR2 信号启动新进程
# 3. 发送 WINCH 信号让旧进程优雅退出
# 4. 发送 QUIT 信号停止旧进程
```

### Q6: 如何优化 Nginx 性能？

1. **调整 worker 进程数**：
   ```nginx
   worker_processes auto;  # 自动匹配 CPU 核心数
   ```

2. **增加连接数**：
   ```nginx
   events {
       worker_connections 4096;
   }
   ```

3. **启用 gzip 压缩**：
   ```nginx
   gzip on;
   gzip_types text/plain text/css application/json application/javascript;
   ```

4. **启用缓存**：配置代理缓存减少后端压力

5. **调整缓冲区大小**：
   ```nginx
   proxy_buffer_size 128k;
   proxy_buffers 4 256k;
   ```

### Q7: 如何配置 Nginx 的访问控制？

```nginx
# IP 白名单
location /admin {
    allow 192.168.1.0/24;
    allow 10.0.0.0/8;
    deny all;
}

# 基本认证
location /protected {
    auth_basic "Restricted Area";
    auth_basic_user_file C:/nginx/conf/.htpasswd;
}
```

---

## 相关资源

### 官方资源

- Nginx 官网：https://nginx.org
- Nginx 官方文档：https://nginx.org/en/docs/
- Nginx 配置指南：https://nginx.org/en/docs/beginners_guide.html
- Nginx GitHub：https://github.com/nginx/nginx

### Nginx Plus（商业版）

- Nginx Plus 功能：https://www.nginx.com/products/
- Nginx Plus 文档：https://docs.nginx.com/

### 第三方模块

- Nginx 模块列表：https://www.nginx.com/resources/wiki/modules/
- Nginx Awesome 列表：https://github.com/fcambus/nginx-resources
- OpenResty（Nginx + Lua）：https://openresty.org/

### GUI 管理工具

- Nginx Proxy Manager：https://nginxproxymanager.com/
- nginx-ui：https://github.com/0xJacky/nginx-ui

### 学习资源

- Nginx 入门教程：https://www.nginx.com/resources/wiki/start/
- Nginx 配置生成器：https://www.digitalocean.com/community/tools/nginx
- Nginx 中文文档：https://www.nginx.cn/doc/

### 社区资源

- Nginx 论坛：https://forum.nginx.org/
- Stack Overflow Nginx 标签：https://stackoverflow.com/questions/tagged/nginx
- Reddit r/nginx：https://www.reddit.com/r/nginx/
