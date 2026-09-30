<#
.SYNOPSIS
    Antigravity-Proxy 管理工具 (适用于 Google Antigravity / Antigravity IDE)

.DESCRIPTION
    管理 Antigravity 免 TUN 代理注入 (version.dll 劫持)，支持自动识别 Scoop 及系统安装路径，
    一键开启、关闭、查看状态及配置代理。

.EXAMPLE
    .\antigravity-proxy.ps1 status
    .\antigravity-proxy.ps1 enable
    .\antigravity-proxy.ps1 disable
    .\antigravity-proxy.ps1 config
#>

param(
    [Parameter(Position = 0)]
    [ValidateSet("status", "enable", "disable", "config", "help", "install", "uninstall", "on", "off", "info")]
    [string]$Action = "status",

    [Parameter(Position = 1)]
    [string]$Target,

    [string]$ProxyType,
    [string]$ProxyHost,
    [int]$ProxyPort,
    [switch]$Cli
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[System.Console]::InputEncoding = [System.Text.Encoding]::UTF8

# 定位源文件目录（antigravity-proxy 自身安装目录）
$scriptDir = $PSScriptRoot
if (Test-Path "$scriptDir\version.dll") {
    $sourceDir = $scriptDir
} elseif (Test-Path "$scriptDir\..\version.dll") {
    $sourceDir = (Resolve-Path "$scriptDir\..").Path
} elseif (Test-Path "$env:USERPROFILE\scoop\apps\antigravity-proxy\current\version.dll") {
    $sourceDir = "$env:USERPROFILE\scoop\apps\antigravity-proxy\current"
} else {
    $sourceDir = $scriptDir
}

function Get-AntigravityLocations {
    param([switch]$IsCli)

    $paths = [System.Collections.Generic.List[string]]::new()

    if ($Target) {
        if (Test-Path $Target) {
            $paths.Add((Resolve-Path $Target).Path)
        } else {
            Write-Warning "指定的目录不存在: $Target"
        }
        return $paths
    }

    if ($IsCli) {
        $cliExe = Get-Command "agy.exe" -ErrorAction SilentlyContinue
        if ($cliExe) {
            $paths.Add((Split-Path $cliExe.Source -Parent))
        }
        $candidates = @(
            "$env:USERPROFILE\scoop\apps\antigravity\current",
            "$env:USERPROFILE\scoop\apps\antigravity-ide\current",
            "$env:LOCALAPPDATA\Programs\Antigravity",
            "$env:LOCALAPPDATA\Programs\Antigravity IDE"
        )
    } else {
        $candidates = @(
            "$env:USERPROFILE\scoop\apps\antigravity\current",
            "$env:USERPROFILE\scoop\apps\antigravity-ide\current",
            "$env:LOCALAPPDATA\Programs\Antigravity",
            "$env:LOCALAPPDATA\Programs\Antigravity IDE",
            "${env:ProgramFiles}\Antigravity",
            "${env:ProgramFiles(x86)}\Antigravity"
        )
    }

    foreach ($cand in $candidates) {
        if ($cand -and (Test-Path $cand) -and -not $paths.Contains($cand)) {
            $paths.Add((Resolve-Path $cand).Path)
        }
    }

    return $paths
}

function Show-Header {
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "         Antigravity-Proxy 免 TUN 代理注入管理工具        " -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
}

function Get-ProxyConfig {
    param([string]$Dir)
    $cfgPath = "$Dir\config.json"
    if (Test-Path $cfgPath) {
        try {
            return Get-Content $cfgPath -Raw -Encoding UTF8 | ConvertFrom-Json
        } catch {
            return $null
        }
    }
    return $null
}

switch ($Action) {
    "help" {
        Show-Header
        Write-Host "用法:" -ForegroundColor Yellow
        Write-Host "  antigravity-proxy <命令> [参数]`n"
        Write-Host "命令:" -ForegroundColor Yellow
        Write-Host "  status                查看当前代理注入状态及配置 (默认)"
        Write-Host "  enable (或 on)        向 Antigravity 部署注入 DLL 并启用代理"
        Write-Host "  disable (或 off)      从 Antigravity 移除注入 DLL，停用代理"
        Write-Host "  config                在浏览器中打开可视化配置页面或编辑 config.json"
        Write-Host "  help                  显示此帮助信息`n"
        Write-Host "可选参数:" -ForegroundColor Yellow
        Write-Host "  -Target <目录路径>    指定 Antigravity 安装目录（非默认路径时使用）"
        Write-Host "  -Cli                  针对 Antigravity CLI (agy.exe) 进行操作"
        Write-Host "  -ProxyType <类型>     快速更新代理类型 (socks5 / http)"
        Write-Host "  -ProxyHost <主机>     快速更新代理主机 (如 127.0.0.1)"
        Write-Host "  -ProxyPort <端口>     快速更新代理端口 (如 7890)"
        Write-Host ""
    }

    "status" {
        Show-Header
        $locs = Get-AntigravityLocations -IsCli:$Cli
        if ($locs.Count -eq 0) {
            Write-Host "未自动检测到已安装的 Antigravity 目录。" -ForegroundColor Yellow
            Write-Host "如果安装在自定义路径，请使用: antigravity-proxy status -Target `"<路径>`"" -ForegroundColor Gray
        } else {
            Write-Host "已检测到的 Antigravity 安装目标:" -ForegroundColor Green
            foreach ($loc in $locs) {
                $isInjected = Test-Path "$loc\version.dll"
                $isCliInjected = (Test-Path "$loc\dbghelp.dll") -or (Test-Path "$loc\antigravity_proxy.dll")
                $cfg = Get-ProxyConfig $loc

                Write-Host "`n  [目标目录] $loc" -ForegroundColor White
                if ($isInjected) {
                    Write-Host "  - IDE 代理注入状态: [已启用 (version.dll)]" -ForegroundColor Green
                } elseif ($isCliInjected) {
                    Write-Host "  - CLI 代理注入状态: [已启用 (dbghelp.dll)]" -ForegroundColor Green
                } else {
                    Write-Host "  - 代理注入状态:     [未启用]" -ForegroundColor DarkGray
                }

                if ($cfg -and $cfg.proxy) {
                    $pt = $cfg.proxy.type
                    $ph = $cfg.proxy.host
                    $pp = $cfg.proxy.port
                    Write-Host "  - 当前代理配置:     $pt`://$ph`:$pp" -ForegroundColor Cyan
                }
            }
        }

        # 检查源配置与端口连通性
        $srcCfg = Get-ProxyConfig $sourceDir
        if ($srcCfg -and $srcCfg.proxy) {
            $ph = $srcCfg.proxy.host
            $pp = $srcCfg.proxy.port
            $pt = $srcCfg.proxy.type
            $srcCfgFile = Join-Path $sourceDir "config.json"
            Write-Host "`n默认代理配置 [$srcCfgFile]:" -ForegroundColor Gray
            Write-Host "  协议: $pt | 主机: $ph | 端口: $pp" -ForegroundColor Gray

            $endpointStr = "$ph`:$pp"
            Write-Host "正在检测本地代理端口连通性 [$endpointStr]... " -NoNewline
            try {
                $conn = Test-NetConnection -ComputerName $ph -Port $pp -WarningAction SilentlyContinue
                if ($conn.TcpTestSucceeded) {
                    Write-Host "可用 [已连接]" -ForegroundColor Green
                } else {
                    Write-Host "不可达 [请确认代理软件如 Clash 是否已启动并开放该端口]" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "检测跳过" -ForegroundColor Gray
            }
        }
        Write-Host ""
    }

    { $_ -in @("enable", "install", "on") } {
        Show-Header
        $locs = Get-AntigravityLocations -IsCli:$Cli
        if ($locs.Count -eq 0) {
            Write-Error "未能找到 Antigravity 安装目录，请通过 -Target 参数指定路径。"
            exit 1
        }

        # 如果用户指定了快捷配置参数，更新 sourceDir 下的 config.json
        if ($ProxyType -or $ProxyHost -or $ProxyPort) {
            $srcCfg = Get-ProxyConfig $sourceDir
            if ($srcCfg) {
                if ($ProxyType) { $srcCfg.proxy.type = $ProxyType }
                if ($ProxyHost) { $srcCfg.proxy.host = $ProxyHost }
                if ($ProxyPort) { $srcCfg.proxy.port = $ProxyPort }
                $srcCfg | ConvertTo-Json -Depth 10 | Set-Content "$sourceDir\config.json" -Encoding UTF8
                Write-Host "已更新源代理配置: $($srcCfg.proxy.type)://$($srcCfg.proxy.host):$($srcCfg.proxy.port)" -ForegroundColor Green
            }
        }

        # 检查相关运行中进程
        $running = Get-Process -Name "Antigravity", "Antigravity IDE", "agy", "language_server*" -ErrorAction SilentlyContinue
        if ($running) {
            Write-Warning "检测到 Antigravity 正在运行中，建议在注入后重启 Antigravity 以使代理生效！"
        }

        foreach ($loc in $locs) {
            Write-Host "`n正在向目标部署代理组件: $loc" -ForegroundColor Cyan
            
            if ($Cli) {
                # CLI 模式部署 dbghelp.dll 与 antigravity_proxy.dll
                if (Test-Path "$sourceDir\dbghelp.dll") {
                    Copy-Item "$sourceDir\dbghelp.dll" "$loc\dbghelp.dll" -Force
                    Write-Host "  + 已复制 dbghelp.dll" -ForegroundColor Green
                }
                if (Test-Path "$sourceDir\antigravity_proxy.dll") {
                    Copy-Item "$sourceDir\antigravity_proxy.dll" "$loc\antigravity_proxy.dll" -Force
                    Write-Host "  + 已复制 antigravity_proxy.dll" -ForegroundColor Green
                }
            } else {
                # IDE 模式部署 version.dll
                if (-not (Test-Path "$sourceDir\version.dll")) {
                    Write-Error "源文件 version.dll 未找到: $sourceDir\version.dll"
                    exit 1
                }
                Copy-Item "$sourceDir\version.dll" "$loc\version.dll" -Force
                Write-Host "  + 已复制 version.dll" -ForegroundColor Green
            }

            # 部署 config.json（若目标目录不存在）
            if (Test-Path "$sourceDir\config.json") {
                if (-not (Test-Path "$loc\config.json")) {
                    Copy-Item "$sourceDir\config.json" "$loc\config.json" -Force
                    Write-Host "  + 已复制初始 config.json" -ForegroundColor Green
                } else {
                    Write-Host "  * 目标已存在 config.json，保留用户现有配置" -ForegroundColor Gray
                }
            }

            # 复制 config-web.html 方便调试
            if (Test-Path "$sourceDir\config-web.html") {
                Copy-Item "$sourceDir\config-web.html" "$loc\config-web.html" -Force
            }

            Write-Host "成功启用代理注入！" -ForegroundColor Green
        }
        Write-Host "`n提示: 若 Antigravity 正在运行，请完全退出并重新启动它以加载代理。" -ForegroundColor Yellow
    }

    { $_ -in @("disable", "uninstall", "off") } {
        Show-Header
        $locs = Get-AntigravityLocations -IsCli:$Cli
        if ($locs.Count -eq 0) {
            Write-Error "未能找到 Antigravity 安装目录，请通过 -Target 参数指定路径。"
            exit 1
        }

        foreach ($loc in $locs) {
            Write-Host "`n正在停用目标目录中的代理注入: $loc" -ForegroundColor Cyan
            $removed = $false

            if (Test-Path "$loc\version.dll") {
                Remove-Item "$loc\version.dll" -Force
                Write-Host "  - 已移除 version.dll" -ForegroundColor Yellow
                $removed = $true
            }

            if (Test-Path "$loc\dbghelp.dll") {
                Remove-Item "$loc\dbghelp.dll" -Force
                Write-Host "  - 已移除 dbghelp.dll" -ForegroundColor Yellow
                $removed = $true
            }

            if (Test-Path "$loc\antigravity_proxy.dll") {
                Remove-Item "$loc\antigravity_proxy.dll" -Force
                Write-Host "  - 已移除 antigravity_proxy.dll" -ForegroundColor Yellow
                $removed = $true
            }

            if ($removed) {
                Write-Host "已成功停用代理注入！" -ForegroundColor Green
            } else {
                Write-Host "目标目录未检测到注入 DLL，无需停用。" -ForegroundColor Gray
            }
        }
    }

    "config" {
        $webPath = "$sourceDir\config-web.html"
        $cfgPath = "$sourceDir\config.json"

        if (Test-Path $webPath) {
            Write-Host "正在打开可视化配置页面: $webPath" -ForegroundColor Green
            Start-Process $webPath
        } elseif (Test-Path $cfgPath) {
            Write-Host "正在打开配置文件: $cfgPath" -ForegroundColor Green
            Start-Process notepad.exe -ArgumentList "`"$cfgPath`""
        } else {
            Write-Error "未找到配置文件: $cfgPath"
            exit 1
        }
    }
}


