param(
    [Parameter(Position = 0)]
    [string]$BucketName,

    [Parameter(Position = 1)]
    [string]$Prefix = "https://ghfast.top/",

    [switch]$Scoop,

    [switch]$All,

    [switch]$List,

    [switch]$Remove,

    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$scoopRoot = "$env:USERPROFILE\scoop"
$bucketsDir = "$scoopRoot\buckets"
$scoopAppDir = "$scoopRoot\apps\scoop\current"

function Get-GitRemotes {
    param([string]$Path, [string]$Name)

    if (-not (Test-Path "$Path\.git")) {
        return $null
    }

    $remotes = git -C $Path remote 2>$null
    $result = @()

    foreach ($remote in $remotes) {
        $url = git -C $Path remote get-url $remote 2>$null
        $result += [PSCustomObject]@{
            Name = $Name
            Remote = $remote
            Url = $url
        }
    }

    return $result
}

function Update-RemoteUrl {
    param([string]$Path, [string]$Remote, [string]$Url, [string]$NewPrefix)

    if ($Remove) {
        $newUrl = $Url -replace "^$([regex]::Escape($Prefix))", ""
    } else {
        if ($Url.StartsWith($Prefix)) {
            return $Url
        }
        $newUrl = "$Prefix$Url"
    }

    if ($DryRun) {
        Write-Host "  [$Remote] $Url -> $newUrl" -ForegroundColor Yellow
    } else {
        git -C $Path remote set-url $Remote $newUrl
        Write-Host "  [$Remote] $Url -> $newUrl" -ForegroundColor Green
    }

    return $newUrl
}

if ($List) {
    Write-Host "`n=== Git Remotes ===" -ForegroundColor Cyan

    if (Test-Path $scoopAppDir) {
        $remotes = Get-GitRemotes -Path $scoopAppDir -Name "scoop"
        if ($remotes) {
            Write-Host "`nscoop:" -ForegroundColor Yellow
            $remotes | ForEach-Object { Write-Host "  [$($_.Remote)] $($_.Url)" }
        }
    }

    if (Test-Path $bucketsDir) {
        Get-ChildItem $bucketsDir -Directory | ForEach-Object {
            $remotes = Get-GitRemotes -Path $_.FullName -Name $_.Name
            if ($remotes) {
                Write-Host "`n$($_.Name):" -ForegroundColor Yellow
                $remotes | ForEach-Object { Write-Host "  [$($_.Remote)] $($_.Url)" }
            }
        }
    }

    exit 0
}

if ($Scoop) {
    Write-Host "`nUpdating scoop remotes..." -ForegroundColor Cyan

    if (-not (Test-Path $scoopAppDir)) {
        Write-Error "Scoop app directory not found: $scoopAppDir"
        exit 1
    }

    $remotes = Get-GitRemotes -Path $scoopAppDir -Name "scoop"
    if ($remotes) {
        foreach ($remote in $remotes) {
            Update-RemoteUrl -Path $scoopAppDir -Remote $remote.Remote -Url $remote.Url -NewPrefix $Prefix
        }
    } else {
        Write-Host "  No git repository found in scoop directory" -ForegroundColor Yellow
    }

    exit 0
}

if ($All) {
    Write-Host "`nUpdating all bucket remotes..." -ForegroundColor Cyan

    if (-not (Test-Path $bucketsDir)) {
        Write-Error "Buckets directory not found: $bucketsDir"
        exit 1
    }

    Get-ChildItem $bucketsDir -Directory | ForEach-Object {
        $remotes = Get-GitRemotes -Path $_.FullName -Name $_.Name
        if ($remotes) {
            Write-Host "`n$($_.Name):" -ForegroundColor Yellow
            foreach ($remote in $remotes) {
                Update-RemoteUrl -Path $_.FullName -Remote $remote.Remote -Url $remote.Url -NewPrefix $Prefix
            }
        }
    }

    exit 0
}

if ($BucketName) {
    Write-Host "`nUpdating '$BucketName' remotes..." -ForegroundColor Cyan

    $bucketPath = "$bucketsDir\$BucketName"

    if (-not (Test-Path $bucketPath)) {
        Write-Error "Bucket '$BucketName' not found: $bucketPath"
        exit 1
    }

    $remotes = Get-GitRemotes -Path $bucketPath -Name $BucketName
    if ($remotes) {
        foreach ($remote in $remotes) {
            Update-RemoteUrl -Path $bucketPath -Remote $remote.Remote -Url $remote.Url -NewPrefix $Prefix
        }
    } else {
        Write-Host "  No git repository found in bucket '$BucketName'" -ForegroundColor Yellow
    }

    exit 0
}

Write-Host "`nUsage:" -ForegroundColor Cyan
Write-Host "  .\cn-proxy-git.ps1 -List                    # List all git remotes"
Write-Host "  .\cn-proxy-git.ps1 <bucket>                  # Update specified bucket"
Write-Host "  .\cn-proxy-git.ps1 -Scoop                    # Update scoop itself"
Write-Host "  .\cn-proxy-git.ps1 -All                      # Update all buckets"
Write-Host "  .\cn-proxy-git.ps1 <bucket> <prefix>         # Use custom prefix"
Write-Host "  .\cn-proxy-git.ps1 <bucket> -Remove          # Remove prefix"
Write-Host "  .\cn-proxy-git.ps1 <bucket> -DryRun          # Preview changes"
