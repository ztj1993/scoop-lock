# Erlang 使用指南

## 简介

Erlang 是一种通用的、面向并发的编程语言，由爱立信（Ericsson）于 1986 年开发，
最初用于构建电信系统。如今 Erlang 已广泛应用于需要高可用性、高并发和软实时特性的
分布式系统开发中。

Erlang v26.0 采用 Apache-2.0 开源许可证，其运行时系统（BEAM 虚拟机）提供了轻量级进程、
消息传递、热代码升级、容错机制等独特能力。知名的 Erlang 应用包括 RabbitMQ（消息队列）、
CouchDB（文档数据库）、WhatsApp（即时通讯）和 Riak（分布式数据库）等。

Erlang 采用函数式编程范式，具有模式匹配、不可变数据结构等特性，其 OTP（Open Telecom Platform）
框架提供了一整套构建健壮分布式系统的中间件和设计模式。

- **版本**: v26.0
- **许可证**: Apache-2.0
- **官方网站**: https://www.erlang.org
- **安装方式**: Scoop 包管理器

## 主要功能

### 并发编程

Erlang 最显著的特点是其轻量级并发模型：

- 每个 Erlang 进程仅占用极少的内存（约 2KB），可以轻松创建数百万个并发进程
- 进程之间完全隔离，不共享内存，通过消息传递通信
- 内置调度器自动在多个 CPU 核心间分配进程
- 支持选择性接收（Selective Receive）模式
- 内置 `spawn`、`send`、`receive` 等并发原语

### 容错机制

Erlang 的 "Let it crash" 哲学是其独特优势：

- 进程隔离：一个进程崩溃不会影响其他进程
- 监督树（Supervisor Tree）：自动重启失败的进程
- 链接与监控（Link and Monitor）：进程间建立监督关系
- OTP 提供了标准的容错设计模式

### 热代码升级

Erlang 支持不停机的代码热升级：

- 可以在系统运行时替换模块代码
- 旧版本和新版本代码可以同时运行
- 自动将正在运行的进程迁移到新版本代码
- 无需停机即可修复 bug 或添加新功能

### 分布式计算

- 节点间可以直接发送消息，无需额外的通信库
- 内置节点发现和连接管理
- 支持全局注册和全局进程组
- 自动处理网络分区和节点故障

### OTP 框架

- GenServer：通用服务器行为
- GenStateMachine：有限状态机行为
- Supervisor：监督者行为
- Application：应用程序行为
- ETS/DETS：内存/磁盘表存储

## 常用命令/操作

### 命令行工具

Erlang 提供了多个命令行工具：

**erl.exe - Erlang 交互式 Shell**

启动 Erlang 的交互式解释器（REPL），可以逐行执行 Erlang 表达式：

```bash
erl
```

常用 erl 启动参数：

| 参数 | 说明 |
|------|------|
| `-name name` | 设置节点名称（长格式） |
| `-sname name` | 设置节点名称（短格式） |
| `-cookie cookie` | 设置分布式 Cookie |
| `-pa path` | 添加代码搜索路径 |
| `-eval expr` | 启动时执行表达式 |
| `-noshell` | 无 Shell 模式 |
| `-s mod func` | 启动时调用指定函数 |

在 Erlang Shell 中常用命令：

```erlang
halt().          % 退出 Shell
help().          % 显示帮助
i().             % 列出所有进程
c(module).       % 编译模块
pwd().           % 显示当前目录
ls().            % 列出目录文件
```

**erlc.exe - Erlang 编译器**

编译 Erlang 源文件（.erl）为字节码文件（.beam）：

```bash
erlc hello.erl
```

常用编译选项：

| 选项 | 说明 |
|------|------|
| `-o dir` | 指定输出目录 |
| `-I dir` | 添加头文件搜索路径 |
| `-Dmacro` | 定义宏 |
| `-W` | 启用所有警告 |
| `-debug_info` | 包含调试信息 |
| `+{d,macro,value}` | 定义带值的宏 |

编译并输出到指定目录：

```bash
erlc -o ebin/ -debug_info src/hello.erl
```

**escript.exe - Erlang 脚本执行器**

运行 Erlang 脚本文件，无需预先编译：

```bash
escript hello.escript
```

escript 文件示例：

```erlang
#!/usr/bin/env escript
main(Args) ->
    io:format("Hello, World!~n"),
    io:format("Arguments: ~p~n", [Args]).
```

**werl.exe - Windows 专用 Erlang Shell**

在 Windows 上提供带图形界面的 Erlang Shell，支持命令历史和复制粘贴功能：

```bash
werl
```

### 环境变量配置

Scoop 安装 Erlang 后会自动设置 `ERLANG_HOME` 环境变量，指向 Erlang 的安装目录。
该变量被许多依赖 Erlang 的应用程序使用（如 RabbitMQ）。

验证环境变量：

```bash
echo %ERLANG_HOME%
```

查看 Erlang 运行时路径：

```bash
erl -eval "io:format(\"~s~n\", [code:root_dir()])" -s init stop -noshell
```

### Rebar3 构建工具

Rebar3 是 Erlang 生态中最常用的构建和依赖管理工具：

```bash
rebar3 new app myapp
rebar3 compile
rebar3 eunit
rebar3 release
rebar3 shell
```

### 常用 Erlang 代码示例

Hello World：

```erlang
io:format("Hello, World!~n").
```

列表操作：

```erlang
List = [1, 2, 3, 4, 5].
lists:map(fun(X) -> X * 2 end, List).
lists:filter(fun(X) -> X > 3 end, List).
```

模式匹配：

```erlang
case {1, 2} of
    {1, 2} -> ok;
    _ -> error
end.
```

创建并发进程：

```erlang
Pid = spawn(fun() ->
    receive
        {From, hello} -> From ! {self(), world}
    end
end),
Pid ! {self(), hello},
receive
    {Pid, Response} -> io:format("Got: ~p~n", [Response])
end.
```

## 常见问题

### Q: 如何查看当前 Erlang 版本？

```bash
erl -eval "erlang:display(erlang:system_info(otp_release)), halt()." -noshell
```

或在 Erlang Shell 中：

```erlang
erlang:system_info(otp_release).
```

### Q: ERLANG_HOME 环境变量未设置怎么办？

使用 Scoop 安装时通常会自动设置。如果未设置，手动添加系统环境变量：

```powershell
[Environment]::SetEnvironmentVariable("ERLANG_HOME", "C:\Users\<username>\scoop\apps\erlang\current", "User")
```

### Q: 如何解决 Erlang 与 RabbitMQ 的版本兼容性问题？

RabbitMQ 对 Erlang 版本有严格要求。安装前请查看 RabbitMQ 官方文档中的
兼容性矩阵：https://www.rabbitmq.com/which-erlang.html

### Q: Erlang Shell 中如何输入多行代码？

在 Shell 中输入多行代码时，使用 `b().` 命令结束输入：

```erlang
1> case X of
1>     1 -> one;
1>     2 -> two
1> end.
```

### Q: 如何在 Windows 上使用 Erlang 构建原生代码？

安装 Visual Studio 或 Windows SDK 后，使用 rebar3：

```bash
rebar3 compile
```

### Q: 编译时出现 "can't find include lib" 错误？

确保已安装完整的 OTP 发行版，检查 lib 目录是否存在：

```bash
erl -eval "io:format(\"~s~n\", [code:lib_dir()]), halt()." -noshell
```

## 相关资源

- **官方网站**: https://www.erlang.org
- **官方文档**: https://www.erlang.org/doc
- **Erlang/OTP 源码**: https://github.com/erlang/otp
- **Rebar3 构建工具**: https://rebar3.org
- **Learn You Some Erlang**: https://learnyousomeerlang.com
- **Erlang Solutions**: https://www.erlang-solutions.com
- **Erlang 中文社区**: https://erlang-china.org
- **RabbitMQ**: https://www.rabbitmq.com
- **Scoop 包管理器**: https://scoop.sh
