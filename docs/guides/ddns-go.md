# ddns-go 使用指南

## 简介

ddns-go 是一个快速、轻量级的动态 DNS（DDNS）工具，当前版本为 v6.6.3，采用 Apache-2.0 开源许可证。

ddns-go 可以自动将域名解析到您的动态公网 IP 地址，支持多种 DNS 服务商。它是用 Go 语言开发的，具有高性能、低资源占用的特点，支持在各种设备上运行，包括路由器、NAS、树莓派等。

**主要特性：**
- 开源项目，Apache-2.0 许可证
- 支持多种 DNS 服务商
- 支持 IPv4 和 IPv6
- Web 管理界面
- 服务模式运行
- 跨平台支持
- 低资源占用

**官方网站：** https://github.com/jeessy2/ddns-go

---

## 主要功能

### 1. 多 DNS 服务商支持
ddns-go 支持国内外主流 DNS 服务商，包括阿里云 DNS、腾讯云 DNS、Cloudflare、DNSPod 等，满足不同用户的需求。

### 2. 双栈 IP 支持
同时支持 IPv4 和 IPv6 动态域名解析，可以分别配置 IPv4 和 IPv6 的域名记录。

### 3. Web 管理界面
提供简洁易用的 Web 界面，方便配置和管理。支持远程访问，可以随时随地管理 DDNS 配置。

### 4. 服务模式运行
支持以系统服务方式运行，开机自动启动，无需手动管理。支持 Windows 服务、Linux systemd、macOS launchd 等。

### 5. 定时更新
支持自定义更新间隔，自动检测 IP 变化并更新 DNS 记录。只有 IP 发生变化时才会更新，减少 API 调用。

### 6. 通知支持
支持多种通知方式，包括邮件、Telegram、钉钉、企业微信等，IP 变化时及时通知用户。

---

## 常用命令/操作

### 包含的工具

| 工具名称 | 说明 |
|---------|------|
| ddns-go.exe | DDNS 客户端主程序 |

### 安装与配置

```bash
# 通过 Scoop 安装
scoop install ddns-go

# 验证安装
ddns-go --version

# 查看帮助
ddns-go --help
```

### 启动方式

```bash
# 直接启动（前台运行）
ddns-go

# 指定端口启动
ddns-go -l :9876

# 指定监听地址
ddns-go -l 127.0.0.1:9876

# 后台运行（Linux/macOS）
nohup ddns-go &

# 查看版本信息
ddns-go -v
```

### 服务管理

```bash
# 安装为系统服务（需要管理员权限）
ddns-go -s install

# 卸载系统服务
ddns-go -s uninstall

# 启动服务
ddns-go -s start

# 停止服务
ddns-go -s stop

# 重启服务
ddns-go -s restart

# 查看服务状态
ddns-go -s status
```

**Windows 服务管理：**

```powershell
# 以管理员身份运行 PowerShell

# 安装服务
ddns-go.exe -s install

# 启动服务
ddns-go.exe -s start

# 查看服务状态
Get-Service ddns-go

# 停止服务
ddns-go.exe -s stop

# 卸载服务
ddns-go.exe -s uninstall
```

**Linux systemd 管理：**

```bash
# 创建 systemd 服务文件
sudo tee /etc/systemd/system/ddns-go.service <<EOF
[Unit]
Description=ddns-go service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ddns-go
Restart=always
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd
sudo systemctl daemon-reload

# 启用并启动服务
sudo systemctl enable ddns-go
sudo systemctl start ddns-go

# 查看服务状态
sudo systemctl status ddns-go

# 查看日志
sudo journalctl -u ddns-go -f
```

### Web 管理界面

启动 ddns-go 后，访问 Web 界面进行配置：

```bash
# 默认访问地址
http://localhost:9876

# 或者指定 IP 访问
http://<your-ip>:9876
```

**Web 界面功能：**

1. **DNS 服务商配置**
   - 选择 DNS 服务商（阿里云、腾讯云、Cloudflare 等）
   - 填写 API 密钥
   - 配置域名信息

2. **域名配置**
   - 添加 IPv4 域名
   - 添加 IPv6 域名
   - 配置更新间隔

3. **通知配置**
   - 配置邮件通知
   - 配置 Webhook
   - 配置即时通讯通知

4. **日志查看**
   - 查看更新历史
   - 查看错误日志
   - 导出日志

### 配置文件

ddns-go 支持通过配置文件进行配置：

```yaml
# config.yaml 示例
dns:
  # DNS 服务商
  provider: alidns
  # Access Key ID
  access_key_id: your_access_key_id
  # Access Key Secret  
  access_key_secret: your_access_key_secret

ipv4:
  # 启用 IPv4
  enable: true
  # IPv4 域名列表
  domains:
    - home.example.com
    - *.example.com
  # 获取 IP 方式：url 或 netInterface
  get_type: url
  # 获取 IP 的 URL
  url: https://api-ipv4.ip.sb/ip

ipv6:
  # 启用 IPv6
  enable: true
  # IPv6 域名列表
  domains:
    - home6.example.com
  # 获取 IP 方式
  get_type: netInterface
  # 网络接口名称
  net_interface: eth0

# 更新间隔（秒）
interval: 300

# Web 监听地址
listen: :9876

# 登录用户名（为空则不需要认证）
username: admin
# 登录密码
password: your_password

# 通知配置
webhook:
  # Webhook URL
  url: https://hooks.example.com/notify
  # 请求方式
  method: POST
  # 请求头
  headers:
    Content-Type: application/json
  # 请求体模板
  body: |
    {
      "text": "IP changed to {{.IP}}"
    }
```

### 命令行参数

```bash
# 查看所有参数
ddns-go -h

# 指定配置文件
ddns-go -c /path/to/config.yaml

# 指定监听端口
ddns-go -l :9876

# 指定更新间隔
ddns-go -i 300

# 启用调试模式
ddns-go -d

# 指定日志文件
ddns-go -log /var/log/ddns-go.log
```

### 支持的 DNS 服务商

| 服务商 | 说明 |
|--------|------|
| alidns | 阿里云 DNS |
| tencent | 腾讯云 DNS |
| cloudflare | Cloudflare |
| dnspod | DNSPod |
| huaweicloud | 华为云 DNS |
| baiducloud | 百度云 DNS |
| namesilo | Namesilo |
| godaddy | GoDaddy |
| namecheap | Namecheap |
| route53 | AWS Route53 |
| google | Google Cloud DNS |
| azure | Azure DNS |

### API 接口

ddns-go 提供 RESTful API 接口：

```bash
# 获取当前 IP
curl http://localhost:9876/api/ip

# 获取配置
curl http://localhost:9876/api/config

# 手动触发更新
curl -X POST http://localhost:9876/api/update

# 获取日志
curl http://localhost:9876/api/logs

# 健康检查
curl http://localhost:9876/api/health
```

### Docker 部署

```bash
# 拉取镜像
docker pull jeessy/ddns-go

# 运行容器
docker run -d \
  --name ddns-go \
  --restart=always \
  -p 9876:9876 \
  -v /opt/ddns-go:/root \
  jeessy/ddns-go

# 使用 docker-compose
cat << EOF > docker-compose.yml
version: '3'
services:
  ddns-go:
    image: jeessy/ddns-go
    container_name: ddns-go
    restart: always
    ports:
      - "9876:9876"
    volumes:
      - /opt/ddns-go:/root
EOF

docker-compose up -d
```

### 路由器部署

**OpenWrt 路由器：**

```bash
# 下载对应架构的二进制文件
wget https://github.com/jeessy2/ddns-go/releases/download/v6.6.3/ddns-go_6.6.3_linux_mipsle.gz

# 解压
gunzip ddns-go_6.6.3_linux_mipsle.gz

# 添加执行权限
chmod +x ddns-go_6.6.3_linux_mipsle

# 移动到系统目录
mv ddns-go_6.6.3_linux_mipsle /usr/bin/ddns-go

# 创建启动脚本
cat << 'EOF' > /etc/init.d/ddns-go
#!/bin/sh /etc/rc.common

START=99
STOP=10

start() {
    /usr/bin/ddns-go &
}

stop() {
    killall ddns-go
}
EOF

chmod +x /etc/init.d/ddns-go

# 启用服务
/etc/init.d/ddns-go enable
/etc/init.d/ddns-go start
```

---

## 常见问题

### Q1: ddns-go 无法获取公网 IP 怎么办？

**排查步骤：**

1. **检查网络连接**
   ```bash
   # 测试外网访问
   curl https://api-ipv4.ip.sb/ip
   
   # 检查防火墙设置
   # 确保可以访问外部 HTTP 服务
   ```

2. **更换获取 IP 的 URL**
   ```bash
   # 可选的 IP 获取 URL
   https://api-ipv4.ip.sb/ip
   https://ip.sb/ip
   https://api.ipify.org
   https://icanhazip.com
   https://checkip.amazonaws.com
   ```

3. **使用网络接口获取**
   - 在配置中选择 `netInterface` 方式
   - 选择正确的网络接口

### Q2: DNS 更新失败怎么办？

**排查步骤：**

1. **检查 API 密钥**
   - 确认 Access Key ID 和 Secret 正确
   - 检查密钥是否有 DNS 管理权限
   - 尝试重新生成密钥

2. **检查域名配置**
   - 确认域名已添加到 DNS 服务商
   - 检查域名格式是否正确
   - 确认域名没有被锁定

3. **查看错误日志**
   ```bash
   # 查看 ddns-go 日志
   ddns-go -d
   
   # 或查看服务日志
   sudo journalctl -u ddns-go -f
   ```

### Q3: 如何配置多个域名？

**配置方法：**

在 Web 界面或配置文件中添加多个域名：

```yaml
ipv4:
  enable: true
  domains:
    - home.example.com
    - vpn.example.com
    - "*.example.com"  # 泛域名

ipv6:
  enable: true
  domains:
    - home6.example.com
    - nas.example.com
```

### Q4: 如何配置通知？

**邮件通知配置：**

```yaml
webhook:
  url: smtp://smtp.example.com:587
  method: POST
  headers:
    From: ddns@example.com
    To: admin@example.com
  body: |
    Subject: DDNS IP Changed
    Your IP has changed to {{.IP}}
```

**Telegram 通知配置：**

```yaml
webhook:
  url: https://api.telegram.org/bot<token>/sendMessage
  method: POST
  headers:
    Content-Type: application/json
  body: |
    {
      "chat_id": "<chat_id>",
      "text": "DDNS IP changed to {{.IP}}"
    }
```

**钉钉通知配置：**

```yaml
webhook:
  url: https://oapi.dingtalk.com/robot/send?access_token=<token>
  method: POST
  headers:
    Content-Type: application/json
  body: |
    {
      "msgtype": "text",
      "text": {
        "content": "DDNS IP changed to {{.IP}}"
      }
    }
```

### Q5: 如何提高安全性？

**安全建议：**

1. **设置访问密码**
   ```yaml
   username: admin
   password: strong_password_here
   ```

2. **限制访问 IP**
   - 配置防火墙只允许特定 IP 访问 Web 界面
   - 使用反向代理并配置 IP 白名单

3. **使用 HTTPS**
   - 配置反向代理（如 Nginx）启用 HTTPS
   - 使用 Let's Encrypt 免费证书

4. **定期更新**
   - 及时更新到最新版本
   - 关注安全公告

### Q6: ddns-go 支持哪些 IP 获取方式？

**支持的获取方式：**

1. **URL 方式**
   - 通过外部服务获取公网 IP
   - 支持多个备选 URL
   - 自动重试机制

2. **网络接口方式**
   - 直接从网络接口获取 IP
   - 适用于有公网 IP 的设备
   - 支持指定接口名称

3. **命令方式**
   - 执行自定义命令获取 IP
   - 灵活的自定义能力
   - 适用于特殊网络环境

### Q7: 如何监控 ddns-go 运行状态？

**监控方法：**

1. **健康检查 API**
   ```bash
   # 检查服务状态
   curl http://localhost:9876/api/health
   
   # 获取当前 IP
   curl http://localhost:9876/api/ip
   ```

2. **日志监控**
   ```bash
   # 实时查看日志
   tail -f /var/log/ddns-go.log
   
   # 使用 systemd journal
   journalctl -u ddns-go -f
   ```

3. **外部监控**
   - 使用 UptimeRobot 等服务监控健康检查端点
   - 配置告警通知

### Q8: 如何迁移 ddns-go 配置？

**迁移步骤：**

1. **导出配置**
   ```bash
   # 备份配置文件
   cp ~/.ddns-go/config.yaml /backup/
   
   # 或通过 Web 界面导出
   curl http://localhost:9876/api/config > config_backup.json
   ```

2. **在新设备安装**
   ```bash
   # 安装 ddns-go
   scoop install ddns-go
   ```

3. **导入配置**
   ```bash
   # 复制配置文件
   cp /backup/config.yaml ~/.ddns-go/
   
   # 或通过 Web 界面导入
   # 访问 Web 界面并手动配置
   ```

---

## 相关资源

### 官方资源
- [ddns-go GitHub 仓库](https://github.com/jeessy2/ddns-go)
- [ddns-go 发行页面](https://github.com/jeessy2/ddns-go/releases)
- [ddns-go 文档](https://github.com/jeessy2/ddns-go/blob/main/README.md)

### 安装与配置
- [ddns-go 安装指南](https://github.com/jeessy2/ddns-go#安装)
- [Scoop 包管理器](https://scoop.sh/)
- [Docker Hub](https://hub.docker.com/r/jeessy/ddns-go)

### 学习资源
- [DDNS 基础知识](https://en.wikipedia.org/wiki/Dynamic_DNS)
- [DNS 记录类型](https://en.wikipedia/wiki/Domain_Name_System#Resource_records)
- [Go 语言官方文档](https://golang.org/doc/)

### DNS 服务商文档
- [阿里云 DNS 文档](https://help.aliyun.com/product/29697.html)
- [腾讯云 DNS 文档](https://cloud.tencent.com/document/product/302)
- [Cloudflare API 文档](https://developers.cloudflare.com/api/)
- [DNSPod 文档](https://www.dnspod.cn/docs/)

### 相关工具
- [Inadyn DDNS 客户端](https://github.com/troglobit/inadyn)
- [ddclient DDNS 客户端](https://github.com/ddclient/ddclient)
- [No-IP DDNS 服务](https://www.noip.com/)

### 社区支持
- [GitHub Issues](https://github.com/jeessy2/ddns-go/issues)
- [GitHub Discussions](https://github.com/jeessy2/ddns-go/discussions)

### 部署参考
- [OpenWrt 官方文档](https://openwrt.org/docs/start)
- [Docker 官方文档](https://docs.docker.com/)
- [systemd 文档](https://systemd.io/)

---

## 更新日志

### v6.6.3
- 新增更多 DNS 服务商支持
- 优化 IP 获取逻辑
- 改进 Web 界面
- 修复已知问题

---

*本文档最后更新于：2026年5月27日*
