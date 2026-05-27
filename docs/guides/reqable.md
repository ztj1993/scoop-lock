# Reqable 使用指南

## 简介

Reqable 是一款高级 API 调试代理工具，专为开发者设计，用于调试、测试和分析 HTTP/HTTPS/WebSocket 网络流量。它提供了直观的图形界面和强大的功能，帮助开发者快速定位和解决 API 问题。

**版本**: v3.1.1  
**许可证**: Proprietary  
**官方描述**: Advanced API Debugging Proxy  
**项目主页**: https://reqable.com/

### 核心特性

- **HTTP/HTTPS 调试**: 捕获和分析 HTTP/HTTPS 流量
- **WebSocket 调试**: 实时监控 WebSocket 消息
- **API 测试**: 构建和发送 API 请求
- **流量拦截**: 拦截和修改网络请求
- **证书管理**: 管理 SSL/TLS 证书
- **多平台支持**: 支持 Windows、macOS、Linux

## 主要功能

### 1. 流量捕获与分析

Reqable 提供了强大的流量捕获功能：

- **实时捕获**: 实时捕获 HTTP/HTTPS 流量
- **请求/响应查看**: 查看完整的请求和响应数据
- **过滤功能**: 按域名、状态码、内容类型等过滤
- **搜索功能**: 在请求/响应中搜索内容

### 2. API 测试

Reqable 内置了 API 测试工具：

- **请求构建器**: 可视化构建 HTTP 请求
- **环境变量**: 支持环境变量管理
- **请求历史**: 保存和查看请求历史
- **批量测试**: 批量执行 API 测试

### 3. 流量拦截与修改

Reqable 支持拦截和修改网络流量：

- **请求拦截**: 拦截并修改请求
- **响应拦截**: 拦截并修改响应
- **断点调试**: 在请求/响应处设置断点
- **自动响应**: 配置自动响应规则

### 4. WebSocket 调试

Reqable 提供了 WebSocket 调试功能：

- **消息监控**: 实时监控 WebSocket 消息
- **消息发送**: 手动发送 WebSocket 消息
- **消息过滤**: 按类型过滤消息
- **消息历史**: 查看消息历史记录

### 5. 证书管理

Reqable 管理 SSL/TLS 证书：

- **证书生成**: 生成自签名证书
- **证书安装**: 安装根证书到系统
- **证书信任**: 配置证书信任
- **证书查看**: 查看证书详细信息

### 6. 数据导出

Reqable 支持导出捕获的数据：

- **HAR 导出**: 导出为 HAR 格式
- **cURL 导出**: 导出为 cURL 命令
- **请求导出**: 导出请求数据
- **响应导出**: 导出响应数据

## 界面介绍

### 1. 主界面布局

Reqable 的主界面分为以下几个区域：

- **工具栏**: 顶部工具栏，包含主要功能按钮
- **侧边栏**: 左侧侧边栏，包含会话列表和收藏夹
- **主工作区**: 中间主工作区，显示请求/响应详情
- **状态栏**: 底部状态栏，显示连接状态和统计信息

### 2. 请求列表

请求列表显示所有捕获的 HTTP 请求：

- **时间**: 请求时间
- **方法**: HTTP 方法（GET、POST 等）
- **URL**: 请求 URL
- **状态码**: 响应状态码
- **大小**: 响应大小
- **耗时**: 请求耗时

### 3. 请求详情

请求详情显示单个请求的详细信息：

- **请求头**: HTTP 请求头
- **请求体**: HTTP 请求体
- **响应头**: HTTP 响应头
- **响应体**: HTTP 响应体
- **时间线**: 请求时间线

### 4. API 测试器

API 测试器用于构建和发送请求：

- **URL 输入**: 输入请求 URL
- **方法选择**: 选择 HTTP 方法
- **请求头**: 配置请求头
- **请求体**: 配置请求体
- **发送按钮**: 发送请求

## 常用操作

### 开始捕获流量

#### 启动代理

1. 启动 Reqable
2. 点击"开始捕获"按钮
3. 配置系统代理或应用程序代理
4. 开始捕获网络流量

#### 配置系统代理

```bash
# Windows 系统代理设置
设置 > 网络和 Internet > 代理 > 手动设置代理

# macOS 系统代理设置
系统偏好设置 > 网络 > 高级 > 代理

# Linux 系统代理设置
export http_proxy=http://127.0.0.1:9000
export https_proxy=http://127.0.0.1:9000
```

### 过滤请求

#### 使用过滤器

1. 在过滤器输入框中输入过滤条件
2. 支持的过滤条件：
   - `domain:example.com` - 按域名过滤
   - `status:200` - 按状态码过滤
   - `method:POST` - 按 HTTP 方法过滤
   - `content-type:json` - 按内容类型过滤

#### 使用搜索

1. 按 `Ctrl + F` 打开搜索
2. 输入搜索关键词
3. 在请求/响应中搜索内容

### 构建 API 请求

#### 使用请求构建器

1. 打开 API 测试器
2. 输入请求 URL
3. 选择 HTTP 方法
4. 配置请求头
5. 配置请求体
6. 点击"发送"

#### 使用 cURL 导入

1. 点击"导入 cURL"
2. 粘贴 cURL 命令
3. 自动生成请求配置

### 拦截和修改请求

#### 设置拦截规则

1. 打开拦截设置
2. 配置拦截条件：
   - URL 匹配规则
   - HTTP 方法
   - 请求头条件
3. 启用拦截

#### 修改请求

1. 在拦截的请求上右键
2. 选择"编辑请求"
3. 修改请求头或请求体
4. 点击"发送修改后的请求"

### WebSocket 调试

#### 监控 WebSocket 消息

1. 捕获 WebSocket 连接
2. 查看实时消息
3. 过滤消息类型
4. 查看消息详情

#### 发送 WebSocket 消息

1. 选择 WebSocket 连接
2. 输入消息内容
3. 点击"发送"

### 导出数据

#### 导出为 HAR

1. 选择要导出的请求
2. 点击"导出"
3. 选择"HAR 格式"
4. 保存文件

#### 导出为 cURL

1. 选择请求
2. 右键点击
3. 选择"复制为 cURL"

## 常见问题

### 1. 无法捕获 HTTPS 流量

**问题**: 配置代理后无法捕获 HTTPS 流量。

**解决方案**:
1. 安装 Reqable 根证书到系统
2. 配置应用程序信任 Reqable 证书
3. 检查证书是否过期
4. 重新生成并安装证书

### 2. 代理连接失败

**问题**: 配置代理后无法连接网络。

**解决方案**:
1. 检查代理端口是否正确（默认 9000）
2. 确认 Reqable 正在运行
3. 检查防火墙设置
4. 尝试重启 Reqable

### 3. 应用程序不走代理

**问题**: 某些应用程序的流量没有被 Reqable 捕获。

**解决方案**:
1. 配置应用程序使用系统代理
2. 使用 Reqable 的 VPN 模式
3. 手动配置应用程序代理
4. 检查应用程序是否支持代理

### 4. 证书警告

**问题**: 浏览器显示证书警告。

**解决方案**:
1. 安装 Reqable 根证书到系统信任存储
2. 重启浏览器
3. 清除浏览器证书缓存
4. 检查证书是否过期

### 5. 性能问题

**问题**: 启用 Reqable 后网络变慢。

**解决方案**:
1. 减少捕获的请求量
2. 使用过滤器排除不必要的请求
3. 关闭不必要的功能
4. 升级计算机配置

### 6. WebSocket 消息丢失

**问题**: WebSocket 消息没有被完全捕获。

**解决方案**:
1. 确保 WebSocket 连接通过代理
2. 检查消息缓冲区设置
3. 增加消息历史记录限制
4. 检查网络连接稳定性

### 7. 请求修改不生效

**问题**: 修改的请求没有生效。

**解决方案**:
1. 确保拦截功能已启用
2. 检查拦截规则是否匹配
3. 确认修改后点击了发送
4. 检查请求是否被缓存

## 高级用法

### 环境变量管理

#### 创建环境

1. 打开环境管理器
2. 创建新环境
3. 添加环境变量

#### 使用环境变量

在请求中使用环境变量：

```bash
# 使用变量
{{base_url}}/api/users

# 环境变量定义
base_url = https://api.example.com
```

### 请求集合

#### 创建请求集合

1. 创建新的请求集合
2. 添加请求到集合
3. 组织请求结构

#### 批量执行

1. 选择请求集合
2. 点击"批量执行"
3. 查看执行结果

### 自动响应规则

#### 配置自动响应

1. 打开自动响应设置
2. 添加响应规则
3. 配置匹配条件
4. 配置响应内容

#### 使用场景

- 模拟 API 响应
- 模拟网络错误
- 模拟延迟
- 重定向请求

### 脚本支持

#### 使用脚本

Reqable 支持 JavaScript 脚本：

```javascript
// 请求脚本
request.headers['X-Custom-Header'] = 'value';

// 响应脚本
response.body = JSON.parse(response.body);
response.body.customField = 'added by script';
```

#### 脚本示例

```javascript
// 添加认证头
request.headers['Authorization'] = 'Bearer ' + env.token;

// 记录请求日志
console.log('Request:', request.method, request.url);

// 修改响应
if (response.status === 200) {
    response.body = JSON.parse(response.body);
    response.body.timestamp = Date.now();
}
```

### 插件系统

#### 安装插件

1. 打开插件管理器
2. 浏览可用插件
3. 安装所需插件

#### 常用插件

- **JSON 格式化**: 格式化 JSON 数据
- **GraphQL 支持**: 支持 GraphQL 调试
- **API 文档生成**: 自动生成 API 文档
- **性能分析**: 分析 API 性能

## 最佳实践

### 1. 合理配置过滤器

使用过滤器减少干扰：

```
# 排除静态资源
!*.css, !*.js, !*.png, !*.jpg

# 只捕获特定域名
*.api.example.com

# 排除健康检查
!/health, !/ping
```

### 2. 使用环境变量

管理不同环境的配置：

```json
{
  "development": {
    "base_url": "http://localhost:3000"
  },
  "staging": {
    "base_url": "https://staging.example.com"
  },
  "production": {
    "base_url": "https://api.example.com"
  }
}
```

### 3. 保存常用请求

将常用请求保存到集合：

1. 创建项目相关的请求集合
2. 组织请求结构
3. 添加请求描述
4. 定期更新和维护

### 4. 使用断点调试

在关键请求处设置断点：

1. 在请求 URL 上设置断点
2. 拦截请求并修改
3. 查看修改后的响应
4. 分析问题原因

### 5. 导出和分享

导出调试数据用于分享：

1. 导出为 HAR 格式
2. 生成 cURL 命令
3. 创建 API 文档
4. 分享给团队成员

## 相关资源

### 官方资源

- **官方网站**: https://reqable.com/
- **文档**: https://reqable.com/docs/
- **下载页面**: https://reqable.com/download/
- **问题反馈**: https://reqable.com/support/

### 相关工具

- **Charles**: https://www.charlesproxy.com/
- **Fiddler**: https://www.telerik.com/fiddler
- **Postman**: https://www.postman.com/
- **Insomnia**: https://insomnia.rest/

### HTTP 资源

- **HTTP 协议**: https://developer.mozilla.org/zh-CN/docs/Web/HTTP
- **REST API 设计**: https://restfulapi.net/
- **GraphQL**: https://graphql.org/

### 学习资源

- **API 调试技巧**: https://reqable.com/blog/
- **HTTP 调试指南**: https://reqable.com/docs/guides
- **WebSocket 调试**: https://reqable.com/docs/websocket

## 更新日志

### v3.1.1

- 修复了证书管理的稳定性问题
- 改进了 WebSocket 消息捕获
- 优化了请求过滤性能

### v3.1.0

- 添加了脚本支持
- 改进了 API 测试器
- 添加了插件系统

### v3.0.0

- 全新的用户界面
- 改进了性能和稳定性
- 添加了环境变量管理
- 改进了证书管理

## 总结

Reqable 是一款功能强大的 API 调试代理工具，它提供了：

- **流量捕获**: 实时捕获和分析 HTTP/HTTPS 流量
- **API 测试**: 构建和发送 API 请求
- **流量拦截**: 拦截和修改网络请求
- **WebSocket 调试**: 实时监控 WebSocket 消息
- **证书管理**: 管理 SSL/TLS 证书

对于需要调试和测试 API 的开发者，Reqable 是一个高效的选择。