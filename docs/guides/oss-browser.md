# OSS Browser 使用指南

> 版本：v1.19.0 | 许可证：Apache-2.0 | 官网：https://github.com/aliyun/oss-browser

---

## 简介

OSS Browser 是阿里云官方推出的对象存储服务（OSS）桌面客户端工具，提供了图形化界面来管理阿里云 OSS 中的文件和存储桶。通过 OSS Browser，用户可以方便地进行文件上传、下载、删除、复制等操作，无需编写代码或使用命令行工具。

阿里云对象存储服务（Alibaba Cloud Object Storage Service，简称 OSS）是一种海量、安全、低成本、高可靠的云存储服务，适合存放任意类型的文件，常用于网站图片、视频、日志文件、备份数据等场景。

### 核心特性

- **图形界面**：直观易用的文件管理界面
- **批量操作**：支持批量上传、下载、删除文件
- **多账号管理**：支持多个阿里云账号切换
- **大文件分片**：自动分片上传大文件
- **断点续传**：支持上传/下载断点续传
- **文件预览**：支持图片、视频等文件预览
- **权限管理**：支持 STS 临时授权和 RAM 子账号
- **跨平台**：支持 Windows、macOS、Linux
- **开源免费**：Apache-2.0 许可证

### 适用场景

- 网站静态资源管理
- 备份数据存储和管理
- 多媒体文件管理
- 日志文件归档
- 数据迁移
- 开发测试环境文件管理
- 内容分发资源管理

---

## 主要功能

### 1. 存储桶管理

管理 OSS 存储空间：

- 创建存储桶
- 删除存储桶
- 查看存储桶属性
- 配置存储桶权限
- 设置跨域规则（CORS）
- 配置生命周期规则
- 设置静态网站托管

### 2. 文件管理

管理存储桶中的文件（Object）：

- 浏览文件列表
- 上传文件
- 下载文件
- 删除文件
- 复制/移动文件
- 重命名文件
- 创建文件夹
- 查看文件详情

### 3. 大文件处理

处理大文件的上传和下载：

- 自动分片上传
- 断点续传
- 并行上传/下载
- 进度显示

### 4. 批量操作

一次性处理多个文件：

- 批量上传
- 批量下载
- 批量删除
- 批量复制/移动

### 5. 文件预览

在线预览多种文件类型：

- 图片预览（JPG、PNG、GIF 等）
- 视频预览（MP4 等）
- 音频预览（MP3 等）
- 文本文件预览
- PDF 预览

### 6. 账号管理

管理阿里云账号和认证：

- AccessKey ID/Secret 认证
- STS 临时凭证
- RAM 子账号认证
- 多账号切换
- 账号信息保存

### 7. 高级功能

- 自定义域名配置
- 传输设置（并发数、分片大小）
- 日志查看
- 版本控制
- 服务端加密

---

## 常用操作

### 启动应用

```powershell
# 从开始菜单或桌面快捷方式启动
# 或从 Scoop 安装目录运行
& "$env:USERPROFILE\scoop\apps\oss-browser\current\OSS Browser.exe"
```

### 账号配置

#### 使用 AccessKey 登录

1. 启动 OSS Browser
2. 在登录界面选择「AccessKey 登录」
3. 输入以下信息：
   - AccessKey ID：阿里云账号的 AccessKey ID
   - AccessKey Secret：阿里云账号的 AccessKey Secret
   - 区域：选择 OSS 服务所在的区域（Endpoint）
4. 点击「登录」

#### 使用 STS 临时凭证登录

1. 从应用服务器获取 STS 临时凭证
2. 在登录界面选择「STS 登录」
3. 输入以下信息：
   - AccessKey ID
   - AccessKey Secret
   - Security Token
   - 区域
4. 点击「登录」

#### 多账号管理

- 在设置中可以保存多个账号信息
- 通过账号切换功能快速切换不同账号
- 建议使用 RAM 子账号而非主账号

### 存储桶操作

#### 创建存储桶

1. 登录后进入主界面
2. 点击「新建 Bucket」按钮
3. 输入存储桶名称
4. 选择区域（Region）
5. 选择存储类型（标准/低频/归档/冷归档）
6. 设置读写权限（私有/公共读/公共读写）
7. 点击「确定」

#### 存储桶属性配置

- **基础属性**：查看存储桶名称、区域、创建时间等
- **权限设置**：配置 ACL 访问控制
- **跨域设置**：配置 CORS 规则
- **静态网站**：配置静态网站托管
- **生命周期**：设置文件自动过期规则
- **防盗链**：配置 Referer 白名单

### 文件操作

#### 上传文件

1. 进入目标存储桶或文件夹
2. 点击「上传」按钮
3. 选择「上传文件」或「上传文件夹」
4. 选择要上传的文件/文件夹
5. 等待上传完成

**上传选项：**

- 自动重命名：避免文件名冲突
- 覆盖已有文件：替换同名文件
- 设置文件权限：私有/公共读

#### 下载文件

1. 选中要下载的文件（可多选）
2. 点击「下载」按钮
3. 选择本地保存路径
4. 等待下载完成

#### 删除文件

1. 选中要删除的文件（可多选）
2. 点击「删除」按钮
3. 确认删除操作

#### 复制/移动文件

1. 选中要操作的文件
2. 点击「复制」或「移动」按钮
3. 选择目标存储桶和文件夹
4. 确认操作

#### 文件重命名

1. 右键点击文件
2. 选择「重命名」
3. 输入新文件名
4. 确认修改

### 批量操作

#### 批量上传

- 可以直接将文件/文件夹拖拽到 OSS Browser 窗口
- 支持选择整个文件夹上传
- 自动保持目录结构

#### 批量下载

- 选中多个文件后点击下载
- 或选中文件夹下载整个目录

#### 批量删除

- 选中多个文件后点击删除
- 确认后批量删除

### 文件预览

1. 双击支持预览的文件
2. 在预览窗口查看文件内容
3. 支持的格式：
   - 图片：JPG、PNG、GIF、BMP、WebP
   - 视频：MP4、WebM
   - 音频：MP3、WAV
   - 文本：TXT、JSON、XML、CSV、MD
   - 文档：PDF

### 设置选项

#### 传输设置

- 最大并发上传/下载数
- 分片大小设置
- 上传/下载限速
- 代理设置

#### 界面设置

- 语言选择
- 主题设置
- 列表视图/图标视图切换
- 排序方式

#### 高级设置

- 自动更新检查
- 日志级别
- 缓存管理
- 证书管理

---

## 常见问题

### Q1: 无法登录 OSS Browser 怎么办？

**排查步骤：**

1. **检查 AccessKey**：
   - 确认 AccessKey ID 和 Secret 输入正确
   - 确认 AccessKey 未被禁用或删除
   - 检查是否有 OSS 访问权限

2. **检查网络**：
   - 确认网络连接正常
   - 如果使用代理，检查代理配置
   - 尝试更换网络环境

3. **检查区域设置**：
   - 确认选择的 Endpoint 与存储桶所在区域一致
   - 可以在阿里云控制台查看 Endpoint

4. **检查账号状态**：
   - 确认阿里云账号状态正常
   - 确认 OSS 服务已开通
   - 检查是否欠费

### Q2: 上传速度很慢怎么办？

1. **调整并发数**：在设置中增加上传并发数
2. **调整分片大小**：适当增大分片大小
3. **检查网络带宽**：确认网络上行带宽充足
4. **使用就近区域**：选择离自己最近的 OSS 区域
5. **避免高峰期**：错峰上传大文件

### Q3: 上传大文件失败怎么办？

1. **检查文件大小限制**：单个文件最大支持 48.8TB
2. **调整分片大小**：适当调整分片大小设置
3. **检查存储空间**：确认存储桶有足够的剩余空间
4. **检查账号配额**：确认未超出账号配额限制
5. **使用断点续传**：利用断点续传功能继续未完成的上传

### Q4: 如何设置文件的公共访问权限？

**方法一：设置单个文件权限**
1. 选中文件
2. 右键选择「设置权限」
3. 选择「公共读」

**方法二：设置存储桶权限**
1. 进入存储桶属性
2. 选择「权限设置」
3. 修改 ACL 为「公共读」

**方法三：使用自定义域名**
1. 绑定自定义域名
2. 配置 CNAME 解析
3. 通过自定义域名访问

### Q5: 如何批量修改文件权限？

1. 选中多个文件
2. 右键选择「设置权限」
3. 选择目标权限
4. 确认修改

### Q6: 如何配置跨域访问（CORS）？

1. 进入存储桶属性
2. 选择「跨域设置」
3. 添加 CORS 规则：
   - 来源（AllowedOrigin）
   - 方法（AllowedMethod）
   - 头部（AllowedHeader）
   - 暴露头部（ExposeHeader）
   - 缓存时间（MaxAgeSeconds）

### Q7: 如何使用生命周期管理文件？

1. 进入存储桶属性
2. 选择「生命周期」
3. 添加规则：
   - 前缀匹配：指定文件路径前缀
   - 转换为低频存储：设置天数
   - 转换为归档存储：设置天数
   - 过期删除：设置天数

---

## 相关资源

### 官方资源

- OSS Browser GitHub：https://github.com/aliyun/oss-browser
- 发布页面：https://github.com/aliyun/oss-browser/releases
- 问题反馈：https://github.com/aliyun/oss-browser/issues

### 阿里云 OSS 资源

- 阿里云 OSS 官网：https://www.aliyun.com/product/oss
- OSS 文档：https://help.aliyun.com/product/31815.html
- OSS API 参考：https://help.aliyun.com/document_detail/31948.html
- OSS SDK：https://help.aliyun.com/document_detail/32007.html

### 命令行工具

- ossutil（阿里云官方命令行工具）：https://help.aliyun.com/document_detail/120075.html
- aliyun-cli（阿里云 CLI）：https://github.com/aliyun/aliyun-cli

### SDK 资源

- Python SDK（oss2）：https://github.com/aliyun/aliyun-oss-python-sdk
- Java SDK：https://github.com/aliyun/aliyun-oss-java-sdk
- Node.js SDK（ali-oss）：https://github.com/aliyun/aliyun-oss-nodejs-sdk
- Go SDK：https://github.com/aliyun/alibabacloud-oss-go-sdk
- C# SDK：https://github.com/aliyun/aliyun-oss-csharp-sdk

### 其他管理工具

- ossbrowser（Web 版）：https://oss.console.aliyun.com/
- 阿里云控制台：https://home.console.aliyun.com/

### 学习资源

- OSS 入门教程：https://help.aliyun.com/document_detail/31883.html
- OSS 最佳实践：https://help.aliyun.com/document_detail/31896.html
- OSS 安全指南：https://help.aliyun.com/document_detail/31867.html
- OSS 常见问题：https://help.aliyun.com/document_detail/31826.html
