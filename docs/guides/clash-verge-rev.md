# Clash Verge Rev 使用指南

## 简介

Clash Verge Rev 是 Clash Verge 的延续版本，是一款基于 Tauri 框架构建的 Clash Meta GUI 客户端。它提供了现代化的用户界面，支持多种代理协议，是功能强大的网络代理工具。

**版本**: 2.5.1
**官网**: https://github.com/clash-verge-rev/clash-verge-rev
**许可证**: GPL-3.0
**类型**: GUI 代理客户端
**框架**: Tauri
**快捷方式**: clash-verge.exe

## 主要功能

- 基于 Clash Meta 内核
- 支持多种代理协议（Shadowsocks、VMess、VLESS、Trojan、Hysteria 等）
- 现代化 Tauri 框架 GUI 界面
- 订阅管理与自动更新
- 规则模式切换（规则、全局、直连）
- TUN 模式支持
- 流量统计与监控
- DNS 配置管理
- 脚本支持
- 多配置文件管理
- 系统托盘运行
- 开机自启动

## 安装与启动

### 通过 Scoop 安装

```bash
scoop install clash-verge-rev
```

### 启动应用程序

```bash
# 直接启动
clash-verge.exe

# 或通过开始菜单快捷方式
```

### 首次启动配置

1. 启动 Clash Verge Rev
2. 导入订阅链接或配置文件
3. 选择代理节点
4. 开启系统代理或 TUN 模式

## 界面介绍

### 主界面布局

```
┌────────────────────────────────────────────┐
│  侧边栏                                    │
│  ┌──────┐                                  │
│  │ 仪表 │   主内容区域                     │
│  │ 代理 │                                  │
│  │ 订阅 │   根据选择的菜单显示不同内容      │
│  │ 规则 │                                  │
│  │ 连接 │                                  │
│  │ 日志 │                                  │
│  │ 设置 │                                  │
│  └──────┘                                  │
└────────────────────────────────────────────┘
```

### 功能菜单

```
仪表盘: 显示系统状态、流量统计、内存信息
代理: 管理和选择代理节点
订阅: 导入和管理订阅链接
规则: 查看和编辑代理规则
连接: 查看当前活动连接
日志: 查看运行日志
设置: 配置应用程序参数
```

## 订阅管理

### 导入订阅

```
1. 点击侧边栏 "订阅"
2. 点击 "新建" 按钮
3. 输入订阅名称
4. 粘贴订阅链接
5. 点击 "保存" 并等待更新
```

### 订阅设置

```
名称: 订阅的显示名称
URL: 订阅链接地址
自动更新: 启用/禁用自动更新
更新间隔: 自动更新的时间间隔（小时）
```

### 更新订阅

```
手动更新:
1. 选择要更新的订阅
2. 点击 "更新" 按钮

自动更新:
1. 编辑订阅设置
2. 启用 "自动更新"
3. 设置更新间隔
```

### 订阅转换

```
1. 点击订阅的编辑按钮
2. 启用 "订阅转换"
3. 配置转换规则
4. 保存设置
```

## 代理配置

### 代理模式

```
规则模式: 根据规则文件决定流量走向
全局模式: 所有流量通过代理
直连模式: 所有流量直接连接
```

### 切换代理模式

```
方法一: 点击主界面的模式切换按钮
方法二: 使用快捷键切换
方法三: 通过系统托盘菜单切换
```

### 选择代理节点

```
1. 点击侧边栏 "代理"
2. 查看代理节点列表
3. 点击选择节点
4. 或右键选择 "设为活动"
```

### 代理组类型

```
Select: 手动选择节点
URL-Test: 自动选择延迟最低的节点
Fallback: 按优先级选择可用节点
Load-Balance: 负载均衡分配流量
```

### 节点测速

```
1. 选择代理组
2. 点击 "测速" 按钮
3. 等待测速完成
4. 查看延迟结果
```

## TUN 模式

### 启用 TUN 模式

```
1. 进入 "设置" → "Clash 设置"
2. 找到 "TUN 模式" 选项
3. 启用 TUN 模式
4. 配置 TUN 参数
5. 保存设置
```

### TUN 配置选项

```yaml
tun:
  enable: true
  stack: gvisor
  dns-hijack:
    - any:53
  auto-route: true
  auto-detect-interface: true
```

### TUN 模式优势

```
1. 支持全局代理
2. 支持 UDP 流量
3. 无需配置系统代理
4. 支持所有应用程序
```

## DNS 配置

### DNS 设置

```
1. 进入 "设置" → "DNS 设置"
2. 配置 DNS 服务器
3. 设置 DNS 模式
4. 保存配置
```

### DNS 配置示例

```yaml
dns:
  enable: true
  listen: 0.0.0.0:53
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16
  nameserver:
    - 223.5.5.5
    - 119.29.29.29
  fallback:
    - 8.8.8.8
    - 1.1.1.1
```

### DNS 模式

```
redir-host: 使用真实 IP
fake-ip: 使用虚拟 IP（推荐）
```

## 规则管理

### 内置规则

```
DOMAIN: 域名匹配
DOMAIN-SUFFIX: 域名后缀匹配
DOMAIN-KEYWORD: 域名关键词匹配
IP-CIDR: IP 段匹配
GEOIP: GeoIP 匹配
PROCESS-NAME: 进程名匹配
```

### 自定义规则

```
1. 进入 "设置" → "覆写设置"
2. 添加自定义规则
3. 保存配置
```

### 规则示例

```yaml
rules:
  - DOMAIN-SUFFIX,google.com,Proxy
  - DOMAIN-KEYWORD,facebook,Proxy
  - IP-CIDR,192.168.0.0/16,DIRECT
  - GEOIP,CN,DIRECT
  - MATCH,Proxy
```

## 脚本功能

### 脚本配置

```
1. 进入 "设置" → "脚本"
2. 启用脚本功能
3. 编写或导入脚本
4. 保存并应用
```

### 脚本示例

```javascript
export default function main(config) {
  // 修改配置
  config["dns"]["enable"] = true;
  
  // 添加规则
  config["rules"].unshift("DOMAIN-SUFFIX,example.com,DIRECT");
  
  return config;
}
```

## 流量监控

### 实时流量

```
1. 查看仪表盘的流量图表
2. 显示上传/下载速度
3. 显示总流量统计
```

### 连接监控

```
1. 点击侧边栏 "连接"
2. 查看所有活动连接
3. 显示连接详情
4. 支持断开连接
```

## 系统托盘

### 托盘功能

```
显示主窗口: 双击托盘图标
代理模式: 右键切换模式
选择节点: 右键选择节点
系统代理: 右键开关
TUN 模式: 右键开关
退出: 右键退出程序
```

### 托盘图标状态

```
蓝色: 代理已启用
灰色: 代理已禁用
绿色: TUN 模式启用
```

## 配置文件

### 配置文件位置

```
Windows: %USERPROFILE%\.config\clash-verge\
```

### Verge 配置文件

```yaml
app_log_level: info
auto_check_update: true
auto_close_connections: true
auto_detect_concurrent: null
clash_core: clash-meta
enable_auto_switch: false
enable_clash_fields: true
enable_global_hotkey: false
enable_service_mode: false
enable_system_proxy: false
enable_tun_mode: false
hotkey_config: null
language: zh-CN
theme_mode: system
theme_setting:
  primary_color: "#7878ff"
  secondary_color: "#7878ff"
traffic_graph: true
tray_event: main_window
tray_proxy: false
window_position: null
window_size: null
```

## 快捷键

### 全局快捷键

```
Ctrl+Shift+E          显示/隐藏主窗口
Ctrl+Shift+S          开关系统代理
Ctrl+Shift+T          开关 TUN 模式
Ctrl+Shift+G          切换代理模式
```

### 应用内快捷键

```
Ctrl+R                刷新配置
Ctrl+S                保存配置
Ctrl+Z                撤销
Ctrl+Y                重做
F5                    刷新订阅
```

## 常见问题

### 1. 无法连接代理

```
可能原因:
- 订阅已过期
- 节点不可用
- 网络连接问题
- 防火墙阻止

解决方法:
1. 更新订阅
2. 切换其他节点
3. 检查网络连接
4. 添加防火墙例外
5. 检查端口是否被占用
```

### 2. TUN 模式无法启动

```
可能原因:
- 缺少管理员权限
- TUN 驱动问题
- 其他 VPN 软件冲突

解决方法:
1. 以管理员权限运行
2. 重装 TUN 驱动
3. 关闭其他 VPN 软件
4. 检查系统网络适配器
```

### 3. 网速变慢

```
可能原因:
- 节点负载过高
- DNS 解析慢
- 规则配置不当

解决方法:
1. 切换到其他节点
2. 优化 DNS 配置
3. 使用 URL-Test 自动选择
4. 检查规则配置
```

### 4. 部分应用无法代理

```
可能原因:
- 应用不使用系统代理
- 需要 TUN 模式
- 规则未匹配

解决方法:
1. 启用 TUN 模式
2. 添加应用规则
3. 使用全局模式测试
4. 检查进程名匹配规则
```

### 5. 配置文件错误

```
可能原因:
- YAML 语法错误
- 配置字段不兼容
- 缺少必要字段

解决方法:
1. 检查 YAML 语法
2. 参考官方文档
3. 使用在线 YAML 校验
4. 恢复默认配置
```

### 6. 订阅更新失败

```
可能原因:
- 网络连接问题
- 订阅链接失效
- 服务器返回错误

解决方法:
1. 检查网络连接
2. 验证订阅链接
3. 手动下载配置
4. 联系订阅提供商
```

## 高级配置

### 覆写设置

```yaml
# 覆写 DNS 配置
dns:
  enable: true
  enhanced-mode: fake-ip

# 覆写规则
rules:
  - DOMAIN-SUFFIX,google.com,Proxy

# 覆写代理组
proxy-groups:
  - name: "Proxy"
    type: select
    proxies:
      - Node1
      - Node2
```

### Mixin 配置

```
1. 进入 "设置" → "Mixins"
2. 添加覆写规则
3. 保存并应用
```

## 故障排除

### 查看日志

```
1. 点击侧边栏 "日志"
2. 选择日志级别
3. 查看详细日志信息
4. 导出日志文件
```

### 重置配置

```
1. 关闭 Clash Verge Rev
2. 删除配置文件夹
3. 重新启动应用程序
4. 重新导入订阅
```

### 内核切换

```
1. 进入 "设置" → "Clash 设置"
2. 选择 Clash 内核
3. 重启应用程序
```

## 系统集成

### 开机自启

```
1. 进入 "设置" → "通用设置"
2. 启用 "开机自启动"
3. 选择启动方式
```

### 系统代理

```
Windows 设置:
1. 打开 Windows 设置
2. 进入 "网络和 Internet" → "代理"
3. 查看代理设置是否正确
```

### 第三方应用配置

```
浏览器:
1. 安装代理切换插件
2. 配置代理服务器
3. 设置为系统代理模式

终端:
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
```

## 相关资源

- [Clash Verge Rev GitHub](https://github.com/clash-verge-rev/clash-verge-rev)
- [Clash Verge Rev Releases](https://github.com/clash-verge-rev/clash-verge-rev/releases)
- [Clash Meta 文档](https://wiki.metacubex.one/)
- [Tauri 官方文档](https://tauri.app/)
- [Clash 规则文档](https://wiki.metacubex.one/config/)
