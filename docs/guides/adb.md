# ADB (Android SDK Platform Tools) 使用指南

## 简介

ADB（Android Debug Bridge）是 Android SDK Platform Tools 的核心组件，版本 v34.0.5，采用免费软件授权。

Android SDK Platform Tools 包含与 Android 平台交互的工具，如 adb 和 fastboot。ADB 是一个通用命令行工具，允许您与模拟器实例或连接的 Android 设备进行通信。它提供了各种设备操作，例如安装和调试应用，以及提供对 Unix shell 的访问权限，您可以通过该 shell 在设备上运行各种命令。

**主要特性：**
- 免费软件，由 Google 官方维护
- 支持所有 Android 设备和模拟器
- 提供设备调试、文件传输、应用管理等功能
- 包含 fastboot 工具用于设备刷机

**官方网站：** https://developer.android.com/studio/releases/platform-tools

---

## 主要功能

### 1. 设备连接管理
ADB 可以通过 USB 或 Wi-Fi 连接 Android 设备，支持同时管理多个设备。它能够自动检测已连接的设备，并为每台设备分配唯一的序列号。

### 2. 应用安装与调试
支持直接安装 APK 文件到设备上，可以覆盖安装、降级安装，以及将应用安装到 SD 卡。同时提供完整的调试功能，包括日志查看、堆栈跟踪等。

### 3. 文件传输
提供设备与电脑之间的双向文件传输功能，支持推送文件到设备和从设备拉取文件。

### 4. Shell 命令执行
可以在设备上执行各种 shell 命令，如同在 Linux 终端中操作一样，支持交互式 shell 和单命令执行模式。

### 5. 端口转发
支持将设备上的端口转发到主机上，方便进行网络调试和开发。

### 6. Fastboot 模式
fastboot.exe 工具支持在设备 bootloader 模式下进行刷机、解锁等底层操作。

---

## 常用命令

### 包含的工具

| 工具名称 | 说明 |
|---------|------|
| adb.exe | Android Debug Bridge 主程序 |
| fastboot.exe | Bootloader 模式刷机工具 |
| dmtracedump.exe | 跟踪日志转储工具 |
| etc1tool.exe | ETC1 纹理压缩工具 |
| hprof-conv.exe | 堆内存分析文件转换工具 |

### 设备管理命令

```bash
# 查看已连接的设备
adb devices

# 查看设备详细信息
adb devices -l

# 连接到指定设备（多设备时使用）
adb -s <设备序列号> <命令>

# 通过 Wi-Fi 连接设备（先用 USB 连接）
adb tcpip 5555
adb connect <设备IP>:5555

# 断开 Wi-Fi 连接
adb disconnect <设备IP>:5555

# 重启 ADB 服务
adb kill-server
adb start-server
```

### 应用管理命令

```bash
# 安装应用
adb install <apk路径>

# 覆盖安装（保留数据）
adb install -r <apk路径>

# 安装到 SD 卡
adb install -s <apk路径>

# 降级安装
adb install -d <apk路径>

# 卸载应用
adb uninstall <包名>

# 卸载但保留数据
adb uninstall -k <包名>

# 列出已安装的应用
adb shell pm list packages

# 列出第三方应用
adb shell pm list packages -3

# 清除应用数据
adb shell pm clear <包名>
```

### 文件传输命令

```bash
# 推送文件到设备
adb push <本地路径> <设备路径>

# 从设备拉取文件
adb pull <设备路径> <本地路径>

# 推送整个目录
adb push <本地目录> <设备目录>
```

### Shell 命令

```bash
# 进入设备的交互式 shell
adb shell

# 执行单个 shell 命令
adb shell <命令>

# 查看设备属性
adb shell getprop

# 查看 Android 版本
adb shell getprop ro.build.version.release

# 查看设备型号
adb shell getprop ro.product.model

# 查看屏幕分辨率
adb shell wm size

# 截屏
adb shell screencap /sdcard/screenshot.png

# 录屏
adb shell screenrecord /sdcard/video.mp4
```

### 日志查看命令

```bash
# 查看实时日志
adb logcat

# 按标签过滤日志
adb logcat -s <标签>

# 清除日志缓冲区
adb logcat -c

# 将日志保存到文件
adb logcat > log.txt

# 查看内核日志
adb shell dmesg
```

### Fastboot 命令

```bash
# 进入 bootloader 模式
adb reboot bootloader

# 解锁 bootloader
fastboot flashing unlock

# 刷入分区
fastboot flash <分区名> <镜像文件>

# 刷入 boot 镜像
fastboot flash boot boot.img

# 刷入 recovery 镜像
fastboot flash recovery recovery.img

# 重启设备
fastboot reboot

# 查看设备状态
fastboot devices
```

### 其他常用命令

```bash
# 端口转发
adb forward tcp:<本地端口> tcp:<设备端口>

# 反向端口转发
adb reverse tcp:<设备端口> tcp:<本地端口>

# 查看设备电池信息
adb shell dumpsys battery

# 查看内存使用情况
adb shell dumpsys meminfo

# 查看 CPU 信息
adb shell cat /proc/cpuinfo

# 获取 bug 报告
adb bugreport

# 查看系统服务列表
adb shell service list
```

---

## 常见问题

### Q1: ADB 无法识别设备怎么办？

**可能原因及解决方案：**

1. **USB 调试未开启**
   - 进入设备的"设置" → "关于手机"
   - 连续点击"版本号"7次以开启开发者选项
   - 返回"设置" → "开发者选项"
   - 开启"USB 调试"

2. **驱动问题**
   - 安装设备对应的 USB 驱动程序
   - 使用通用 ADB 驱动程序
   - 在设备管理器中检查是否有未识别的设备

3. **USB 连接模式问题**
   - 确保设备选择了"文件传输(MTP)"模式
   - 尝试更换 USB 线缆或 USB 端口

4. **授权问题**
   - 首次连接时设备会弹出授权对话框
   - 点击"允许"并勾选"始终允许此计算机调试"

### Q2: 如何在多台设备同时连接时指定目标设备？

当连接多台设备时，使用 `-s` 参数指定设备序列号：

```bash
adb -s <设备序列号> <命令>
```

可以通过 `adb devices` 命令查看所有已连接设备的序列号。

### Q3: ADB 连接 Wi-Fi 调试总是断开怎么办？

**解决方案：**
1. 确保设备和电脑在同一局域网内
2. 使用静态 IP 地址连接
3. 检查路由器是否启用了 AP 隔离
4. Android 11+ 设备可使用无线调试功能，无需先用 USB 连接

### Q4: 安装 APK 时提示 "INSTALL_FAILED_ALREADY_EXISTS" 怎么办？

使用 `-r` 参数进行覆盖安装：

```bash
adb install -r <apk路径>
```

或者先卸载再安装：

```bash
adb uninstall <包名>
adb install <apk路径>
```

### Q5: 如何在没有 Root 权限的情况下查看应用数据？

虽然无法直接访问应用私有数据目录，但可以使用以下方法：

```bash
# 使用 run-as 命令（仅限 debuggable 应用）
adb shell run-as <包名> ls /data/data/<包名>/

# 备份应用数据
adb backup -apk -shared -all -f backup.ab
```

### Q6: Fastboot 命令无法执行怎么办？

1. 确保设备已进入 bootloader/fastboot 模式
2. 检查 fastboot 驱动是否正确安装
3. 尝试使用不同的 USB 端口（建议使用 USB 2.0）
4. 以管理员权限运行命令行

### Q7: ADB 端口被占用如何解决？

```bash
# 查看占用 5037 端口的进程
netstat -ano | findstr :5037

# 结束占用端口的进程
taskkill /PID <进程ID> /F

# 或者重启 ADB 服务
adb kill-server
adb start-server
```

### Q8: 如何在 Android 11+ 上使用无线调试？

1. 进入"设置" → "开发者选项"
2. 开启"无线调试"
3. 点击"使用配对码配对设备"
4. 在电脑上执行配对命令：
   ```bash
   adb pair <设备IP>:<配对端口> <配对码>
   ```
5. 连接设备：
   ```bash
   adb connect <设备IP>:<连接端口>
   ```

---

## 相关资源

### 官方文档
- [Android SDK Platform Tools 官方页面](https://developer.android.com/studio/releases/platform-tools)
- [ADB 官方文档](https://developer.android.com/studio/command-line/adb)
- [Fastboot 官方文档](https://android.googlesource.com/platform/system/core/+/master/fastboot/README.md)

### 下载与安装
- [SDK Platform Tools 下载](https://developer.android.com/studio/releases/platform-tools#download)
- [Scoop 包管理器](https://scoop.sh/)

### 学习资源
- [ADB 命令大全](https://developer.android.com/studio/command-line/adb)
- [Android 开发者指南](https://developer.android.com/guide)
- [XDA Developers 论坛](https://forum.xda-developers.com/)

### 工具与插件
- [ADB Shell 命令参考](https://developer.android.com/studio/command-line/shell)
- [Scrcpy - 屏幕镜像工具](https://github.com/Genymobile/scrcpy)
- [Android File Transfer](https://www.android.com/filetransfer/)

### 社区支持
- [Stack Overflow ADB 标签](https://stackoverflow.com/questions/tagged/adb)
- [Reddit r/Android](https://www.reddit.com/r/Android/)
- [GitHub Issues](https://github.com/nicehash/NiceHashQuickMiner/issues)

---

## 更新日志

### v34.0.5
- 修复了若干稳定性问题
- 改进了设备连接兼容性
- 更新了底层库文件

---

*本文档最后更新于：2026年5月27日*
