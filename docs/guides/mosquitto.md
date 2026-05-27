# Mosquitto 使用指南

> 版本：v2.0.15 | 许可证：EPL-1.0 | 官网：https://mosquitto.org/

---

## 简介

Mosquitto 是一款轻量级的开源消息代理（Message Broker），实现了 MQTT（Message Queuing Telemetry Transport）协议。MQTT 是一种专为物联网（IoT）和机器对机器（M2M）通信设计的轻量级消息传输协议，广泛应用于资源受限的设备和低带宽、高延迟的网络环境中。

Mosquitto 由 Eclipse 基金会维护，具有占用资源少、配置简单、支持多种平台等特点，是目前最流行的 MQTT 代理之一。

### 核心特性

- **轻量高效**：内存占用小，适合嵌入式设备和低功耗环境
- **完整 MQTT 支持**：支持 MQTT v3.1、v3.1.1 和 v5.0 协议
- **QoS 支持**：支持三种服务质量级别（QoS 0、1、2）
- **安全认证**：支持用户名/密码认证、TLS/SSL 加密
- **WebSocket 支持**：支持通过 WebSocket 协议连接
- **插件系统**：支持自定义认证插件和扩展功能
- **桥接模式**：支持多个 Mosquitto 实例之间的桥接

### MQTT 协议简介

MQTT 是一种发布/订阅模式的消息协议：

- **发布者（Publisher）**：向指定主题发送消息
- **订阅者（Subscriber）**：订阅感兴趣的主题以接收消息
- **代理（Broker）**：负责接收发布者的消息并转发给订阅者

### QoS 级别

- **QoS 0**：最多一次传递，消息可能丢失
- **QoS 1**：至少一次传递，消息可能重复
- **QoS 2**：恰好一次传递，确保消息不丢失不重复

---

## 主要功能

### 1. 消息代理

作为 MQTT 代理，负责消息的路由和分发：

- 接收客户端发布的消息
- 根据主题匹配规则分发给订阅者
- 支持通配符主题匹配（`+` 单层、`#` 多层）

### 2. 安全机制

- **用户名/密码认证**：基于密码文件的认证
- **TLS/SSL 加密**：支持加密传输
- **ACL 访问控制**：基于主题的访问控制列表
- **客户端证书认证**：双向 TLS 认证

### 3. 持久化

- 支持消息持久化存储
- 客户端会话持久化
- 订阅关系持久化

### 4. 桥接

支持多个 Mosquitto 实例之间的桥接连接：

- 主从桥接
- 双向桥接
- 主题映射

### 5. Web 集成

- WebSocket 支持
- HTTP API（通过插件）

### 6. 日志与监控

- 详细的日志记录
- `$SYS` 系统主题监控
- 连接状态追踪

---

## 常用命令

### mosquitto.exe - MQTT 代理服务

```powershell
# 使用默认配置启动代理
mosquitto

# 指定配置文件启动
mosquitto -c "C:\mosquitto\mosquitto.conf"

# 指定监听端口（默认 1883）
mosquitto -p 1883

# 后台运行（守护进程模式）
mosquitto -d

# 开启详细日志输出
mosquitto -v

# 指定日志输出到文件
mosquitto -c "C:\mosquitto\mosquitto.conf" -d

# 仅监听本地连接
mosquitto -h 127.0.0.1 -p 1883

# 启用 WebSocket 监听
mosquitto -p 1883 --websocket-port 8080
```

### mosquitto_pub.exe - 消息发布工具

```powershell
# 发布简单消息
mosquitto_pub -t "test/topic" -m "Hello MQTT"

# 指定 QoS 级别
mosquitto_pub -t "test/topic" -m "Hello" -q 1

# 指定 QoS 2（最可靠）
mosquitto_pub -t "test/topic" -m "Important message" -q 2

# 保留消息（新订阅者会收到最后一条保留消息）
mosquitto_pub -t "test/topic" -m "Status: online" -r

# 从文件读取消息内容
mosquitto_pub -t "test/topic" -f "message.txt"

# 从标准输入读取消息
echo "Hello" | mosquitto_pub -t "test/topic" -s

# 连接远程代理
mosquitto_pub -h "broker.example.com" -p 1883 -t "test/topic" -m "Hello"

# 使用用户名密码认证
mosquitto_pub -h "broker.example.com" -u "username" -P "password" -t "test/topic" -m "Hello"

# 使用 TLS/SSL 连接
mosquitto_pub -h "broker.example.com" -p 8883 --cafile "ca.crt" -t "test/topic" -m "Secure message"

# 发布 JSON 数据
mosquitto_pub -t "sensor/temperature" -m '{"temp": 25.5, "unit": "C"}'

# 指定客户端 ID
mosquitto_pub -i "publisher1" -t "test/topic" -m "Hello"

# 发布多条消息（指定间隔）
mosquitto_pub -t "test/topic" -m "Message" --repeat 10 --repeat-delay 1

# 线程模式（长连接发布）
mosquitto_pub -t "test/topic" -l
# 然后从标准输入逐行读取消息
```

### mosquitto_sub.exe - 消息订阅工具

```powershell
# 订阅主题
mosquitto_sub -t "test/topic"

# 订阅多个主题
mosquitto_sub -t "topic1" -t "topic2"

# 使用通配符订阅
mosquitto_sub -t "sensors/#"
mosquitto_sub -t "home/+/temperature"

# 指定 QoS 级别
mosquitto_sub -t "test/topic" -q 1

# 显示完整主题名称
mosquitto_sub -t "test/topic" -v

# 限制接收消息数量后退出
mosquitto_sub -t "test/topic" -C 5

# 设置超时时间（秒）
mosquitto_sub -t "test/topic" -W 30

# 连接远程代理
mosquitto_sub -h "broker.example.com" -t "test/topic"

# 使用认证
mosquitto_sub -h "broker.example.com" -u "username" -P "password" -t "test/topic"

# 使用 TLS/SSL
mosquitto_sub -h "broker.example.com" -p 8883 --cafile "ca.crt" -t "test/topic"

# 显示消息时间戳
mosquitto_sub -t "test/topic" -F "@Y-@m-@d @H:@M:@S : %t : %p"

# 输出格式化
mosquitto_sub -t "test/topic" -F "%t: %p"

# 订阅 $SYS 系统主题
mosquitto_sub -t '$SYS/#' -v
```

### mosquitto_passwd.exe - 密码管理工具

```powershell
# 创建密码文件并添加用户
mosquitto_passwd -c "C:\mosquitto\passwd" username

# 向已有密码文件添加用户
mosquitto_passwd -b "C:\mosquitto\passwd" username password

# 删除用户
mosquitto_passwd -D "C:\mosquitto\passwd" username

# 修改用户密码
mosquitto_passwd "C:\mosquitto\passwd" username

# 查看密码文件中的用户列表
mosquitto_passwd -U "C:\mosquitto\passwd"

# 使用 bcrypt 加密（更安全）
mosquitto_passwd -c -b "C:\mosquitto\passwd" username password

# 批量添加用户（从文件读取）
mosquitto_passwd -b "C:\mosquitto\passwd" user1 pass1
mosquitto_passwd -b "C:\mosquitto\passwd" user2 pass2
```

### mosquitto_rr.exe - 请求/响应工具

```powershell
# 发送请求消息并等待响应
mosquitto_rr -t "request/topic" -e "response/topic" -m "request data"

# 指定超时时间
mosquitto_rr -t "request/topic" -e "response/topic" -m "request" -W 10

# 使用 QoS
mosquitto_rr -t "request/topic" -e "response/topic" -m "request" -q 1

# 连接远程代理
mosquitto_rr -h "broker.example.com" -t "request/topic" -e "response/topic" -m "request"
```

### 配置文件 (mosquitto.conf)

```conf
# 监听端口
listener 1883

# WebSocket 监听
listener 8080
protocol websockets

# 允许匿名连接（生产环境建议禁用）
allow_anonymous false

# 密码文件
password_file C:\mosquitto\passwd

# 访问控制文件
acl_file C:\mosquitto\acl

# 日志配置
log_dest file C:\mosquitto\mosquitto.log
log_type all
connection_messages true
log_timestamp true

# 持久化
persistence true
persistence_location C:\mosquitto\data\

# 最大连接数
max_connections -1

# 消息大小限制
message_size_limit 0

# TLS/SSL 配置
# listener 8883
# certfile C:\mosquitto\certs\server.crt
# keyfile C:\mosquitto\certs\server.key
# cafile C:\mosquitto\certs\ca.crt
# require_certificate false
```

### ACL 访问控制文件示例

```conf
# 用户级别的访问控制
topic read sensors/#
topic write actuators/#

# 特定用户的权限
user admin
topic readwrite #

user device1
topic readwrite devices/device1/#

# 匿名用户权限（如果允许匿名）
topic read public/#
```

### 服务管理（Windows）

```powershell
# 注册为 Windows 服务
sc create Mosquitto binPath= "C:\mosquitto\mosquitto.exe -c C:\mosquitto\mosquitto.conf" start= auto

# 启动服务
net start Mosquitto

# 停止服务
net stop Mosquitto

# 删除服务
sc delete Mosquitto
```

---

## 常见问题

### Q1: 无法连接到 Mosquitto 代理怎么办？

**排查步骤：**

1. **检查服务是否运行**：
   ```powershell
   netstat -ano | findstr :1883
   ```

2. **检查防火墙设置**：确保 1883 端口未被阻止

3. **检查配置文件**：确认 `listener` 配置正确

4. **检查认证信息**：如果启用了认证，确保用户名密码正确

5. **查看日志文件**：
   ```powershell
   Get-Content "C:\mosquitto\mosquitto.log" -Tail 50
   ```

### Q2: 消息发送后订阅者收不到怎么办？

1. **检查主题名称**：主题名称区分大小写，确保完全匹配
2. **检查 QoS 级别**：发布者和订阅者的 QoS 级别会影响消息传递
3. **检查 ACL 配置**：确保用户有读写对应主题的权限
4. **保留消息**：如果需要新订阅者收到最后一条消息，使用 `-r` 参数
5. **检查连接状态**：确认发布者和订阅者都已成功连接

### Q3: 如何实现 TLS/SSL 加密连接？

1. 生成 CA 证书和服务器证书
2. 在配置文件中启用 TLS：
   ```conf
   listener 8883
   certfile C:\mosquitto\certs\server.crt
   keyfile C:\mosquitto\certs\server.key
   cafile C:\mosquitto\certs\ca.crt
   ```
3. 客户端使用 `--cafile` 参数连接

### Q4: Mosquitto 如何处理大量并发连接？

- 增加操作系统的文件描述符限制
- 使用 QoS 0 减少代理负担
- 合理配置 `max_inflight_messages` 参数
- 考虑使用集群或桥接分散负载
- 监控 `$SYS/broker/clients/connected` 主题

### Q5: 通配符主题匹配规则是什么？

- `+`：匹配单层主题，如 `home/+/temperature` 匹配 `home/kitchen/temperature`
- `#`：匹配多层主题，如 `sensors/#` 匹配 `sensors/temp/room1`
- 注意：`#` 只能放在主题末尾

### Q6: 如何调试 MQTT 通信问题？

```powershell
# 使用详细模式启动代理
mosquitto -v

# 使用 mosquitto_sub 监听所有消息
mosquitto_sub -t '#' -v

# 检查 $SYS 主题获取代理状态
mosquitto_sub -t '$SYS/#' -v
```

### Q7: Mosquitto v2.0 默认行为有何变化？

Mosquitto v2.0 的重要变化：

- **默认禁止匿名访问**：需要显式配置 `allow_anonymous true` 或配置认证
- **默认仅监听 localhost**：需要配置 `listener 1883 0.0.0.0` 接受外部连接
- **增强安全性**：推荐使用密码文件或认证插件

---

## 相关资源

### 官方资源

- Mosquitto 官网：https://mosquitto.org/
- Mosquitto 文档：https://mosquitto.org/man/
- Mosquitto GitHub：https://github.com/eclipse/mosquitto
- Eclipse Paho（MQTT 客户端库）：https://www.eclipse.org/paho/

### MQTT 协议资源

- MQTT 协议规范：https://mqtt.org/mqtt-specification/
- MQTT v5.0 规范：https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html
- MQTT 中文教程：https://www.runoob.com/mqtt/mqtt-tutorial.html

### MQTT 客户端工具

- MQTTX（跨平台 GUI 客户端）：https://mqttx.app/
- MQTT Explorer：http://mqtt-explorer.com/
- MQTT.fx：https://www.jensd.de/apps/mqttfx/

### 编程语言客户端库

- Python（paho-mqtt）：https://pypi.org/project/paho-mqtt/
- Node.js（mqtt.js）：https://www.npmjs.com/package/mqtt
- Java（Eclipse Paho）：https://www.eclipse.org/paho/clients/java/
- C#（MQTTnet）：https://github.com/chkr1011/MQTTnet
- Go（Eclipse Paho）：https://github.com/eclipse/paho.mqtt.golang

### 学习资源

- MQTT 入门教程：https://www.hivemq.com/mqtt-essentials/
- IoT 通信协议对比：https://www.emqx.com/en/blog/comparison-of-mqtt-amqp-and-stomp
- Mosquitto 配置详解：https://mosquitto.org/man/mosquitto-conf-5.html
