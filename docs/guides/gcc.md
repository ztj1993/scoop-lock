# GCC 使用指南

## 简介

GCC（GNU Compiler Collection）是 GNU 项目的核心组件之一，是一套功能强大的编译器集合。
GCC v11.2.0 采用 GPL-3.0 开源许可证，支持多种编程语言的编译，包括 C、C++、Fortran、
Ada、Go、D 等。

GCC 的前身是 GNU C 编译器（GNU C Compiler），后来随着支持语言的扩展，名称变更为
GNU Compiler Collection。GCC 是 Linux 生态系统中最基础的编译工具，也是众多开源项目
的编译基础。

除了编译器本身，GCC 还包含 GNU Binutils（二进制工具集），提供了汇编器（as）、链接器（ld）、
汇编反汇编器（objdump）、符号表工具（nm）等一系列底层工具。

通过 Scoop 安装的 GCC 适用于 Windows 平台上的 C/C++ 开发，是 MinGW（Minimalist GNU for Windows）
工具链的核心组件。

- **版本**: v11.2.0
- **许可证**: GPL-3.0
- **官方网站**: https://www.gnu.org/software/gcc/
- **安装方式**: Scoop 包管理器

## 主要功能

### 多语言编译

GCC 支持多种编程语言的编译：

- **C 语言**: 完整支持 C89、C99、C11、C17 标准，实验性支持 C2x
- **C++ 语言**: 支持 C++98、C++11、C++14、C++17、C++20 标准
- **Fortran**: 支持 Fortran 77、90、95、2003、2008、2018 标准
- **Ada**: 支持 Ada 2012 标准
- **Go**: 内置 Go 语言前端编译器
- **D**: 支持 D 语言编译
- **Objective-C/C++**: 支持 Objective 系列语言

### 编译优化

GCC 提供多级别的编译优化选项：

- `-O0`: 不优化，编译速度最快，便于调试
- `-O1`: 基本优化，平衡编译时间和代码性能
- `-O2`: 推荐优化级别，提供更多优化但不增加编译体积
- `-O3`: 激进优化，可能增加代码体积
- `-Os`: 优化代码体积
- `-Ofast`: 最激进优化，可能不符合语言标准
- `-Og`: 针对调试的优化，保留调试信息的同时进行基本优化

### 调试信息

- 支持 DWARF 调试信息格式
- 支持生成 GDB 兼容的调试信息（`-g` 选项）
- 支持多级别的调试信息详细度（`-g1`、`-g2`、`-g3`）
- 可与 Valgrind、AddressSanitizer 等工具配合使用

### 代码分析

- **警告系统**: 支持细粒度的编译警告控制
- **静态分析**: 内置 `-fanalyzer` 静态分析器
- **AddressSanitizer**: 内存错误检测
- **UndefinedBehaviorSanitizer**: 未定义行为检测
- **ThreadSanitizer**: 数据竞争检测

### GNU Binutils

GCC 安装包含以下二进制工具：

- `as`: GNU 汇编器
- `ld`: GNU 链接器
- `objdump`: 目标文件分析工具
- `nm`: 符号表查看工具
- `strip`: 去除符号信息工具
- `ar`: 静态库管理工具
- `readelf`: ELF 文件分析工具
- `size`: 显示目标文件各段大小

## 常用命令/操作

### 编译 C 程序

最简单的编译命令：

```bash
gcc hello.c -o hello
```

常用编译选项：

| 选项 | 说明 |
|------|------|
| `-o file` | 指定输出文件名 |
| `-Wall` | 启用所有常见警告 |
| `-Wextra` | 启用额外警告 |
| `-Werror` | 将警告视为错误 |
| `-std=c11` | 指定 C 语言标准 |
| `-I dir` | 添加头文件搜索路径 |
| `-L dir` | 添加库文件搜索路径 |
| `-l lib` | 链接指定的库 |
| `-D macro` | 定义预处理宏 |
| `-c` | 只编译不链接 |
| `-E` | 只进行预处理 |
| `-S` | 只生成汇编代码 |
| `-g` | 生成调试信息 |
| `-O level` | 设置优化级别 |
| `-shared` | 生成共享库（动态链接库） |
| `-static` | 静态链接 |
| `-fPIC` | 生成位置无关代码 |
| `-m32`/`-m64` | 指定 32/64 位编译 |

### 编译 C++ 程序

C++ 编译使用 g++ 命令：

```bash
g++ hello.cpp -o hello -std=c++17 -Wall -O2
```

常用 C++ 特定选项：

```bash
g++ -std=c++20 main.cpp -o main
g++ -std=c++17 -pthread main.cpp -o main
g++ -fconcepts main.cpp -o main
```

### 多文件编译

分别编译后链接：

```bash
gcc -c file1.c -o file1.o
gcc -c file2.c -o file2.o
gcc file1.o file2.o -o program
```

一步完成：

```bash
gcc file1.c file2.c -o program
```

### 生成动态库与静态库

生成动态库（Windows 上为 DLL）：

```bash
gcc -shared -fPIC -o libhello.dll hello.c
```

生成静态库（Windows 上为 .a 或 .lib）：

```bash
gcc -c hello.c -o hello.o
ar rcs libhello.a hello.o
```

### 链接外部库

链接数学库：

```bash
gcc program.c -o program -lm
```

链接自定义库路径：

```bash
gcc program.c -o program -L./lib -lmylib -I./include
```

### 预处理与汇编

只进行预处理，查看宏展开结果：

```bash
gcc -E hello.c -o hello.i
```

只生成汇编代码：

```bash
gcc -S hello.c -o hello.s
```

查看编译器版本和支持的标准：

```bash
gcc --version
gcc -v
```

### 静态分析

使用 GCC 内置的静态分析器：

```bash
gcc -fanalyzer -Wall hello.c -o hello
```

使用 AddressSanitizer 检测内存错误：

```bash
gcc -fsanitize=address -g hello.c -o hello
```

使用 UndefinedBehaviorSanitizer：

```bash
gcc -fsanitize=undefined -g hello.c -o hello
```

### 常用 Binutils 工具

查看符号表：

```bash
nm program
```

反汇编：

```bash
objdump -d program
```

查看文件信息：

```bash
objdump -f program
size program
file program
```

去除调试信息（减小文件大小）：

```bash
strip program
```

### 环境变量

Scoop 安装 GCC 后会自动设置以下环境变量：

- `C_INCLUDE_PATH`: C 语言头文件搜索路径
- `CPLUS_INCLUDE_PATH`: C++ 语言头文件搜索路径

这些环境变量使得编译器能够自动找到标准库的头文件，无需手动指定 `-I` 参数。

验证环境变量设置：

```powershell
echo $env:C_INCLUDE_PATH
echo $env:CPLUS_INCLUDE_PATH
```

查看 GCC 默认的头文件搜索路径：

```bash
gcc -v -x c /dev/null -fsyntax-only
```

## 常见问题

### Q: 编译时提示 "xxx.h: No such file or directory"

通常是头文件路径未正确配置。解决方案：
1. 使用 `-I` 选项指定头文件目录
2. 检查 `C_INCLUDE_PATH` 或 `CPLUS_INCLUDE_PATH` 环境变量是否正确
3. 确认相关开发库已正确安装

### Q: 链接时提示 "undefined reference to xxx"

通常是缺少必要的库文件。解决方案：
1. 使用 `-l` 选项链接所需库（注意库名前的 `lib` 前缀和 `.a`/`.dll` 后缀不需要指定）
2. 使用 `-L` 选项指定库文件搜索路径
3. 确保链接顺序正确（被依赖的库放在后面）

### Q: 如何编译 32 位程序？

使用 `-m32` 选项：

```bash
gcc -m32 hello.c -o hello
```

注意：可能需要安装 32 位开发库。

### Q: 如何查看编译器支持的 C/C++ 标准版本？

```bash
gcc -dM -E -std=c11 - < /dev/null | grep __STDC_VERSION__
g++ -dM -E -std=c++17 - < /dev/null | grep __cplusplus
```

### Q: 如何生成位置无关代码（PIC）？

共享库必须使用 PIC：

```bash
gcc -fPIC -c module.c -o module.o
gcc -shared module.o -o module.dll
```

### Q: 编译速度慢如何优化？

- 使用 `-pipe` 选项，用管道替代临时文件
- 使用 `make -j N` 进行并行编译
- 降低优化级别（`-O0` 或 `-O1`）
- 使用 ccache 缓存编译结果

## 相关资源

- **官方网站**: https://www.gnu.org/software/gcc/
- **GCC 文档**: https://gcc.gnu.org/onlinedocs/
- **GCC Wiki**: https://gcc.gnu.org/wiki/
- **MinGW-w64**: https://www.mingw-w64.org
- **GNU Binutils**: https://www.gnu.org/software/binutils/
- **GDB 调试器**: https://www.gnu.org/software/gdb/
- **C 语言标准文档**: https://en.cppreference.com/w/c
- **C++ 标准文档**: https://en.cppreference.com/w/cpp
- **Scoop 包管理器**: https://scoop.sh
