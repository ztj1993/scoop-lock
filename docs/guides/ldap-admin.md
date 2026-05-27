# LDAP Admin 使用指南

## 简介

LDAP Admin 是一款功能强大的 LDAP 客户端和管理工具，专为 LDAP 目录服务的管理而设计。它提供了直观的图形界面，使管理员能够轻松地浏览、编辑和管理 LDAP 目录。

- **版本**: v1.8.3
- **许可证**: GPL-2.0
- **官方描述**: "An LDAP client and administration tool for LDAP directory management"
- **官方网站**: http://ldapadmin.org/
- **可执行文件**: LdapAdmin.exe
- **类型**: 图形界面（GUI）工具
- **语言支持**: 支持中文界面

LDAP Admin 支持多种 LDAP 服务器，包括 OpenLDAP、Microsoft Active Directory、Novell eDirectory、Apache Directory Server 等。它是系统管理员管理目录服务的得力助手。

## 主要功能

### 目录浏览

LDAP Admin 提供了类似 Windows 资源管理器的树状视图，可以直观地浏览 LDAP 目录结构。支持展开和折叠目录节点，查看每个节点的属性和值。

### 条目管理

- **创建条目**: 支持创建新的 LDAP 条目，可以选择多种对象类模板
- **编辑条目**: 修改现有条目的属性值
- **删除条目**: 删除不需要的条目，支持级联删除
- **复制条目**: 复制现有条目并修改为新条目
- **移动条目**: 在目录树中移动条目的位置

### 模式浏览

查看 LDAP 服务器的模式（Schema）定义，包括：

- 对象类（ObjectClass）定义
- 属性类型（AttributeType）定义
- 语法定义
- 匹配规则

### 搜索功能

LDAP Admin 提供了强大的 LDAP 搜索功能：

- 基础搜索：按属性值搜索
- 高级搜索：使用 LDAP 过滤器进行复杂搜索
- 搜索范围：基础（Base）、一层（One Level）、子树（Subtree）
- 搜索结果导出

### LDIF 导入导出

支持 LDIF（LDAP Data Interchange Format）格式的导入和导出：

- 导出整个目录或部分目录到 LDIF 文件
- 从 LDIF 文件导入数据到目录
- 支持批量操作

### 用户和组管理

专门针对用户和组的管理功能：

- 创建和管理用户账号
- 创建和管理用户组
- 管理组成员关系
- 用户密码管理

### 批量操作

支持批量处理多个条目：

- 批量修改属性
- 批量删除
- 批量移动
- 批量导入

### 连接管理

- 支持保存多个服务器连接配置
- 支持 SSL/TLS 加密连接
- 支持 SASL 认证
- 支持匿名绑定和认证绑定

### 中文语言支持

LDAP Admin 内置了中文语言包，可以在选项中切换为中文界面，方便中文用户使用。

## 常用命令/操作

### 启动程序

通过 scoop 安装后，直接运行：

```bash
LdapAdmin.exe
```

或从开始菜单找到 LDAP Admin 快捷方式。

### 配置新连接

1. 打开 LDAP Admin 后，点击菜单 "连接" -> "新建连接"
2. 填写连接信息：
   - **连接名称**: 为连接起一个便于识别的名称
   - **主机**: LDAP 服务器的地址（IP 或域名）
   - **端口**: 默认 389（LDAP）或 636（LDAPS）
   - **Base DN**: 基础区分名，如 `dc=example,dc=com`
   - **用户名**: 绑定 DN，如 `cn=admin,dc=example,dc=com`
   - **密码**: 绑定密码
3. 点击 "测试连接" 验证配置
4. 点击 "确定" 保存连接

### 浏览目录

1. 双击已保存的连接或右键选择 "连接"
2. 在左侧面板中展开目录树
3. 点击任意节点查看其属性
4. 在右侧面板中查看和编辑属性值

### 创建新条目

1. 在目录树中右键点击父节点
2. 选择 "新建" -> "条目"
3. 选择对象类（如 inetOrgPerson、groupOfNames 等）
4. 填写必需属性（如 cn、sn、uid 等）
5. 添加其他可选属性
6. 点击 "确定" 创建条目

### 搜索条目

1. 点击工具栏上的搜索图标或按 Ctrl+F
2. 设置搜索参数：
   - **搜索基**: 搜索的起始节点
   - **范围**: Base/One Level/Subtree
   - **过滤器**: LDAP 过滤器，如 `(uid=john)` 或 `(&(objectClass=person)(cn=*张*))`
3. 点击 "搜索" 执行
4. 在结果面板中查看搜索结果

### 编辑属性

1. 在右侧面板中选择要编辑的属性
2. 双击值区域进入编辑模式
3. 修改值内容
4. 按 Enter 确认或点击其他位置保存
5. 点击工具栏的 "保存" 按钮提交更改到服务器

### 导出 LDIF

1. 选择要导出的节点
2. 右键选择 "导出" -> "LDIF 导出"
3. 选择导出范围和选项
4. 指定保存路径和文件名
5. 点击 "导出" 完成

### 导入 LDIF

1. 点击菜单 "工具" -> "LDIF 导入"
2. 选择要导入的 LDIF 文件
3. 预览导入内容
4. 确认导入操作

### 管理用户密码

1. 在目录树中找到用户条目
2. 右键选择 "设置密码"
3. 输入新密码并确认
4. 点击 "确定" 保存

### 切换中文界面

1. 点击菜单 "Tools" -> "Options"（或 "工具" -> "选项"）
2. 在 "Language"（语言）选项中选择 "Chinese (Simplified)"
3. 重启 LDAP Admin 生效

## 常见问题

### Q: 无法连接到 LDAP 服务器怎么办？

检查以下几点：

- 确认 LDAP 服务器正在运行
- 确认主机地址和端口正确
- 检查防火墙是否允许 LDAP 端口（389/636）
- 如果使用 LDAPS，确认证书配置正确
- 验证绑定 DN 和密码是否正确

### Q: 搜索结果为空怎么办？

- 检查 Base DN 是否正确
- 确认搜索范围是否合适（尝试使用 Subtree）
- 验证搜索过滤器语法是否正确
- 确认搜索的用户有权限查看目标条目

### Q: 提示权限不足怎么办？

- 确认绑定用户有足够的权限执行该操作
- 检查 LDAP 服务器的 ACL（访问控制列表）配置
- 使用管理员账号登录
- 联系目录管理员授予相应权限

### Q: 如何备份 LDAP 目录？

使用 LDIF 导出功能备份：

1. 右键点击目录根节点
2. 选择 "导出" -> "LDIF 导出"
3. 选择导出范围为整个目录
4. 保存 LDIF 文件到安全位置

也可以使用 `slapcat`（OpenLDAP）或 `ldifde`（Active Directory）等命令行工具。

### Q: 如何导入大量用户？

使用 LDIF 文件批量导入：

1. 准备 LDIF 格式的用户数据文件
2. 使用 "工具" -> "LDIF 导入" 功能
3. 预览并确认导入内容
4. 执行导入

LDIF 文件格式示例：

```ldif
dn: uid=user1,ou=People,dc=example,dc=com
objectClass: inetOrgPerson
objectClass: posixAccount
cn: User One
sn: One
uid: user1
userPassword: password123
```

### Q: 支持哪些 LDAP 服务器？

LDAP Admin 支持所有符合 LDAP 标准的服务器，包括但不限于：

- OpenLDAP
- Microsoft Active Directory
- Apache Directory Server
- Novell eDirectory
- Oracle Internet Directory
- 389 Directory Server
- OpenDJ

### Q: 连接超时怎么办？

- 检查网络连接是否稳定
- 增加连接超时时间（在连接设置中调整）
- 确认 LDAP 服务器负载情况
- 尝试使用 IP 地址代替域名

### Q: 如何使用 SSL/TLS 加密连接？

在连接配置中：

1. 将端口改为 636（LDAPS）或在 389 端口上启用 StartTLS
2. 勾选 "SSL" 或 "TLS" 选项
3. 如果需要，导入服务器证书
4. 测试连接确保配置正确

## 相关资源

- **官方网站**: http://ldapadmin.org/
- **下载页面**: http://ldapadmin.org/download.html
- **GPL-2.0 许可证**: https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
- **LDAP 协议规范 (RFC 4511)**: https://tools.ietf.org/html/rfc4511
- **OpenLDAP 官网**: https://www.openldap.org/
- **Microsoft Active Directory 文档**: https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/
- **LDIF 格式规范 (RFC 2849)**: https://tools.ietf.org/html/rfc2849
- **Scoop 包管理器**: https://scoop.sh/
- **Apache Directory Studio（替代工具）**: https://directory.apache.org/studio/
- **OpenDJ 目录服务**: https://opendj.forgerock.org/
- **389 Directory Server**: https://www.port389.org/
- **RFC 2251（LDAPv3 协议）**: https://tools.ietf.org/html/rfc2251
- **RFC 2252（LDAP 属性语法）**: https://tools.ietf.org/html/rfc2252
- **RFC 2253（LDAP 可分辨名）**: https://tools.ietf.org/html/rfc2253
- **RFC 2254（LDAP 搜索过滤器）**: https://tools.ietf.org/html/rfc2254
- **RFC 2255（LDAP URL 格式）**: https://tools.ietf.org/html/rfc2255
- **RFC 2256（LDAP v3 Schema 摘要）**: https://tools.ietf.org/html/rfc2256
