# Gradle 使用指南

## 简介

Gradle 是一款开源的构建自动化工具，专注于灵活性和高性能。它使用 Groovy 或 Kotlin DSL
（领域特定语言）来描述构建脚本，比传统的 XML 配置更加简洁和强大。

Gradle v8.4 是当前的稳定版本，采用 Apache-2.0 开源许可证。Gradle 广泛应用于 Java、
Kotlin、Android、C/C++ 等项目的构建管理，是 Android 官方推荐的构建工具，
也被 Spring Boot、Micronaut 等主流框架所采用。

Gradle 的核心设计理念包括增量构建、构建缓存、并行执行和守护进程模式，这些特性使得大型项目的
构建速度显著优于其他构建工具。Gradle Wrapper（gradlew）机制确保了团队成员使用相同版本的
Gradle，避免了环境差异带来的构建问题。

- **版本**: v8.4
- **许可证**: Apache-2.0
- **官方网站**: https://gradle.org
- **安装方式**: Scoop 包管理器

## 主要功能

### 增量构建

Gradle 的增量构建功能可以智能地跳过未发生变化的任务：

- 追踪输入和输出文件的变化
- 只重新执行受影响的任务
- 支持类级别的增量编译
- 构建缓存支持本地和远程缓存

### 灵活的构建脚本

- 使用 Groovy DSL（build.gradle）或 Kotlin DSL（build.gradle.kts）
- 丰富的插件生态系统
- 支持自定义任务类型
- 支持构建生命周期钩子
- Convention over Configuration 设计模式

### 依赖管理

- 支持 Maven 和 Ivy 仓库
- 支持本地文件依赖
- 传递依赖自动解析
- 依赖版本冲突自动解决
- 依赖锁定（Dependency Locking）
- 平台/BOM（Bill of Materials）依赖管理
- 版本目录（Version Catalog）

### 多项目构建

- 支持大型多模块项目的构建
- 配置避免（Configuration Avoidance）
- 任务避免（Task Avoidance）
- 智能的项目依赖分析和并行构建

### Gradle Wrapper

- 自动下载和使用指定版本的 Gradle
- 确保团队成员使用相同的构建工具版本
- 支持 CI/CD 环境的一致性

### 构建扫描与分析

- 构建扫描（Build Scan）功能
- 性能分析报告
- 任务执行时间统计
- 构建缓存命中率分析

## 常用命令/操作

### 基本命令

Scoop 安装后使用 `gradle.bat` 命令（通常简化为 `gradle`）：

```bash
gradle build
```

常用基础命令：

| 命令 | 说明 |
|------|------|
| `gradle build` | 执行完整的构建（编译、测试、打包） |
| `gradle clean` | 清理 build 目录 |
| `gradle test` | 运行测试 |
| `gradle check` | 运行所有检查任务 |
| `gradle assemble` | 编译和打包，不运行测试 |
| `gradle classes` | 编译主代码和处理资源 |
| `gradle testClasses` | 编译测试代码和处理测试资源 |
| `gradle jar` | 打包为 JAR 文件 |
| `gradle war` | 打包为 WAR 文件 |
| `gradle publish` | 发布构件到仓库 |

### 项目初始化

创建新项目时需要初始化 Gradle Wrapper：

```bash
gradle wrapper --gradle-version 8.4
```

之后团队成员只需使用 Wrapper 脚本：

```bash
gradlew build
```

### 查看项目信息

查看项目结构：

```bash
gradle projects
```

查看所有可用任务：

```bash
gradle tasks
```

查看所有任务（包括隐藏的）：

```bash
gradle tasks --all
```

查看项目属性：

```bash
gradle properties
```

查看依赖树：

```bash
gradle dependencies
```

查看特定配置的依赖：

```bash
gradle dependencies --configuration compileClasspath
```

### 构建配置

**build.gradle（Groovy DSL）示例：**

```groovy
plugins {
    id 'java'
    id 'application'
}

group = 'com.example'
version = '1.0.0'

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.apache.commons:commons-lang3:3.14.0'
    implementation 'com.google.guava:guava:32.1.3-jre'

    testImplementation 'org.junit.jupiter:junit-jupiter:5.10.1'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}

application {
    mainClass = 'com.example.Main'
}

test {
    useJUnitPlatform()
}
```

**build.gradle.kts（Kotlin DSL）示例：**

```kotlin
plugins {
    java
    application
}

group = "com.example"
version = "1.0.0"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.apache.commons:commons-lang3:3.14.0")
    implementation("com.google.guava:guava:32.1.3-jre")

    testImplementation("org.junit.jupiter:junit-jupiter:5.10.1")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

application {
    mainClass.set("com.example.Main")
}

tasks.test {
    useJUnitPlatform()
}
```

### 执行应用程序

运行 main 方法：

```bash
gradle run
```

传递应用参数：

```bash
gradle run --args="arg1 arg2"
```

### 测试相关

运行测试并生成报告：

```bash
gradle test
```

测试报告默认生成在 `build/reports/tests/test/index.html`。

运行特定测试类：

```bash
gradle test --tests "com.example.MyTest"
```

运行特定测试方法：

```bash
gradle test --tests "com.example.MyTest.testMethod"
```

### 发布与部署

发布到本地 Maven 仓库：

```bash
gradle publishToMavenLocal
```

发布到远程仓库：

```bash
gradle publish
```

### 性能优化选项

| 选项 | 说明 |
|------|------|
| `--parallel` | 并行执行项目任务 |
| `--build-cache` | 启用构建缓存 |
| `--daemon` | 使用 Gradle 守护进程 |
| `--no-daemon` | 不使用守护进程 |
| `--configure-on-demand` | 只配置需要的项目 |
| `--max-workers=N` | 设置最大并行线程数 |
| `--profile` | 生成构建性能报告 |
| `--scan` | 创建构建扫描 |

### Gradle Wrapper 命令

更新 Wrapper 版本：

```bash
gradle wrapper --gradle-version 8.4
```

验证 Wrapper：

```bash
gradlew --version
```

### 环境变量

Scoop 安装后会自动设置 `GRADLE_USER_HOME` 环境变量，指向 Gradle 用户主目录，
该目录用于存储：

- 缓存的依赖库
- Wrapper 分发文件
- 构建缓存
- 初始化脚本

默认路径为 `~/.gradle`。

验证环境变量：

```powershell
echo $env:GRADLE_USER_HOME
```

### Gradle 配置文件

全局配置文件 `~/.gradle/gradle.properties`：

```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=512m
```

## 常见问题

### Q: 构建速度慢如何优化？

1. 启用守护进程：`org.gradle.daemon=true`
2. 开启并行构建：`org.gradle.parallel=true`
3. 启用构建缓存：`org.gradle.caching=true`
4. 增加 JVM 内存：`org.gradle.jvmargs=-Xmx4g`
5. 使用 `--profile` 分析构建瓶颈
6. 避免不必要的配置阶段

### Q: 如何解决依赖冲突？

使用依赖约束：

```groovy
dependencies {
    constraints {
        implementation('com.google.guava:guava:32.1.3-jre')
    }
}
```

或排除传递依赖：

```groovy
dependencies {
    implementation('some:library:1.0') {
        exclude group: 'unwanted', module: 'dependency'
    }
}
```

查看依赖树分析冲突：

```bash
gradle dependencies --configuration compileClasspath
```

### Q: Gradle Wrapper 下载失败怎么办？

1. 检查网络连接
2. 配置代理：在 `~/.gradle/gradle.properties` 中设置
   ```properties
   systemProp.http.proxyHost=proxy.example.com
   systemProp.http.proxyPort=8080
   systemProp.https.proxyHost=proxy.example.com
   systemProp.https.proxyPort=8080
   ```
3. 使用国内镜像：修改 `gradle-wrapper.properties` 中的 distributionUrl

### Q: 如何配置国内 Maven 镜像？

在 `build.gradle` 中：

```groovy
repositories {
    maven { url 'https://maven.aliyun.com/repository/public' }
    mavenCentral()
}
```

或在 `~/.gradle/init.d/mirror.gradle` 中全局配置。

### Q: 如何创建可执行的 Fat JAR？

使用 Shadow 插件：

```groovy
plugins {
    id 'com.github.johnrengelman.shadow' version '8.1.1'
}

shadowJar {
    archiveClassifier.set('')
    manifest {
        attributes 'Main-Class': 'com.example.Main'
    }
}
```

### Q: 如何在 Gradle 中使用多版本 JDK？

使用 Toolchains 功能：

```groovy
java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}
```

## 相关资源

- **官方网站**: https://gradle.org
- **官方文档**: https://docs.gradle.org
- **Gradle API 文档**: https://docs.gradle.org/current/javadoc/
- **插件门户**: https://plugins.gradle.org
- **Gradle GitHub**: https://github.com/gradle/gradle
- **Gradle 中国社区镜像**: https://mirrors.cloud.tencent.com/gradle/
- **Maven Central**: https://search.maven.org
- **Scoop 包管理器**: https://scoop.sh
