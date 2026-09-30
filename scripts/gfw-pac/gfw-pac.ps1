<#
.SYNOPSIS
    Windows PAC 代理自动配置管理工具 (基于 gfw-pac)

.DESCRIPTION
    管理 Windows 系统 PAC 自动代理配置脚本 (AutoConfigURL)，通过 file:// 协议加载本地 PAC 文件，
    并自动刷新 WinINET 系统网络选项使其即时生效。

.EXAMPLE
    # 步骤 1: 配置代理后端并生成/更新 PAC 文件
    gfw-pac config -ProxyPort 7890 -ProxyType socks5
    gfw-pac config -Proxy "SOCKS5 127.0.0.1:7890; DIRECT"

    # 步骤 2: 开启 Windows PAC 代理 (打印代理信息与文件位置)
    gfw-pac enable

    # 步骤 3: 查看状态
    gfw-pac status

    # 步骤 4: 关闭代理
    gfw-pac disable
#>

param(
    [Parameter(Position = 0)]
    [ValidateSet("status", "enable", "disable", "config", "generate", "build", "set", "help", "on", "off", "unset", "info")]
    [string]$Action = "status",

    [Parameter(Position = 1)]
    [string]$Proxy,

    [string]$ProxyHost = "127.0.0.1",
    [int]$ProxyPort = 7890,
    [ValidateSet("socks5", "socks", "http", "proxy")]
    [string]$ProxyType = "socks5",
    [string]$PacPath
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[System.Console]::InputEncoding = [System.Text.Encoding]::UTF8

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

function Refresh-WinINet {
    $signature = @'
[DllImport("wininet.dll", SetLastError = true, CharSet=CharSet.Auto)]
public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength);
'@
    if (-not ([System.Management.Automation.PSTypeName]'WinINet.NativeMethods').Type) {
        Add-Type -MemberDefinition $signature -Name "NativeMethods" -Namespace "WinINet" -ErrorAction SilentlyContinue
    }
    # 39 = INTERNET_OPTION_SETTINGS_CHANGED, 37 = INTERNET_OPTION_REFRESH
    [WinINet.NativeMethods]::InternetSetOption([IntPtr]::Zero, 39, [IntPtr]::Zero, 0) | Out-Null
    [WinINet.NativeMethods]::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0) | Out-Null
}

function Enable-LegacyAutoProxyFeatures {
    $policyKeys = @(
        "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings",
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings"
    )
    foreach ($key in $policyKeys) {
        try {
            if (-not (Test-Path $key)) {
                New-Item -Path $key -Force | Out-Null
            }
            Set-ItemProperty -Path $key -Name "EnableLegacyAutoProxyFeatures" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
        } catch {
            # 忽略非管理员权限对 HKLM 的写入限制
        }
    }
}

function Find-PacFile {
    if ($PacPath) {
        if (Test-Path $PacPath) {
            return (Resolve-Path $PacPath).Path
        }
        return $null
    }
    $candidates = @(
        "$PSScriptRoot\gfw.pac",
        "$PSScriptRoot\..\gfw.pac",
        "$env:USERPROFILE\scoop\apps\gfw-pac\current\gfw.pac"
    )
    foreach ($cand in $candidates) {
        if ($cand -and (Test-Path $cand)) {
            return (Resolve-Path $cand).Path
        }
    }
    return $null
}

function Get-DefaultPacPath {
    if ($PacPath) {
        return (Resolve-Path -Path (Split-Path $PacPath -Parent) -ErrorAction SilentlyContinue).Path + "\" + (Split-Path $PacPath -Leaf)
    }
    if (Test-Path "$env:USERPROFILE\scoop\apps\gfw-pac\current") {
        return "$env:USERPROFILE\scoop\apps\gfw-pac\current\gfw.pac"
    }
    return "$PSScriptRoot\gfw.pac"
}

function Get-PacProxyString {
    param([string]$FilePath)
    if (-not (Test-Path $FilePath)) { return $null }
    $content = Get-Content -Path $FilePath -Raw -Encoding UTF8
    if ($content -match 'var\s+proxy\s*=\s*"([^"]*)";') {
        return $Matches[1]
    }
    return $null
}

function Set-PacProxyString {
    param([string]$FilePath, [string]$NewProxy)
    if (-not (Test-Path $FilePath)) { return }
    $content = Get-Content -Path $FilePath -Raw -Encoding UTF8
    if ($content -match 'var\s+proxy\s*=\s*"[^"]*";') {
        $updated = [regex]::Replace($content, 'var\s+proxy\s*=\s*"[^"]*";', "var proxy = `"$NewProxy`";")
        Set-Content -Path $FilePath -Value $updated -Encoding UTF8
    } else {
        $updated = "var proxy = `"$NewProxy`";`n" + $content
        Set-Content -Path $FilePath -Value $updated -Encoding UTF8
    }
}

function Build-ProxyString {
    if ($Proxy) {
        return $Proxy
    }
    $typeUpper = $ProxyType.ToUpper()
    if ($typeUpper -eq "SOCKS5") {
        return "SOCKS5 $ProxyHost`:$ProxyPort; SOCKS $ProxyHost`:$ProxyPort; DIRECT"
    } elseif ($typeUpper -in @("HTTP", "PROXY")) {
        return "PROXY $ProxyHost`:$ProxyPort; DIRECT"
    } else {
        return "$typeUpper $ProxyHost`:$ProxyPort; DIRECT"
    }
}

function Generate-Or-Update-Pac {
    param(
        [string]$TargetPacFile,
        [string]$ProxyString
    )

    $parentDir = Split-Path $TargetPacFile -Parent
    if ($parentDir -and (-not (Test-Path $parentDir))) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    if (Test-Path $TargetPacFile) {
        Set-PacProxyString -FilePath $TargetPacFile -NewProxy $ProxyString
        Write-Host "已更新现有 PAC 文件: $TargetPacFile" -ForegroundColor Green
    } else {
        # 寻找模板文件
        $template = @(
            "$parentDir\pac-template",
            "$PSScriptRoot\pac-template",
            "$PSScriptRoot\..\pac-template",
            "$env:USERPROFILE\scoop\apps\gfw-pac\current\pac-template"
        ) | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1

        if ($template) {
            $templateContent = Get-Content -Path $template -Raw -Encoding UTF8
            $finalContent = "var proxy = `"$ProxyString`";`n`n" + $templateContent
            Set-Content -Path $TargetPacFile -Value $finalContent -Encoding UTF8
            Write-Host "已从模板生成 PAC 文件: $TargetPacFile" -ForegroundColor Green
        } else {
            # 基础规则骨架
            $basicPac = @"
var proxy = "$ProxyString";
var direct = "DIRECT";

function FindProxyForURL(url, host) {
    if (isPlainHostName(host) ||
        shExpMatch(host, "*.local") ||
        isInNet(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
        isInNet(dnsResolve(host), "172.16.0.0", "255.240.0.0") ||
        isInNet(dnsResolve(host), "192.168.0.0", "255.255.0.0") ||
        isInNet(dnsResolve(host), "127.0.0.0", "255.0.0.0")) {
        return direct;
    }
    return proxy;
}
"@
            Set-Content -Path $TargetPacFile -Value $basicPac -Encoding UTF8
            Write-Host "已生成基础 PAC 文件: $TargetPacFile" -ForegroundColor Green
        }
    }
}

function Show-Header {
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "      Windows PAC 自动代理管理工具 (file:// 本地模式)     " -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
}

switch ($Action) {
    "help" {
        Show-Header
        Write-Host "用法:" -ForegroundColor Yellow
        Write-Host "  gfw-pac <命令> [参数]`n"
        Write-Host "命令:" -ForegroundColor Yellow
        Write-Host "  config (或 generate)  配置代理后端并生成/更新 PAC 文件"
        Write-Host "  enable (或 on)        开启 Windows 系统 PAC 代理 (仅生效配置，不修改文件)"
        Write-Host "  disable (或 off)      关闭 Windows 系统 PAC 代理，恢复直连"
        Write-Host "  status                查看当前 Windows PAC 代理状态及配置 (默认)"
        Write-Host "  help                  显示此帮助信息`n"
        Write-Host "配置参数 (用于 config 命令):" -ForegroundColor Yellow
        Write-Host "  -Proxy <代理字符串>   完整代理定义，如 `"SOCKS5 127.0.0.1:7890; DIRECT`""
        Write-Host "  -ProxyType <类型>     代理类型 (socks5 [默认] / http / proxy)"
        Write-Host "  -ProxyHost <主机>     代理服务器地址 (默认 127.0.0.1)"
        Write-Host "  -ProxyPort <端口>     代理端口 (默认 7890)"
        Write-Host "  -PacPath <路径>       自定义 gfw.pac 文件路径"
        Write-Host ""
    }

    { $_ -in @("config", "generate", "build", "set") } {
        Show-Header
        $targetFile = Find-PacFile
        if (-not $targetFile) {
            $targetFile = Get-DefaultPacPath
        }

        $proxyStr = Build-ProxyString
        Generate-Or-Update-Pac -TargetPacFile $targetFile -ProxyString $proxyStr

        Write-Host "`nPAC 配置与文件已就绪:" -ForegroundColor White
        Write-Host "  - PAC 文件位置: $targetFile" -ForegroundColor Cyan
        Write-Host "  - 规则代理后端: $proxyStr" -ForegroundColor Cyan
        Write-Host "`n提示: 可随时运行 'gfw-pac enable' 开启 Windows PAC 代理。" -ForegroundColor Gray
        Write-Host ""
    }

    { $_ -in @("enable", "on") } {
        Show-Header
        $pacFile = Find-PacFile
        if (-not $pacFile) {
            Write-Error "PAC 文件不存在！请先运行 'gfw-pac config' 配置代理并生成 PAC 文件后再开启。"
            exit 1
        }

        # 读取 PAC 文件内的代理信息
        $proxyStr = Get-PacProxyString $pacFile
        if (-not $proxyStr) {
            $proxyStr = "未在 PAC 文件中检测到 var proxy 声明"
        }

        # 生成 Windows file:// URL (使用正斜杠)
        $normalizedPath = $pacFile.Replace('\', '/')
        $fileUrl = "file:///$normalizedPath"

        # 打印代理信息和文件位置
        Write-Host "正在开启 Windows PAC 自动代理..." -ForegroundColor Cyan
        Write-Host "  - PAC 文件位置: $pacFile" -ForegroundColor White
        Write-Host "  - AutoConfigURL: $fileUrl" -ForegroundColor Cyan
        Write-Host "  - 规则代理信息: $proxyStr" -ForegroundColor Yellow

        # 启用系统支持 file:// 协议 PAC
        Enable-LegacyAutoProxyFeatures

        # 配置 Windows 注册表
        Set-ItemProperty -Path $regPath -Name "AutoConfigURL" -Value $fileUrl -Type String
        Set-ItemProperty -Path $regPath -Name "ProxyEnable" -Value 0 -Type DWord

        # 广播刷新 WinINET 选项
        Refresh-WinINet

        Write-Host "`n已成功开启 Windows PAC 自动代理！系统网络选项已即时刷新生效。" -ForegroundColor Green
        Write-Host ""
    }

    { $_ -in @("disable", "off", "unset") } {
        Show-Header
        try {
            Remove-ItemProperty -Path $regPath -Name "AutoConfigURL" -ErrorAction SilentlyContinue
        } catch {}
        Set-ItemProperty -Path $regPath -Name "AutoConfigURL" -Value "" -Type String -ErrorAction SilentlyContinue

        # 刷新 WinINET 选项
        Refresh-WinINet

        Write-Host "已关闭 Windows PAC 代理，恢复系统默认直连网络。" -ForegroundColor Green
        Write-Host "系统网络选项已即时刷新生效。" -ForegroundColor Gray
        Write-Host ""
    }

    "status" {
        Show-Header
        $reg = Get-ItemProperty -Path $regPath
        $currentUrl = $reg.AutoConfigURL
        $proxyEnable = $reg.ProxyEnable
        $pacFile = Find-PacFile

        Write-Host "Windows 系统代理配置状态:" -ForegroundColor White
        if ($currentUrl) {
            Write-Host "  - PAC 自动配置状态: [已启用]" -ForegroundColor Green
            Write-Host "  - 当前 AutoConfigURL: $currentUrl" -ForegroundColor Cyan
        } else {
            Write-Host "  - PAC 自动配置状态: [未启用 (无 AutoConfigURL)]" -ForegroundColor DarkGray
        }

        if ($proxyEnable -eq 1) {
            Write-Host "  - 手动全局代理状态: [已开启 (ProxyServer: $($reg.ProxyServer))]" -ForegroundColor Yellow
        } else {
            Write-Host "  - 手动全局代理状态: [未开启 (由 PAC 动态路由)]" -ForegroundColor Gray
        }

        if ($pacFile) {
            $pacProxy = Get-PacProxyString $pacFile
            Write-Host "`n本地 PAC 规则文件:" -ForegroundColor White
            Write-Host "  - 文件路径: $pacFile" -ForegroundColor Gray
            Write-Host "  - 规则内代理后端: $pacProxy" -ForegroundColor Cyan

            # 解析并检测端口
            if ($pacProxy -match '(?i)(?:PROXY|SOCKS5|SOCKS)\s+([^:;\s]+):(\d+)') {
                $chkHost = $Matches[1]
                $chkPort = [int]$Matches[2]
                Write-Host "  - 正在检测代理后端连通性 [$chkHost`:$chkPort]... " -NoNewline
                try {
                    $conn = Test-NetConnection -ComputerName $chkHost -Port $chkPort -WarningAction SilentlyContinue
                    if ($conn.TcpTestSucceeded) {
                        Write-Host "可用 [已连接]" -ForegroundColor Green
                    } else {
                        Write-Host "不可达 [请确认代理软件如 Clash 是否已启动]" -ForegroundColor Yellow
                    }
                } catch {
                    Write-Host "跳过检测" -ForegroundColor Gray
                }
            }
        } else {
            Write-Host "`n未在默认路径检测到 gfw.pac 文件。可使用 'gfw-pac config' 生成并配置。" -ForegroundColor Yellow
        }
        Write-Host ""
    }
}

