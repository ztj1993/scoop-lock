# Manifest 编写提示

本文档提供 Scoop manifest 编写时的常用变量参考。

## 常用路径变量

```powershell
$dir              # 当前应用安装目录
$persist_dir      # 持久化数据目录
$original_dir     # 原始安装目录（安装前）
$bucketsdir       # Scoop buckets 根目录，例如 $env:USERPROFILE\scoop\buckets
$bucket           # 当前 bucket 名称
$bucket_dir       # 当前 bucket 根目录（通过 Find-BucketDirectory 获取）
$app              # 当前应用名称
$version          # 当前应用版本
$fname            # 当前下载文件名
$matchVer         # checkver 匹配的主版本号
$matchHead        # checkver 匹配的主版本号（用于 autoupdate）
$matchVersion     # checkver 匹配的完整版本号
$matchBuild       # checkver 匹配的构建号
$matchTag         # checkver 匹配的 Git 标签
$matchSha         # checkver 匹配的 SHA 值
$cleanVersion     # 清理后的版本号（去除点号）
$baseurl          # autoupdate 中的基础 URL
$basename         # 当前文件名
$sha256/$sha512   # 文件哈希值
$md5              # MD5 哈希值
$env:TMP          # 系统临时目录
$env:APPDATA      # 应用数据目录 (Roaming)
$env:LocalAppData # 本地应用数据目录
$env:USERPROFILE  # 用户主目录
```
