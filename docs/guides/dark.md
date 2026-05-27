# WiX Dark 使用指南

## 简介

WiX Dark 是 WiX (Windows Installer XML) 工具集中的反编译器组件。它可以将 Windows Installer 包（.msi 文件）反编译为 WiX 源文件，帮助开发者分析和理解现有的安装程序结构。

**版本**: 3.11.2
**官网**: https://wixtoolset.org/
**许可证**: MS-RL
**类型**: 命令行工具
**可执行文件**: dark.exe

## 主要功能

- 反编译 .msi 文件为 WiX 源代码
- 提取安装包中的文件和资源
- 分析安装包结构和配置
- 生成可读的 XML 格式源文件
- 支持多种 Windows Installer 特性
- 验证安装包完整性
- 提取嵌入的二进制数据
- 支持自定义操作分析

## 安装

### 通过 Scoop 安装

```bash
scoop install wixtoolset
```

### 验证安装

```bash
dark.exe -?
```

### 环境变量配置

```bash
# WiX 工具集通常自动添加到 PATH
# 如未添加，手动设置
set PATH=%PATH%;C:\Program Files (x86)\WiX Toolset v3.11\bin
```

## 基本用法

### 命令语法

```bash
dark.exe [选项] <输入文件> [输出文件]
```

### 基本反编译

```bash
# 反编译 .msi 文件
dark.exe input.msi output.wxs

# 反编译并输出到指定目录
dark.exe -o output\ input.msi
```

### 常用选项

```
-?              显示帮助信息
-o <path>       设置输出目录
-x              提取文件到输出目录
-nologo         不显示横幅信息
-sval           禁止验证
-t <transform>  应用转换
-ext <扩展>     加载扩展
```

## 反编译 MSI 文件

### 基本反编译

```bash
# 反编译为 WiX 源文件
dark.exe installer.msi installer.wxs

# 反编译到指定目录
dark.exe -o output\ installer.msi
```

### 提取文件

```bash
# 反编译并提取文件
dark.exe -x installer.msi -o output\

# 提取的文件结构
# output\
#   ├── installer.wxs    # WiX 源文件
#   └── *.cab            # 提取的文件
```

### 反编译选项

```bash
# 禁止验证
dark.exe -sval installer.msi output.wxs

# 不显示横幅
dark.exe -nologo installer.msi output.wxs

# 详细输出
dark.exe -v installer.msi output.wxs
```

## 输出文件结构

### WiX 源文件示例

```xml
<?xml version="1.0" encoding="utf-8"?>
<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
  <Product Id="*" 
           Name="My Application" 
           Language="1033" 
           Version="1.0.0.0" 
           Manufacturer="My Company" 
           UpgradeCode="PUT-GUID-HERE">
    
    <Package InstallerVersion="200" 
             Compressed="yes" 
             InstallScope="perMachine" />

    <MajorUpgrade DowngradeErrorMessage="A newer version is already installed." />
    <MediaTemplate EmbedCab="yes" />

    <Feature Id="ProductFeature" Title="MyApplication" Level="1">
      <ComponentGroupRef Id="ProductComponents" />
    </Feature>
  </Product>

  <Fragment>
    <Directory Id="TARGETDIR" Name="SourceDir">
      <Directory Id="ProgramFilesFolder">
        <Directory Id="INSTALLFOLDER" Name="MyApplication" />
      </Directory>
    </Directory>
  </Fragment>

  <Fragment>
    <ComponentGroup Id="ProductComponents" Directory="INSTALLFOLDER">
      <Component Id="MainExecutable">
        <File Source="$(var.MyApplication.TargetPath)" />
      </Component>
    </ComponentGroup>
  </Fragment>
</Wix>
```

### 文件目录结构

```
output\
├── Product.wxs          # 主产品定义
├── Components.wxs       # 组件定义
├── Features.wxs         # 功能定义
├── UI.wxs              # 用户界面定义
├── Binary\             # 二进制文件
│   ├── dialog.bmp
│   └── custom.dll
└── Cab\                # 提取的文件
    ├── file1.txt
    └── file2.exe
```

## 高级用法

### 分析安装包结构

```bash
# 查看安装包摘要信息
dark.exe -z installer.msi

# 列出安装包中的文件
dark.exe -l installer.msi
```

### 应用转换

```bash
# 应用转换文件
dark.exe -t transform.mst installer.msi output.wxs
```

### 使用扩展

```bash
# 使用 WiX 扩展
dark.exe -ext WixUIExtension installer.msi output.wxs

# 使用多个扩展
dark.exe -ext WixUIExtension -ext WixUtilExtension installer.msi output.wxs
```

### 批量处理

```bash
# 批量反编译脚本
@echo off
for %%f in (*.msi) do (
    echo Processing: %%f
    dark.exe -o "output\%%~nf" "%%f"
)
echo Done!
```

## 分析安装包

### 查看属性

```bash
# 导出属性表
dark.exe -sval -x installer.msi -o temp\

# 查看 Property 表
# 在反编译的 .wxs 文件中查找 Property 元素
```

### 查看自定义操作

```bash
# 反编译后查看 CustomAction 元素
# 在 .wxs 文件中搜索 CustomAction

# 示例输出
<CustomAction Id="MyAction" 
              BinaryKey="CustomAction.dll" 
              DllEntry="MyCustomAction" 
              Execute="immediate" 
              Return="check" />
```

### 查看安装条件

```bash
# 在 .wxs 文件中搜索 Condition 元素
# 示例
<Condition Message="This application requires Windows 10 or later.">
  <![CDATA[Installed OR (VersionNT >= 603)]]>
</Condition>
```

### 查看注册表操作

```bash
# 在 .wxs 文件中搜索 RegistryKey 和 RegistryValue 元素
# 示例
<RegistryKey Root="HKLM" 
             Key="SOFTWARE\MyCompany\MyApp">
  <RegistryValue Type="string" 
                 Name="InstallPath" 
                 Value="[INSTALLFOLDER]" 
                 Action="write" />
</RegistryKey>
```

## 实用场景

### 学习安装包结构

```bash
# 反编译现有安装包学习
dark.exe -x sample.msi -o analysis\

# 分析生成的 .wxs 文件
# 了解 WiX 项目结构
```

### 提取嵌入的文件

```bash
# 提取安装包中的文件
dark.exe -x installer.msi -o extracted\

# 查看提取的文件
dir extracted\
```

### 迁移安装项目

```bash
# 从旧的 .msi 提取结构
dark.exe legacy.msi legacy.wxs

# 使用提取的结构创建新的 WiX 项目
# 根据需要修改和优化
```

### 验证安装包

```bash
# 检查安装包完整性
dark.exe -sval installer.msi nul

# 如果有错误会显示警告
```

## 脚本集成

### PowerShell 脚本

```powershell
# 反编译 MSI 文件
function Decompile-Msi {
    param(
        [string]$MsiPath,
        [string]$OutputDir
    )
    
    $darkPath = "dark.exe"
    $arguments = "-x", "`"$MsiPath`"", "-o", "`"$OutputDir`""
    
    Start-Process -FilePath $darkPath -ArgumentList $arguments -Wait -NoNewWindow
    Write-Host "Decompilation complete: $OutputDir"
}

# 使用示例
Decompile-Msi -MsiPath "installer.msi" -OutputDir "output"
```

### 批处理脚本

```batch
@echo off
setlocal enabledelayedexpansion

set DARK_EXE=dark.exe
set INPUT_DIR=input
set OUTPUT_DIR=output

if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

for %%f in (%INPUT_DIR%\*.msi) do (
    echo Processing: %%~nxf
    set "NAME=%%~nf"
    mkdir "%OUTPUT_DIR%\!NAME!"
    %DARK_EXE% -x "%%f" -o "%OUTPUT_DIR%\!NAME!"
)

echo All files processed!
```

## 输出格式详解

### Product 元素

```xml
<Product Id="*"                    # 产品 GUID
         Name="Product Name"       # 产品名称
         Language="1033"           # 语言代码
         Version="1.0.0"          # 版本号
         Manufacturer="Company"    # 制造商
         UpgradeCode="GUID">      # 升级 GUID
```

### Directory 元素

```xml
<Directory Id="TARGETDIR" Name="SourceDir">
    <Directory Id="ProgramFilesFolder">
        <Directory Id="INSTALLFOLDER" Name="AppName">
            <!-- 文件和子目录 -->
        </Directory>
    </Directory>
</Directory>
```

### Component 元素

```xml
<Component Id="MainComponent" 
           Guid="PUT-GUID-HERE"
           Directory="INSTALLFOLDER">
    <File Id="MainExe" 
          Source="path\to\file.exe" 
          KeyPath="yes" />
</Component>
```

### Feature 元素

```xml
<Feature Id="Complete" 
         Title="Complete Installation"
         Level="1">
    <ComponentRef Id="MainComponent" />
    <ComponentRef Id="HelpFiles" />
</Feature>
```

## 常见问题

### 1. 反编译失败

```
可能原因:
- MSI 文件损坏
- MSI 文件加密或保护
- 不支持的 MSI 版本

解决方法:
1. 验证 MSI 文件完整性
2. 检查文件是否被保护
3. 尝试使用不同版本的 dark.exe
4. 查看详细错误信息
```

### 2. 提取的文件不完整

```
可能原因:
- 安装包使用了外部 CAB 文件
- 文件被压缩或编码

解决方法:
1. 检查是否有外部 CAB 文件
2. 使用 -x 选项提取所有文件
3. 验证输出目录中的文件
```

### 3. 生成的 WiX 源文件无法编译

```
可能原因:
- 反编译生成的 GUID 需要替换
- 缺少必要的引用
- WiX 版本不兼容

解决方法:
1. 替换 Id="*" 为实际 GUID
2. 添加必要的 WiX 扩展引用
3. 使用相同版本的 WiX 工具集编译
```

### 4. 编码问题

```
可能原因:
- 文件名包含特殊字符
- 路径包含非 ASCII 字符

解决方法:
1. 使用英文路径
2. 检查文件名编码
3. 使用短文件名
```

### 5. 权限问题

```
可能原因:
- 没有读取 MSI 文件的权限
- 没有写入输出目录的权限

解决方法:
1. 以管理员权限运行
2. 检查文件权限
3. 选择有写入权限的输出目录
```

### 6. 内存不足

```
可能原因:
- MSI 文件过大
- 系统内存不足

解决方法:
1. 增加系统虚拟内存
2. 关闭其他程序
3. 分批处理大文件
```

## 最佳实践

### 输出目录管理

```
1. 为每个 MSI 创建单独的输出目录
2. 使用有意义的目录名称
3. 定期清理临时文件
4. 备份重要的反编译结果
```

### 版本控制

```
1. 将反编译的 WiX 源文件纳入版本控制
2. 记录反编译使用的 dark.exe 版本
3. 保留原始 MSI 文件
4. 记录反编译日期和目的
```

### 安全考虑

```
1. 不要反编译未知来源的 MSI
2. 检查提取的文件是否有恶意内容
3. 在隔离环境中分析可疑安装包
4. 验证文件的数字签名
```

## 与其他 WiX 工具配合

### 使用 Light 链接

```bash
# 反编译后修改源文件
dark.exe installer.msi installer.wxs

# 使用修改后的源文件重新编译
candle.exe installer.wxs
light.exe installer.wixobj
```

### 使用 Smoke 验证

```bash
# 验证生成的 WiX 源文件
smoke.exe installer.wxs
```

### 使用 Torch 转换

```bash
# 创建转换文件
torch.exe -t language transform.wxs -o language.mst

# 应用转换反编译
dark.exe -t language.mst installer.msi output.wxs
```

## 调试技巧

### 详细输出

```bash
# 启用详细输出
dark.exe -v installer.msi output.wxs

# 查看警告和错误
dark.exe -sval installer.msi output.wxs 2> errors.log
```

### 验证 MSI

```bash
# 使用 Orca 查看 MSI 表结构
# 使用 dark.exe 反编译对比
dark.exe installer.msi output.wxs
```

## 相关资源

- [WiX 工具集官网](https://wixtoolset.org/)
- [WiX 文档](https://wixtoolset.org/documentation/)
- [WiX GitHub](https://github.com/wixtoolset/)
- [Windows Installer 文档](https://docs.microsoft.com/en-us/windows/win32/msi/windows-installer-portal)
- [MSI 文件格式参考](https://docs.microsoft.com/en-us/windows/win32/msi/database-tables)
