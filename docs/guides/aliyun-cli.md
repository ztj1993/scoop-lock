# Aliyun CLI 使用指南

## 简介

Aliyun CLI 是阿里巴巴云官方提供的命令行工具，用于管理阿里云服务。它是用 Go 语言开发的开源项目，支持在 Windows、macOS 和 Linux 等多个平台上运行。

Aliyun CLI 提供了与阿里云控制台相同的功能，允许用户通过命令行界面管理各种云服务，包括 ECS、RDS、OSS、SLB 等。对于习惯使用命令行的开发者和运维人员来说，这是一个高效管理云资源的利器。

**主要特性：**
- 开源项目，代码托管在 GitHub
- 支持阿里云所有主要服务
- 提供自动补全功能
- 支持多种认证方式
- 跨平台支持

**官方网站：** https://github.com/aliyun/aliyun-cli

---

## 主要功能

### 1. 云服务器管理
通过 Aliyun CLI 可以创建、启动、停止、重启和删除 ECS 实例，管理安全组、快照和镜像等资源。

### 2. 对象存储管理
支持 OSS 桶的创建和管理，文件的上传、下载、复制和删除操作，以及权限和生命周期管理。

### 3. 数据库管理
可以管理 RDS 实例，包括创建数据库、备份恢复、参数配置等操作。

### 4. 网络配置
支持 VPC、EIP、NAT 网关、SLB 等网络资源的配置和管理。

### 5. 监控与日志
可以查看云监控数据、配置报警规则、管理日志服务等。

### 6. 身份与访问管理
支持 RAM 用户、角色和策略的管理，实现精细化的权限控制。

---

## 常用命令/操作

### 安装与配置

```bash
# 通过 Scoop 安装 Aliyun CLI
scoop install aliyun-cli

# 配置认证信息
aliyun configure

# 查看当前配置
aliyun configure list

# 指定 profile 配置
aliyun configure --profile <profile名称>

# 设置默认输出格式
aliyun configure set --output json

# 设置默认语言
aliyun configure set --language zh
```

### 基础命令格式

```bash
# 基本语法
aliyun <产品名> <API名称> [参数]

# 查看帮助
aliyun help
aliyun <产品名> help
aliyun <产品名> <API名称> help

# 查看版本
aliyun version
```

### ECS 云服务器操作

```bash
# 查看实例列表
aliyun ecs DescribeInstances --RegionId cn-hangzhou

# 创建实例
aliyun ecs CreateInstance \
  --RegionId cn-hangzhou \
  --ImageId ubuntu_20_04_x64_20G_alibase_20210420.vhd \
  --InstanceType ecs.t6-c1m1.large \
  --SecurityGroupId <安全组ID>

# 启动实例
aliyun ecs StartInstance --InstanceId <实例ID>

# 停止实例
aliyun ecs StopInstance --InstanceId <实例ID>

# 重启实例
aliyun ecs RebootInstance --InstanceId <实例ID>

# 删除实例
aliyun ecs DeleteInstance --InstanceId <实例ID> --Force true

# 查看实例状态
aliyun ecs DescribeInstanceStatus --RegionId cn-hangzhou

# 查看可用区
aliyun ecs DescribeZones --RegionId cn-hangzhou

# 查看镜像列表
aliyun ecs DescribeImages --RegionId cn-hangzhou

# 创建快照
aliyun ecs CreateSnapshot --DiskId <磁盘ID> --SnapshotName <快照名称>
```

### OSS 对象存储操作

```bash
# 创建存储桶
aliyun oss mb oss://<桶名称>

# 列出存储桶
aliyun oss ls

# 列出桶内文件
aliyun oss ls oss://<桶名称>

# 上传文件
aliyun oss put <本地文件> oss://<桶名称>/<目标路径>

# 下载文件
aliyun oss get oss://<桶名称>/<文件路径> <本地路径>

# 复制文件
aliyun oss cp oss://<源桶>/<源文件> oss://<目标桶>/<目标文件>

# 删除文件
aliyun oss rm oss://<桶名称>/<文件路径>

# 删除存储桶
aliyun oss rb oss://<桶名称>

# 设置桶权限
aliyun oss set-acl oss://<桶名称> public-read

# 生成签名 URL
aliyun oss sign oss://<桶名称>/<文件路径> --timeout 3600
```

### RDS 数据库操作

```bash
# 查看 RDS 实例列表
aliyun rds DescribeDBInstances --RegionId cn-hangzhou

# 创建数据库
aliyun rds CreateDatabase \
  --DBInstanceId <实例ID> \
  --DBName <数据库名称> \
  --CharacterSetName utf8mb4

# 创建账号
aliyun rds CreateAccount \
  --DBInstanceId <实例ID> \
  --AccountName <账号名称> \
  --AccountPassword <密码>

# 备份数据库
aliyun rds CreateBackup \
  --DBInstanceId <实例ID> \
  --BackupType FullBackup

# 查看备份列表
aliyun rds DescribeBackups --DBInstanceId <实例ID>
```

### SLB 负载均衡操作

```bash
# 查看负载均衡实例
aliyun slb DescribeLoadBalancers --RegionId cn-hangzhou

# 创建负载均衡实例
aliyun slb CreateLoadBalancer \
  --RegionId cn-hangzhou \
  --LoadBalancerName <名称> \
  --AddressType internet

# 添加后端服务器
aliyun slb AddBackendServers \
  --LoadBalancerId <实例ID> \
  --BackendServers '[{"ServerId":"<ECS实例ID>","Weight":"100"}]'

# 创建监听
aliyun slb CreateLoadBalancerHTTPListener \
  --LoadBalancerId <实例ID> \
  --ListenerPort 80 \
  --BackendServerPort 80 \
  --Bandwidth -1
```

### VPC 专有网络操作

```bash
# 查看 VPC 列表
aliyun vpc DescribeVpcs --RegionId cn-hangzhou

# 创建 VPC
aliyun vpc CreateVpc \
  --RegionId cn-hangzhou \
  --CidrBlock 172.16.0.0/12

# 创建交换机
aliyun vpc CreateVSwitch \
  --VpcId <VPC ID> \
  --CidrBlock 172.16.0.0/24 \
  --ZoneId cn-hangzhou-b

# 分配弹性公网 IP
aliyun vpc AllocateEipAddress --RegionId cn-hangzhou

# 绑定弹性公网 IP
aliyun vpc AssociateEipAddress \
  --AllocationId <EIP ID> \
  --InstanceId <实例ID>
```

### RAM 访问控制操作

```bash
# 创建 RAM 用户
aliyun ram CreateUser --UserName <用户名>

# 创建用户组
aliyun ram CreateGroup --GroupName <组名>

# 添加用户到组
aliyun ram AddUserToGroup --UserName <用户名> --GroupName <组名>

# 创建自定义策略
aliyun ram CreatePolicy \
  --PolicyName <策略名称> \
  --PolicyDocument <策略文档>

# 附加策略到用户
aliyun ram AttachPolicyToUser \
  --PolicyName <策略名称> \
  --PolicyType Custom \
  --UserName <用户名>

# 创建 AccessKey
aliyun ram CreateAccessKey --UserName <用户名>

# 删除 AccessKey
aliyun ram DeleteAccessKey \
  --UserName <用户名> \
  --AccessKeyId <AccessKey ID>
```

### 高级用法

```bash
# 使用 JMESPath 过滤输出
aliyun ecs DescribeInstances --RegionId cn-hanghou \
  --output cols=InstanceId,InstanceName rows=Instances.Instance[]

# 使用 --wait 等待操作完成
aliyun ecs StartInstance --InstanceId <实例ID> --wait

# 指定输出格式
aliyun ecs DescribeInstances --RegionId cn-hangzhou --output cols=InstanceId,Status

# 使用文件作为参数
aliyun ecs CreateInstance --cli-file://config.json

# 批量操作（结合脚本）
for id in $(aliyun ecs DescribeInstances --RegionId cn-hangzhou \
  --output rows=Instances.Instance[].InstanceId); do
  echo "Processing instance: $id"
done
```

---

## 常见问题

### Q1: 如何获取阿里云 AccessKey？

**获取步骤：**
1. 登录阿里云控制台
2. 点击右上角头像 → "AccessKey 管理"
3. 点击"创建 AccessKey"
4. 保存 AccessKey ID 和 AccessKey Secret

**安全建议：**
- 不要将 AccessKey 硬编码在脚本中
- 使用 RAM 用户的 AccessKey，避免使用主账号
- 定期轮换 AccessKey
- 为 AccessKey 设置最小权限

### Q2: 如何解决 "InvalidAccessKey.NotFound" 错误？

此错误通常表示 AccessKey ID 不正确或已失效。请检查：

1. AccessKey ID 是否正确复制（注意前后空格）
2. AccessKey 是否已过期或被删除
3. 是否使用了正确的 Profile

```bash
# 重新配置
aliyun configure --profile <profile名称>

# 验证配置
aliyun configure list
```

### Q3: 如何处理 "Forbidden.RAM" 权限不足错误？

**解决方案：**
1. 检查 RAM 用户是否有相应的权限策略
2. 联系主账号管理员分配必要的权限
3. 使用 RAM 控制台查看和管理权限

```bash
# 查看当前用户信息
aliyun ram GetCurrentUser

# 查看用户权限
aliyun ram ListPoliciesForUser --UserName <用户名>
```

### Q4: 如何在 CI/CD 环境中使用 Aliyun CLI？

**方法一：环境变量**
```bash
export ALIBABA_CLOUD_ACCESS_KEY_ID=<AccessKey ID>
export ALIBABA_CLOUD_ACCESS_KEY_SECRET=<AccessKey Secret>
export ALIBABA_CLOUD_REGION_ID=cn-hangzhou
```

**方法二：配置文件**
```bash
aliyun configure set \
  --profile default \
  --mode AK \
  --access-key-id <AccessKey ID> \
  --access-key-secret <AccessKey Secret> \
  --region cn-hangzhou
```

### Q5: 如何切换阿里云区域（Region）？

```bash
# 方法一：通过配置切换
aliyun configure set --region <region ID>

# 方法二：命令行参数
aliyun ecs DescribeInstances --RegionId <region ID>

# 查看所有可用区域
aliyun ecs DescribeRegions
```

### Q6: 如何处理 API 调用超时？

1. 检查网络连接
2. 增加超时时间设置
3. 使用 VPN 或专线连接
4. 检查安全组和防火墙设置

### Q7: 如何调试 API 调用问题？

```bash
# 启用调试模式
aliyun configure set --mode AK --debug

# 查看完整的请求和响应
aliyun ecs DescribeInstances --RegionId cn-hangzhou --debug

# 使用 --verbose 查看详细信息
aliyun ecs DescribeInstances --RegionId cn-hangzhou --verbose
```

### Q8: 如何批量管理云资源？

可以结合 Shell 脚本实现批量操作：

```bash
# 批量停止所有 ECS 实例
for instance in $(aliyun ecs DescribeInstances --RegionId cn-hangzhou \
  --output rows=Instances.Instance[].InstanceId); do
  aliyun ecs StopInstance --InstanceId $instance
done

# 使用 jq 处理 JSON 输出
aliyun ecs DescribeInstances --RegionId cn-hangzhou | \
  jq '.Instances.Instance[] | select(.Status == "Running")'
```

---

## 相关资源

### 官方资源
- [Aliyun CLI GitHub 仓库](https://github.com/aliyun/aliyun-cli)
- [阿里云官方文档](https://help.aliyun.com/)
- [阿里云 API 参考](https://help.aliyun.com/product/28625.html)

### 安装与配置
- [Aliyun CLI 安装指南](https://github.com/aliyun/aliyun-cli/blob/master/README-CN.md)
- [Scoop 包管理器](https://scoop.sh/)

### 学习资源
- [阿里云开发者社区](https://developer.aliyun.com/)
- [阿里云 CLI 使用教程](https://help.aliyun.com/document_detail/120381.html)
- [阿里云最佳实践](https://help.aliyun.com/solution-best-practice/)

### API 相关
- [ECS API 参考](https://help.aliyun.com/document_detail/25490.html)
- [OSS API 参考](https://help.aliyun.com/document_detail/31948.html)
- [RDS API 参考](https://help.aliyun.com/document_detail/26232.html)

### 社区与支持
- [阿里云开发者论坛](https://bbs.aliyun.com/)
- [Stack Overflow 阿里云标签](https://stackoverflow.com/questions/tagged/alibaba-cloud)
- [GitHub Issues](https://github.com/aliyun/aliyun-cli/issues)

### 工具与集成
- [Terraform 阿里云 Provider](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
- [Ansible 阿里云模块](https://docs.ansible.com/ansible/latest/collections/alibaba/alibaba_cloud/index.html)
- [Pulumi 阿里云 SDK](https://www.pulumi.com/registry/packages/alicloud/)

---

## 更新日志

### 最新版本
- 新增更多 API 支持
- 优化命令行交互体验
- 修复已知问题
- 改进文档和示例

---

*本文档最后更新于：2026年5月27日*
