# OVF Tool 使用指南

> 版本：v4.6.2 | 许可证：Proprietary | 官网：https://developer.vmware.com/web/tool/4.6.2/ovf-tool

---

## 简介

OVF Tool（Open Virtualization Format Tool）是 VMware 提供的命令行工具，用于导入和导出 OVF/OVA 格式的虚拟机模板。OVF（Open Virtualization Format）是一种开放标准，用于打包和分发虚拟机软件，由分布式管理任务组（DMTF）制定。

OVF Tool 支持在不同虚拟化平台之间迁移虚拟机，是 VMware 生态系统中重要的虚拟机管理工具。它可以在 vSphere、Workstation、Fusion、ESXi 等 VMware 产品之间转换虚拟机格式。

### 核心特性

- **格式转换**：支持 OVF、OVA、VMX、VMDK 等多种格式的转换
- **跨平台迁移**：在不同 VMware 产品之间迁移虚拟机
- **批量处理**：支持脚本自动化处理
- **验证功能**：验证 OVF/OVA 文件的完整性和合规性
- **压缩支持**：支持文件压缩以减小传输大小
- **网络传输**：支持通过 HTTPS 直接传输到 ESXi 主机
- **详细输出**：提供详细的转换进度和错误信息

### 支持的格式

| 格式 | 说明 | 扩展名 |
|------|------|--------|
| OVF | Open Virtualization Format 描述文件 | .ovf |
| OVA | OVF 打包归档文件 | .ova |
| VMX | VMware 虚拟机配置文件 | .vmx |
| VMDK | VMware 虚拟磁盘文件 | .vmdk |
| VMX Bundle | VMX 打包格式 | 目录 |
| vCloud | VMware vCloud Director 格式 | - |

### 适用场景

- 虚拟机模板导出和分发
- 从 Workstation 迁移到 ESXi
- 从 ESXi 导出虚拟机
- 虚拟机备份和归档
- 跨数据中心迁移虚拟机
- 虚拟化平台之间迁移
- 自动化部署虚拟机

---

## 主要功能

### 1. 虚拟机导出

将虚拟机导出为 OVF 或 OVA 格式：

- 从 vSphere/ESXi 导出
- 从 Workstation 导出
- 从 Fusion 导出
- 支持导出时压缩

### 2. 虚拟机导入

将 OVF/OVA 文件导入到虚拟化平台：

- 导入到 vSphere/ESXi
- 导入到 Workstation
- 导入到 Fusion
- 支持自定义网络和存储配置

### 3. 格式转换

在不同虚拟机格式之间转换：

- VMX 转 OVF
- OVF 转 VMX
- OVA 解包和打包
- 磁盘格式转换

### 4. 验证功能

验证虚拟机包的完整性和合规性：

- OVF 规范验证
- 证书验证
- 磁盘完整性检查

### 5. 网络操作

通过网络直接操作远程虚拟机：

- HTTPS 传输
- vSphere API 连接
- 批量传输

---

## 常用命令

### 基本语法

```powershell
ovftool [选项] 源 目标
```

### 导出操作

#### 从 ESXi/vSphere 导出虚拟机

```powershell
# 从 ESXi 导出为 OVF
ovftool vi://root@esxi-host/vm-name C:\export\vm-name.ovf

# 从 vCenter 导出
ovftool vi://admin@vcenter-host/datacenter/vm/folder/vm-name C:\export\vm-name.ovf

# 导出为 OVA 格式
ovftool vi://root@esxi-host/vm-name C:\export\vm-name.ova

# 指定端口连接
ovftool vi://root@esxi-host:443/vm-name C:\export\vm-name.ovf

# 使用密码（命令行方式，注意安全风险）
ovftool vi://root:password@esxi-host/vm-name C:\export\vm-name.ovf
```

#### 从 Workstation 导出

```powershell
# 从 VMX 文件导出为 OVF
ovftool "C:\VMs\vm-name\vm-name.vmx" C:\export\vm-name.ovf

# 从 VMX 导出为 OVA
ovftool "C:\VMs\vm-name\vm-name.vmx" C:\export\vm-name.ova

# 从 VMX Bundle 导出
ovftool "C:\VMs\vm-name\" C:\export\vm-name.ovf
```

### 导入操作

#### 导入到 ESXi/vSphere

```powershell
# 导入 OVF 到 ESXi
ovftool C:\export\vm-name.ovf vi://root@esxi-host

# 导入 OVA 到 ESXi
ovftool C:\export\vm-name.ova vi://root@esxi-host

# 导入并指定存储
ovftool --datastore=datastore1 C:\export\vm-name.ovf vi://root@esxi-host

# 导入到特定文件夹
ovftool --vmFolder="MyFolder" C:\export\vm-name.ovf vi://root@esxi-host

# 导入并指定网络
ovftool --net:"VM Network"="VM Network" C:\export\vm-name.ovf vi://root@esxi-host

# 导入到 vCenter 资源池
ovftool C:\export\vm-name.ovf vi://admin@vcenter-host/datacenter/host/cluster/Resources/pool

# 导入并重命名
ovftool --name="NewVMName" C:\export\vm-name.ovf vi://root@esxi-host

# 导入并设置磁盘格式
ovftool --diskMode=thin C:\export\vm-name.ovf vi://root@esxi-host
```

#### 导入到 Workstation

```powershell
# 导入 OVF 到 Workstation
ovftool C:\export\vm-name.ovf "C:\VMs\vm-name\vm-name.vmx"

# 导入 OVA 到 VMX
ovftool C:\export\vm-name.ova "C:\VMs\vm-name\vm-name.vmx"

# 导入到 VMX Bundle
ovftool C:\export\vm-name.ovf "C:\VMs\vm-name\"
```

### 格式转换

```powershell
# OVF 转 OVA
ovftool C:\export\vm-name.ovf C:\export\vm-name.ova

# OVA 转 OVF
ovftool C:\export\vm-name.ova C:\export\vm-name.ovf

# VMX 转 OVF
ovftool "C:\VMs\vm-name.vmx" C:\export\vm-name.ovf

# VMX 转 OVA
ovftool "C:\VMs\vm-name.vmx" C:\export\vm-name.ova
```

### 验证操作

```powershell
# 验证 OVF 文件
ovftool --verifyOnly C:\export\vm-name.ovf

# 验证 OVA 文件
ovftool --verifyOnly C:\export\vm-name.ova

# 显示详细验证信息
ovftool --verifyOnly --X:logLevel=verbose C:\export\vm-name.ovf
```

### 查询操作

```powershell
# 查看虚拟机信息
ovftool --hideEula C:\export\vm-name.ovf

# 列出 ESXi 主机上的虚拟机
ovftool vi://root@esxi-host

# 列出 vCenter 中的虚拟机
ovftool vi://admin@vcenter-host/datacenter/vm/folder
```

### 常用选项

#### 基本选项

```powershell
# 覆盖已有文件
ovftool --overwrite C:\export\vm-name.ovf vi://root@esxi-host

# 强制覆盖
ovftool -f C:\export\vm-name.ovf vi://root@esxi-host

# 显示帮助
ovftool --help

# 显示版本
ovftool --version

# 详细输出
ovftool --X:logLevel=verbose C:\export\vm-name.ovf vi://root@esxi-host

# 静默模式
ovftool --noDestinationCertificates C:\export\vm-name.ovf vi://root@esxi-host

# 忽略证书警告
ovftool --noSSLVerify C:\export\vm-name.ovf vi://root@esxi-host

# 接受 EULA
ovftool --acceptAllEulas C:\export\vm-name.ovf vi://root@esxi-host
```

#### 网络选项

```powershell
# 映射网络
ovftool --net:"Source Network"="Target Network" C:\export\vm-name.ovf vi://root@esxi-host

# 设置 IP 分配方式
ovftool --ipAllocationPolicy=fixedPolicy C:\export\vm-name.ovf vi://root@esxi-host

# 设置 IP 协议
ovftool --ipProtocol=IPv4 C:\export\vm-name.ovf vi://root@esxi-host
```

#### 磁盘选项

```powershell
# 设置磁盘格式：thin
ovftool --diskMode=thin C:\export\vm-name.ovf vi://root@esxi-host

# 设置磁盘格式：thick
ovftool --diskMode=thick C:\export\vm-name.ovf vi://root@esxi-host

# 设置磁盘格式：eagerZeroedThick
ovftool --diskMode=eagerZeroedThick C:\export\vm-name.ovf vi://root@esxi-host
```

#### 虚拟机配置选项

```powershell
# 设置虚拟机名称
ovftool --name="NewVM" C:\export\vm-name.ovf vi://root@esxi-host

# 设置 CPU 数量
ovftool --numberOfCPUs:vm=4 C:\export\vm-name.ovf vi://root@esxi-host

# 设置内存大小
ovftool --memorySize:vm=8192 C:\export\vm-name.ovf vi://root@esxi-host

# 设置存储位置
ovftool --datastore=datastore1 C:\export\vm-name.ovf vi://root@esxi-host

# 设置资源池
ovftool --vmFolder="MyFolder" C:\export\vm-name.ovf vi://root@esxi-host
```

### 批处理脚本示例

```powershell
# 批量导出脚本
$vms = @("vm1", "vm2", "vm3")
$esxi = "esxi-host"
$user = "root"
$exportPath = "C:\export"

foreach ($vm in $vms) {
    Write-Host "Exporting $vm..."
    ovftool "vi://${user}@${esxi}/${vm}" "${exportPath}\${vm}.ova"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$vm exported successfully"
    } else {
        Write-Host "$vm export failed"
    }
}
```

```powershell
# 批量导入脚本
$ovaFiles = Get-ChildItem "C:\import\*.ova"
$esxi = "esxi-host"
$user = "root"

foreach ($file in $ovaFiles) {
    Write-Host "Importing $($file.Name)..."
    ovftool --acceptAllEulas --diskMode=thin $file.FullName "vi://${user}@${esxi}"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$($file.Name) imported successfully"
    } else {
        Write-Host "$($file.Name) import failed"
    }
}
```

---

## 常见问题

### Q1: 连接 ESXi 主机失败怎么办？

**排查步骤：**

1. **检查网络连接**：
   ```powershell
   Test-NetConnection -ComputerName esxi-host -Port 443
   ```

2. **检查认证信息**：
   - 确认用户名和密码正确
   - 确认用户有足够权限

3. **检查证书**：
   ```powershell
   ovftool --noSSLVerify vi://root@esxi-host/vm-name C:\export\vm-name.ovf
   ```

4. **检查防火墙**：确保 443 端口可达

### Q2: 导入时提示磁盘空间不足怎么办？

1. **检查 ESXi 存储空间**：
   - 在 vSphere Client 中查看存储使用情况
   - 清理不需要的虚拟机和快照

2. **使用精简配置**：
   ```powershell
   ovftool --diskMode=thin C:\export\vm-name.ovf vi://root@esxi-host
   ```

3. **选择其他存储**：
   ```powershell
   ovftool --datastore=datastore2 C:\export\vm-name.ovf vi://root@esxi-host
   ```

### Q3: OVF 文件验证失败怎么办？

1. **检查 OVF 文件完整性**：确认文件下载完整，未损坏
2. **检查 OVA 文件**：如果是 OVA 文件，尝试解压后检查
3. **查看详细错误信息**：
   ```powershell
   ovftool --verifyOnly --X:logLevel=verbose C:\export\vm-name.ovf
   ```
4. **重新导出**：从源重新导出虚拟机

### Q4: 传输速度很慢怎么办？

1. **使用直接连接**：尽量在同一网络内操作
2. **使用 OVA 格式**：OVA 是打包格式，传输效率更高
3. **压缩磁盘**：在导出前压缩虚拟磁盘
4. **选择合适时间**：避免网络高峰期

### Q5: 导入后虚拟机无法启动怎么办？

1. **检查硬件兼容性**：确认虚拟机硬件版本与目标 ESXi 兼容
2. **检查网络配置**：确认网络映射正确
3. **检查存储路径**：确认所有磁盘文件都在正确位置
4. **查看虚拟机日志**：在 ESXi 上查看 vmware.log

### Q6: 如何处理跨版本兼容性？

1. **指定硬件版本**：
   ```powershell
   ovftool --maxVirtualHardwareVersion=14 C:\export\vm-name.ovf vi://root@esxi-host
   ```

2. **检查目标平台支持**：确认目标 ESXi 版本支持的硬件版本

3. **使用 OVF 标准版本**：
   ```powershell
   ovftool --ovf10 C:\export\vm-name.ovf C:\export\vm-name-ovf10.ovf
   ```

### Q7: 如何自动化 OVF Tool 操作？

- 使用 PowerShell 脚本封装 OVF Tool 命令
- 结合 vSphere PowerCLI 进行更复杂的自动化
- 使用 CI/CD 工具集成虚拟机部署流程
- 将密码存储在安全位置，避免命令行明文

---

## 相关资源

### 官方资源

- OVF Tool 下载页：https://developer.vmware.com/web/tool/4.6.2/ovf-tool
- OVF Tool 文档：https://developer.vmware.com/docs/11745
- VMware 官网：https://www.vmware.com/

### OVF 标准资源

- DMTF OVF 标准：https://www.dmtf.org/standards/ovf
- OVF 规范文档：https://www.dmtf.org/standards/published_documents/DSP0243

### VMware 工具

- vSphere Client：https://www.vmware.com/products/vsphere.html
- vSphere PowerCLI：https://developer.vmware.com/powercli
- VMware Workstation：https://www.vmware.com/products/workstation-pro.html
- VMware Fusion：https://www.vmware.com/products/fusion.html

### 替代工具

- QEMU（开源虚拟化）：https://www.qemu.org/
- VirtualBox（开源虚拟化）：https://www.virtualbox.org/
- Packer（虚拟机镜像构建）：https://www.packer.io/

### 学习资源

- VMware 学习中心：https://learning.vmware.com/
- VMware 技术文档：https://docs.vmware.com/
- VMTN 社区：https://communities.vmware.com/

### 相关概念

- OVF 规范理解：https://www.vmware.com/support/developer/ovf/
- 虚拟机模板最佳实践：https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AE6C8F00-8A17-456A-A0CA-2405D3F1BEB6.html
- 虚拟机迁移指南：https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vcenterhost.doc/GUID-F4423C64-A006-49E7-8C1D-05B67B4A0A7D.html
