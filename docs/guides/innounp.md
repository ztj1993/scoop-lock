# innounp 使用指南

## 简介

innounp 是一款专门用于提取和检查 Inno Setup 安装包的命令行工具。Inno Setup 是 Windows 平台上广泛使用的免费安装程序制作工具，而 innounp 能够在不执行安装程序的情况下，直接从安装包中提取文件和查看安装脚本。

- **版本**: v0.50
- **许可证**: GPL-3.0
- **官方描述**: "Inno Setup Unpacker"
- **官方网站**: http://innounp.sourceforge.net
- **可执行文件**: innounp.exe
- **类型**: 命令行工具

innounp 是逆向工程师、系统管理员和安全研究人员的常用工具，它可以帮助用户在不运行安装程序的情况下查看其内容，这对于安全审计、文件恢复和软件分析非常有用。

## 主要功能

### 提取安装包内容

innounp 的核心功能是从 Inno Setup 创建的安装包中提取所有文件，无需实际执行安装过程。这对于以下场景非常有用：

- 从安装包中恢复丢失的文件
- 查看安装程序包含哪些文件
- 提取便携版应用程序
- 安全分析和审计

### 查看安装脚本

能够解析并显示 Inno Setup 的安装脚本（.iss），包括：

- 安装程序的配置信息
- 注册表修改项
- 文件安装路径
- 安装前后的操作
- 卸载信息

### 支持多种 Inno Setup 版本

innounp 支持从早期版本到最新版本的 Inno Setup 生成的安装包，兼容性广泛，能够处理各种版本的安装程序。

### 文件信息查看

可以查看安装包中每个文件的详细信息：

- 文件名和路径
- 文件大小
- 文件时间戳
- 文件版本信息（如果有的话）

### 命令行操作

作为纯命令行工具，innounp 可以轻松集成到脚本和自动化工作流中，支持批量处理多个安装包。

## 常用命令/操作

### 基本语法

```bash
innounp [选项] <安装包路径> [文件路径]
```

### 查看安装包信息

显示安装包的基本信息和包含的文件列表：

```bash
innounp -v setup.exe
```

### 列出所有文件

仅列出安装包中的文件，不进行提取：

```bash
innounp -l setup.exe
```

以详细模式列出文件（包含大小、时间等信息）：

```bash
innounp -l -v setup.exe
```

### 提取所有文件

将安装包中的所有文件提取到当前目录：

```bash
innounp -x setup.exe
```

提取到指定目录：

```bash
innounp -x -d"C:\Extracted" setup.exe
```

### 提取特定文件

从安装包中提取指定的文件：

```bash
innounp -x setup.exe "app\config.ini"
```

使用通配符提取：

```bash
innounp -x setup.exe "*.dll"
```

### 查看安装脚本

显示 Inno Setup 安装脚本：

```bash
innounp -s setup.exe
```

将脚本保存到文件：

```bash
innounp -s setup.exe > script.iss
```

### 查看注册表修改

查看安装程序将要修改的注册表项：

```bash
innounp -r setup.exe
```

### 查看安装类型

显示安装程序定义的安装类型：

```bash
innounp -t setup.exe
```

### 查看组件信息

显示安装程序的组件列表：

```bash
innounp -c setup.exe
```

### 检查文件完整性

验证安装包的完整性：

```bash
innounp -e setup.exe
```

### 处理加密的安装包

如果安装包使用密码加密：

```bash
innounp -x -p"password" setup.exe
```

### 批量处理

使用批处理脚本批量提取多个安装包：

```bash
for %f in (*.exe) do innounp -x -d"%~nf" "%f"
```

### 在 PowerShell 中使用

```powershell
Get-ChildItem *.exe | ForEach-Object {
    $dir = $_.BaseName
    innounp -x -d $dir $_.FullName
}
```

## 常见问题

### Q: 提示 "Not a valid Inno Setup installer" 怎么办？

这表示目标文件不是有效的 Inno Setup 安装程序。可能的原因：

- 文件不是使用 Inno Setup 制作的安装程序
- 文件已损坏
- 文件是自解压包或其他类型的安装程序（如 NSIS、WiX 等）

可以使用其他工具（如 7-Zip）尝试提取，或确认文件是否真的是 Inno Setup 安装包。

### Q: 提取的文件不完整或损坏怎么办？

- 尝试下载最新版本的 innounp
- 确认安装包文件本身没有损坏（校验 MD5/SHA）
- 如果安装包是分卷的，确保所有分卷都在同一目录下

### Q: 如何判断一个安装包是否使用 Inno Setup 制作？

使用以下命令检查：

```bash
innounp -v suspicious_file.exe
```

如果显示 Inno Setup 相关信息，则说明该文件是 Inno Setup 安装包。也可以查看文件属性中的版本信息，通常会包含 "Inno Setup" 字样。

### Q: innounp 支持哪些 Inno Setup 版本？

innounp v0.50 支持 Inno Setup 1.x 到 6.x 的所有版本，包括最新的 Inno Setup 6.3.x。对于特别新的版本，建议及时更新 innounp。

### Q: 提取时路径太长怎么办？

Windows 系统有 260 字符的路径长度限制。解决方法：

- 使用 `-d` 参数指定一个较短的提取路径
- 启用 Windows 的长路径支持
- 在根目录下创建提取文件夹

### Q: 如何提取嵌入在安装包中的 DLL 和资源？

使用 `-x` 参数会提取所有文件，包括嵌入的 DLL 和资源文件。如果只想提取特定类型的文件：

```bash
innounp -x setup.exe "*.dll"
innounp -x setup.exe "*.png"
```

### Q: 能否用 innounp 修改安装脚本后重新打包？

innounp 只支持提取和查看，不支持修改后重新打包。如需修改安装程序，建议：

1. 使用 innounp 提取安装脚本
2. 修改脚本内容
3. 使用 Inno Setup 编译器重新编译

### Q: 命令行输出中文乱码怎么办？

这是由于编码问题导致的。尝试：

- 使用 Windows Terminal 或支持 UTF-8 的终端
- 在命令行前执行 `chcp 65001` 切换到 UTF-8 编码
- 将输出重定向到文件后用文本编辑器打开

## 相关资源

- **官方网站**: http://innounp.sourceforge.net
- **SourceForge 项目页**: https://sourceforge.net/projects/innounp/
- **Inno Setup 官网**: https://jrsoftware.org/isinfo.php
- **GPL-3.0 许可证**: https://www.gnu.org/licenses/gpl-3.0.html
- **7-Zip（替代解压工具）**: https://www.7-zip.org/
- **Scoop 包管理器**: https://scoop.sh/
- **NSIS（另一种安装程序制作工具）**: https://nsis.sourceforge.io/
