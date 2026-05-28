# Rttys 使用指南

## 简介

Rttys 是 rtty 远程终端系统的服务器端组件，用于管理远程设备的终端访问。

**版本**: 5.5.2  
**官网**: https://github.com/zhaojh329/rttys  
**许可证**: MIT  
**类型**: 服务器端组件  
**可执行文件**: rttys.exe

## 主要功能

- 远程终端管理服务
- 设备连接管理
- 用户认证授权
- Web 终端界面
- 设备分组管理
- 连接日志记录
- API 接口支持

## 常用命令

### 基本操作

```bash
# 启动 rttys 服务
rttys.exe

# 使用配置文件启动
rttys.exe -c rttys.conf
```

### 命令行参数

```bash
# 查看帮助
rttys.exe -h

# 指定配置文件
rttys.exe -c /path/to/rttys.conf

# 指定监听端口
rttys.exe -p 5913
```

## 配置文件

### 配置文件位置

```
rttys.conf
```

### 配置文件示例

```ini
# rttys.conf

# 监听端口
addr: 5913

# Web 界面端口
http-port: 5912

# 认证令牌
token: your-token-here

# SSL 证书配置
cert-file: /path/to/cert.pem
key-file: /path/to/key.pem

# 日志级别
log-level: info

# 最大连接数
max-connections: 100
```

### 配置参数说明

```
addr              监听地址和端口
http-port         Web 界面端口
token             认证令牌
cert-file         SSL 证书文件
key-file          SSL 密钥文件
log-level         日志级别（debug, info, warn, error）
max-connections   最大连接数
```

## 使用场景

### 远程设备管理

```
1. 启动 rttys 服务
2. 设备通过 rtty 客户端连接
3. 通过 Web 界面访问设备终端
```

### IoT 设备运维

```
1. 部署 rttys 服务器
2. 在 IoT 设备上安装 rtty 客户端
3. 集中管理所有设备
```

## 常见问题

### 1. 无法启动服务

```
可能原因:
- 端口被占用
- 配置文件错误
- 权限不足

解决方法:
1. 检查端口占用情况
2. 验证配置文件格式
3. 使用管理员权限运行
```

### 2. 设备无法连接

```
可能原因:
- 网络不通
- 防火墙阻止
- 认证失败

解决方法:
1. 检查网络连接
2. 开放相应端口
3. 验证认证令牌
```

## 相关资源

- [Rttys GitHub](https://github.com/zhaojh329/rttys)
- [Rtty 客户端](https://github.com/zhaojh329/rtty)
- [官方文档](https://github.com/zhaojh329/rttys#readme)