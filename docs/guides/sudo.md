# sudo 使用指南

## 简介

sudo 是一个 PowerShell 脚本工具，模拟 Unix 系统中的 sudo 命令，允许用户以管理员权限运行命令。当需要执行需要提升权限的操作时，sudo 会弹出 UAC (用户账户控制) 窗口进行确认。

**版本**: v0.2020.01.26  
**官网**: https://github.com/lukesampson/psutils  
**许可证**: MIT  
**脚本文件**: sudo.ps1  
**位置**: ~/scoop/apps/sudo/current/sudo.ps1

## 主要功能

- 以管理员权限运行命令
- 弹出 UAC 窗口进行权限确认
- 支持 PowerShell 命令和外部程序
- 无需手动以管理员身份打开 PowerShell
- 简化权限提升操作流程
- 支持管道和重定向
- 与 Scoop 包管理器集成

## 常用命令

### 基本使用

```powershell
# 以管理员权限运行命令
sudo command

# 示例：以管理员权限运行 ipconfig
sudo ipconfig /all

# 示例：以管理员权限运行 netstat
sudo netstat -an
```

### 系统管理命令

```powershell
# 重启网络服务
sudo Restart-Service -Name "WlanSvc"

# 停止服务
sudo Stop-Service -Name "Spooler"

# 启动服务
sudo Start-Service -Name "Spooler"

# 查看服务状态
sudo Get-Service -Name "WlanSvc"
```

### 文件操作

```powershell
# 删除受保护的文件
sudo Remove-Item "C:\Windows\Temp\oldfile.tmp"

# 复制文件到系统目录
sudo Copy-Item "hosts" "C:\Windows\System32\drivers\etc\hosts"

# 修改文件权限
sudo icacls "C:\MyFolder" /grant "Users:(OI)(CI)F"
```

### 注册表操作

```powershell
# 修改注册表
sudo Set-ItemProperty -Path "HKLM:\SOFTWARE\MyApp" -Name "Setting" -Value "1"

# 创建注册表项
sudo New-Item -Path "HKLM:\SOFTWARE\MyApp"

# 删除注册表项
sudo Remove-Item -Path "HKLM:\SOFTWARE\MyApp" -Recurse
```

### 网络配置

```powershell
# 刷新 DNS 缓存
sudo ipconfig /flushdns

# 释放 IP 地址
sudo ipconfig /release

# 续订 IP 地址
sudo ipconfig /renew

# 重置网络适配器
sudo netsh int ip reset
```

### 程序安装

```powershell
# 安装 Windows 功能
sudo Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All

# 安装 Chocolatey 包
sudo choco install package-name

# 安装 Scoop 包（全局）
sudo scoop install -g package-name
```

## 高级用法

### 运行复杂命令

```powershell
# 运行包含多个参数的命令
sudo Get-Process | Where-Object {$_.CPU -gt 100}

# 运行脚本块
sudo { Get-Service | Where-Object {$_.Status -eq "Running"} }
```

### 管道操作

```powershell
# 将输出重定向到文件
sudo Get-Process > "C:\Admin\processes.txt"

# 追加到文件
sudo Get-EventLog -LogName System >> "C:\Admin\events.txt"
```

### 环境变量

```powershell
# 设置系统环境变量
sudo [Environment]::SetEnvironmentVariable("MY_VAR", "value", "Machine")

# 查看系统环境变量
sudo [Environment]::GetEnvironmentVariable("PATH", "Machine")
```

### 计划任务

```powershell
# 创建计划任务
sudo Register-ScheduledTask -TaskName "MyTask" -Action (New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\script.ps1") -Trigger (New-ScheduledTaskTrigger -Daily -At "09:00")

# 运行计划任务
sudo Start-ScheduledTask -TaskName "MyTask"
```

## 使用场景

### 场景 1：修改系统文件

当需要修改系统保护的文件（如 hosts 文件）时：

```powershell
# 以管理员权限编辑 hosts 文件
sudo notepad "C:\Windows\System32\drivers\etc\hosts"
```

### 场景 2：管理系统服务

当需要启动、停止或重启系统服务时：

```powershell
# 重启 IIS 服务
sudo iisreset

# 重启 SQL Server 服务
sudo Restart-Service -Name "MSSQLSERVER"
```

### 场景 3：网络诊断

当需要执行需要管理员权限的网络命令时：

```powershell
# 查看所有网络连接
sudo netstat -anob

# 跟踪路由
sudo tracert google.com

# 端口扫描
sudo Test-NetConnection -ComputerName server -Port 80
```

### 场景 4：系统维护

当需要执行系统维护任务时：

```powershell
# 清理系统文件
sudo CleanMgr /sagerun:1

# 检查磁盘
sudo chkdsk C: /f

# 系统文件检查
sudo sfc /scannow
```

### 场景 5：开发环境配置

当需要配置开发环境时：

```powershell
# 安装 Node.js 全局包
sudo npm install -g @angular/cli

# 配置 Git 全局设置
sudo git config --global core.autocrlf true

# 设置 Python 环境变量
sudo [Environment]::SetEnvironmentVariable("PYTHON_HOME", "C:\Python39", "Machine")
```

## 配置选项

### 设置别名

可以在 PowerShell 配置文件中添加别名：

```powershell
# 打开配置文件
notepad $PROFILE

# 添加别名
function Invoke-Sudo { sudo @args }
Set-Alias -Name s -Value Invoke-Sudo
```

### 修改 UAC 设置

如果 UAC 弹窗过于频繁，可以调整设置：

1. 打开"控制面板" → "用户账户" → "更改用户账户控制设置"
2. 调整滑块位置
3. 点击"确定"

**注意**: 不建议完全关闭 UAC，这会降低系统安全性。

## 安全注意事项

### 1. 谨慎使用管理员权限

- 仅在必要时使用 sudo
- 避免在不信任的脚本中使用
- 仔细检查要执行的命令

### 2. UAC 提示的重要性

- 仔细阅读 UAC 提示中的程序名称
- 确认来源可信后再点击"是"
- 注意程序的发布者信息

### 3. 避免滥用

- 不要将 sudo 用于日常操作
- 不要绕过必要的安全检查
- 遵循最小权限原则

## 常见问题

### 1. sudo 命令未找到

**可能原因**:
- Scoop 未正确安装
- sudo 包未安装
- PATH 环境变量未配置

**解决方案**:
```powershell
# 安装 sudo
scoop install sudo

# 检查是否在 PATH 中
Get-Command sudo

# 如果未找到，手动添加路径
$env:PATH += ";$HOME\scoop\apps\sudo\current"
```

### 2. UAC 弹窗未出现

**可能原因**:
- UAC 被禁用
- 脚本执行策略限制
- 组策略限制

**解决方案**:
```powershell
# 检查 UAC 设置
Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System | Select-Object EnableLUA

# 检查执行策略
Get-ExecutionPolicy

# 设置执行策略
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 3. 权限提升失败

**可能原因**:
- 用户不是管理员组成员
- 组策略限制
- 系统配置问题

**解决方案**:
- 确认用户账户是管理员
- 检查组策略设置
- 以管理员身份手动运行 PowerShell

### 4. 命令执行超时

**可能原因**:
- 命令本身耗时较长
- 系统资源不足
- 网络延迟

**解决方案**:
- 增加超时时间
- 优化命令执行
- 检查系统资源

### 5. 环境变量问题

**可能原因**:
- sudo 环境与当前环境不同
- PATH 变量不一致

**解决方案**:
```powershell
# 使用完整路径运行程序
sudo "C:\Program Files\MyApp\app.exe"

# 显式设置环境变量
sudo $env:PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine")
```

## 故障排除

### 检查 sudo 版本

```powershell
# 查看 sudo 位置
Get-Command sudo

# 查看脚本内容
Get-Content (Get-Command sudo).Source
```

### 测试 sudo 功能

```powershell
# 测试基本功能
sudo whoami

# 测试管理员权限
sudo ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```

### 调试模式

```powershell
# 启用详细输出
$VerbosePreference = "Continue"
sudo -Verbose Get-Process
```

## 替代方案

### 使用内置的 RunAs

```powershell
# 使用 runas 命令
runas /user:Administrator "powershell.exe -Command Get-Process"
```

### 使用 PowerShell 的 Start-Process

```powershell
# 以管理员身份启动进程
Start-Process powershell -Verb RunAs -ArgumentList "-Command Get-Process"
```

### 使用 Windows Terminal

在 Windows Terminal 中：
1. 右键点击标签页
2. 选择"以管理员身份运行"
3. 输入命令

## 最佳实践

### 1. 使用完整路径

```powershell
# 推荐使用完整路径
sudo "C:\Windows\System32\netsh.exe" int ip reset

# 而不是
sudo netsh int ip reset
```

### 2. 检查命令结果

```powershell
# 检查命令是否成功
sudo Some-Command
if ($LASTEXITCODE -eq 0) {
    Write-Host "命令执行成功"
} else {
    Write-Host "命令执行失败"
}
```

### 3. 记录操作

```powershell
# 记录到日志文件
$logFile = "C:\AdminLogs\operations.log"
sudo Get-Date >> $logFile
sudo Some-Command >> $logFile
```

## 相关资源

- [sudo GitHub 仓库](https://github.com/lukesampson/psutils)
- [Scoop 包管理器](https://scoop.sh/)
- [PowerShell 文档](https://docs.microsoft.com/powershell/)
- [UAC 用户指南](https://docs.microsoft.com/windows/security/identity-protection/user-account-control/)
- [Windows 命令行参考](https://docs.microsoft.com/windows-server/administration/windows-commands/windows-commands)