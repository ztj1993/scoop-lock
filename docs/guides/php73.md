# PHP 7.3 使用指南

> 版本：v7.3 | 许可证：PHP-3.01 | 官网：https://windows.php.net/

---

## 简介

PHP（Hypertext Preprocessor，超文本预处理器）是一种广泛使用的开源通用脚本语言，特别适合 Web 开发并可以嵌入 HTML 中。PHP 7.3 是 PHP 7 系列的一个重要版本，带来了多项性能优化和新特性。

PHP 由 Rasmus Lerdorf 于 1995 年创建，现由 The PHP Group 维护。它是世界上最流行的服务器端脚本语言之一，被全球超过 78% 的网站使用，包括 WordPress、Facebook、Wikipedia 等知名平台。

### PHP 7.3 新特性

- **灵活的 Heredoc/Nowdoc 语法**：减少缩进限制
- **数组解构支持引用**：`[&$a, $b] = $array`
- **JSON_THROW_ON_ERROR**：JSON 错误时抛出异常
- **is_countable() 函数**：检查变量是否可计数
- **array_key_first() / array_key_last()**：获取数组首/末键
- **PCRE2 迁移**：使用 PCRE2 正则表达式库
- **LDAP 重命名支持**：ldap_rename 扩展支持
- **性能提升**：相比 PHP 7.2 提升约 5-10%

### 核心特性

- **跨平台**：支持 Windows、Linux、macOS 等
- **丰富的扩展**：大量内置和第三方扩展
- **多种数据库支持**：MySQL、PostgreSQL、SQLite、MongoDB 等
- **面向对象**：完整的 OOP 支持
- **命名空间**：避免类名冲突
- **Composer**：依赖管理工具
- **错误处理**：异常和错误处理机制
- **会话管理**：内置会话支持
- **文件处理**：丰富的文件操作函数
- **网络功能**：cURL、Socket、HTTP 等

### 适用场景

- Web 应用开发
- 内容管理系统（WordPress、Drupal、Joomla）
- 电子商务平台
- RESTful API 开发
- 命令行脚本
- 数据处理和分析
- 自动化任务

---

## 主要功能

### 1. Web 开发

PHP 最主要的用途是服务端 Web 开发：

- 动态页面生成
- 表单处理
- 会话管理
- Cookie 处理
- 文件上传
- 邮件发送

### 2. 数据库交互

支持多种数据库：

- MySQL/MariaDB（mysql、mysqli、PDO）
- PostgreSQL（pgsql、PDO）
- SQLite（sqlite3、PDO）
- MongoDB（mongodb 扩展）
- SQL Server（sqlsrv、PDO）
- Oracle（oci8）

### 3. 文件处理

强大的文件操作能力：

- 文件读写
- 目录操作
- 文件上传
- 图像处理（GD、Imagick）
- PDF 生成
- ZIP 处理

### 4. 网络功能

支持多种网络协议：

- HTTP 请求（cURL、Guzzle）
- FTP 操作
- Socket 编程
- 邮件发送（SMTP）
- DNS 查询
- WebSocket

### 5. 数据处理

- JSON 编解码
- XML 处理
- 正则表达式
- 字符串处理
- 数组操作
- 日期时间处理

### 6. 安全功能

- 密码哈希（password_hash）
- CSRF 防护
- XSS 防护
- SQL 注入防护（PDO 预处理）
- 数据过滤（filter_var）
- 加密/解密（OpenSSL）

### 7. 扩展系统

PHP 的强大之处在于其丰富的扩展：

- 核心扩展（默认启用）
- PECL 扩展（需要单独安装）
- Composer 包（通过包管理器安装）

---

## 常用命令

### php.exe - PHP 命令行解释器

```powershell
# 查看 PHP 版本
php -v

# 查看 PHP 配置信息
php -i

# 查看 PHP 配置文件路径
php --ini

# 运行 PHP 脚本
php script.php

# 运行内联 PHP 代码
php -r "echo 'Hello World';"

# 语法检查
php -l script.php

# 显示已加载的扩展
php -m

# 查看特定扩展信息
php --ri curl

# 查看特定配置项
php -r "echo ini_get('display_errors');"

# 以 CLI 模式运行
php -q script.php

# 设置自定义 php.ini
php -c /path/to/php.ini script.php

# 定义常量
php -d "MY_CONSTANT=value" script.php

# 设置 include_path
php -d "include_path=/path/to/libs" script.php

# 交互式模式（REPL）
php -a

# 启用错误显示
php -d "display_errors=On" -d "error_reporting=E_ALL" script.php

# 查看所有配置选项
php -r "print_r(ini_get_all());"

# 运行内置 Web 服务器（PHP 5.4+）
php -S localhost:8000

# 指定文档根目录
php -S localhost:8000 -t /path/to/document/root

# 使用路由脚本
php -S localhost:8000 router.php

# 代码性能分析
php -d "xdebug.profiler_enable=1" script.php

# 内存使用限制
php -d "memory_limit=256M" script.php

# 执行时间限制
php -d "max_execution_time=300" script.php
```

### php-cgi.exe - CGI 接口

```powershell
# 以 CGI 模式运行
php-cgi script.php

# 查看 CGI 版本信息
php-cgi -v

# 查看 CGI 配置
php-cgi -i

# 作为 FastCGI 进程运行
php-cgi -b 127.0.0.1:9000

# 指定配置文件
php-cgi -c /path/to/php.ini

# 查看已加载扩展
php-cgi -m
```

### phpdbg.exe - PHP 调试器

```powershell
# 启动调试器
phpdbg

# 调试脚本
phpdbg -qrr script.php

# 查看帮助
phpdbg -h

# 在指定行设置断点
# (在 phpdbg 交互模式中)
# b script.php:10

# 执行脚本
# (在 phpdbg 交互模式中)
# r

# 查看变量
# (在 phpdbg 交互模式中)
# p $variable

# 单步执行
# (在 phpdbg 交互模式中)
# n

# 继续执行
# (在 phpdbg 交互模式中)
# c
```

### 配置文件 (php.ini)

PHP 通过 `cli/php.ini` 文件进行配置。以下是常用配置项：

```ini
[PHP]
; 错误处理
error_reporting = E_ALL
display_errors = On
display_startup_errors = Off
log_errors = On
error_log = "C:/php/logs/php_errors.log"

; 资源限制
max_execution_time = 30
max_input_time = 60
memory_limit = 128M

; 文件上传
file_uploads = On
upload_max_filesize = 64M
max_file_uploads = 20
post_max_size = 64M

; 时区设置
date.timezone = Asia/Shanghai

; 扩展目录
extension_dir = "ext"

; 数据处理
default_charset = "UTF-8"
mbstring.language = Neutral
mbstring.internal_encoding = UTF-8
mbstring.http_input = auto
mbstring.http_output = UTF-8
mbstring.encoding_translation = Off
mbstring.func_overload = 0

; Session 配置
session.save_handler = files
session.save_path = "C:/php/sessions"
session.use_strict_mode = 0
session.use_cookies = 1
session.name = PHPSESSID
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_httponly = 1

; OPcache 配置
opcache.enable=1
opcache.enable_cli=0
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=10000
opcache.revalidate_freq=2
opcache.fast_shutdown=1

; 常用扩展（取消注释以启用）
; extension=curl
; extension=gd
; extension=mbstring
; extension=mysqli
; extension=openssl
; extension=pdo_mysql
; extension=pdo_sqlite
; extension=soap
; extension=sockets
; extension=sodium
; extension=xml
; extension=zip
```

### 常用 PHP 代码示例

#### 基本输出

```php
<?php
echo "Hello World!\n";
print "PHP Version: " . PHP_VERSION . "\n";
var_dump($_SERVER);
phpinfo();
?>
```

#### 文件操作

```php
<?php
// 读取文件
$content = file_get_contents('file.txt');
echo $content;

// 写入文件
file_put_contents('output.txt', 'Hello World');

// 逐行读取
$lines = file('file.txt', FILE_IGNORE_NEW_LINES);
foreach ($lines as $line) {
    echo $line . "\n";
}

// 文件是否存在
if (file_exists('file.txt')) {
    echo 'File exists';
}

// 目录操作
$files = scandir('.');
print_r($files);
?>
```

#### 数据库操作（PDO）

```php
<?php
try {
    $pdo = new PDO(
        'mysql:host=localhost;dbname=testdb;charset=utf8mb4',
        'username',
        'password',
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );

    // 查询数据
    $stmt = $pdo->query('SELECT * FROM users');
    $users = $stmt->fetchAll();
    print_r($users);

    // 预处理语句
    $stmt = $pdo->prepare('SELECT * FROM users WHERE id = :id');
    $stmt->execute(['id' => 1]);
    $user = $stmt->fetch();
    print_r($user);

    // 插入数据
    $stmt = $pdo->prepare('INSERT INTO users (name, email) VALUES (:name, :email)');
    $stmt->execute([
        'name' => 'John Doe',
        'email' => 'john@example.com'
    ]);

    echo 'Last insert ID: ' . $pdo->lastInsertId();

} catch (PDOException $e) {
    echo 'Database error: ' . $e->getMessage();
}
?>
```

#### JSON 处理

```php
<?php
// 编码 JSON
$data = ['name' => 'John', 'age' => 30, 'city' => 'Beijing'];
$json = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
echo $json;

// 解码 JSON
$decoded = json_decode($json, true);
print_r($decoded);

// PHP 7.3: JSON_THROW_ON_ERROR
try {
    $result = json_decode($invalidJson, true, 512, JSON_THROW_ON_ERROR);
} catch (JsonException $e) {
    echo 'JSON error: ' . $e->getMessage();
}
?>
```

#### cURL 请求

```php
<?php
// GET 请求
$ch = curl_init('https://api.example.com/data');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "HTTP Code: $httpCode\n";
echo "Response: $response\n";

// POST 请求
$data = json_encode(['key' => 'value']);
$ch = curl_init('https://api.example.com/data');
curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => $data,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        'Content-Type: application/json',
        'Content-Length: ' . strlen($data)
    ]
]);
$response = curl_exec($ch);
curl_close($ch);
?>
```

#### 命令行参数处理

```php
<?php
// 获取命令行参数
$options = getopt('f:o:h', ['file:', 'output:', 'help']);

if (isset($options['h']) || isset($options['help'])) {
    echo "Usage: php script.php -f <file> -o <output>\n";
    exit(0);
}

$file = $options['f'] ?? $options['file'] ?? null;
$output = $options['o'] ?? $options['output'] ?? null;

if (!$file) {
    echo "Error: File argument required\n";
    exit(1);
}

// 超全局变量
// $argv - 参数数组
// $argc - 参数数量
global $argv, $argc;
echo "Arguments: $argc\n";
print_r($argv);
?>
```

### 内置 Web 服务器

```powershell
# 启动内置 Web 服务器
php -S localhost:8000

# 指定文档根目录
php -S localhost:8000 -t ./public

# 使用路由器脚本
php -S localhost:8000 router.php

# 指定 IP 和端口
php -S 0.0.0.0:8080
```

路由器脚本示例（router.php）：

```php
<?php
// router.php
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if ($uri === '/') {
    require __DIR__ . '/index.php';
    return true;
}

if (file_exists(__DIR__ . $uri)) {
    return false;
}

require __DIR__ . '/index.php';
?>
```

---

## 常见问题

### Q1: PHP 命令无法识别怎么办？

**解决方案：**

1. **检查环境变量**：确保 PHP 安装目录已添加到 PATH
   ```powershell
   # 临时添加
   $env:PATH += ";C:\php"

   # 永久添加（需要管理员权限）
   [Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\php", "User")
   ```

2. **检查安装**：确认 PHP 已正确安装
   ```powershell
   & "C:\php\php.exe" -v
   ```

3. **通过 Scoop 安装**：
   ```powershell
   scoop install php73
   ```

### Q2: 如何启用 PHP 扩展？

1. **编辑 php.ini 文件**：
   ```powershell
   php --ini  # 查看配置文件路径
   ```

2. **取消注释扩展行**：
   ```ini
   ; 找到以下行，去掉前面的分号
   extension=curl
   extension=gd
   extension=mysqli
   ```

3. **或使用 dl() 函数动态加载**（仅 CLI 模式）：
   ```php
   dl('curl');
   ```

4. **重启 Web 服务器**使配置生效

### Q3: 如何解决中文乱码问题？

1. **设置默认字符集**：
   ```ini
   default_charset = "UTF-8"
   ```

2. **PHP 文件使用 UTF-8 编码保存**

3. **HTML 页面设置编码**：
   ```php
   header('Content-Type: text/html; charset=utf-8');
   ```

4. **数据库连接设置编码**：
   ```php
   $pdo = new PDO('mysql:host=localhost;dbname=test;charset=utf8mb4', ...);
   ```

### Q4: 如何配置 Xdebug 调试器？

1. **下载 Xdebug**：访问 https://xdebug.org/download 下载对应版本

2. **配置 php.ini**：
   ```ini
   [Xdebug]
   zend_extension="C:/php/ext/php_xdebug.dll"
   xdebug.mode=debug
   xdebug.start_with_request=yes
   xdebug.client_port=9003
   xdebug.client_host=127.0.0.1
   ```

3. **配置 IDE**：在 VS Code 或 PHPStorm 中配置 Xdebug

### Q5: 内置 Web 服务器能否用于生产环境？

**不能**。PHP 内置 Web 服务器仅用于开发和测试环境，不支持并发处理，不适合生产环境。生产环境应使用：

- Apache + mod_php
- Nginx + PHP-FPM
- IIS + FastCGI

### Q6: 如何优化 PHP 性能？

1. **启用 OPcache**：
   ```ini
   opcache.enable=1
   opcache.memory_consumption=128
   ```

2. **调整内存限制**：
   ```ini
   memory_limit=256M
   ```

3. **使用 Composer 优化自动加载**：
   ```powershell
   composer dump-autoload --optimize
   ```

4. **减少文件包含**：使用命名空间和自动加载

5. **使用缓存**：Redis、Memcached

6. **避免在循环中查询数据库**

### Q7: PHP 7.3 已经停止安全支持，如何升级？

PHP 7.3 的官方支持已结束，建议升级到 PHP 8.x：

1. **备份代码和数据库**
2. **检查代码兼容性**：使用 PHP Compatibility 工具
3. **更新依赖包**：`composer update`
4. **测试新版本**
5. **逐步迁移**

---

## 相关资源

### 官方资源

- PHP 官网：https://www.php.net/
- PHP 7.3 文档：https://www.php.net/manual/en/migration73.php
- PHP Windows 下载：https://windows.php.net/download
- PHP 扩展库：https://pecl.php.net/
- Composer：https://getcomposer.org/

### PHP 框架

- Laravel：https://laravel.com/
- Symfony：https://symfony.com/
- CodeIgniter：https://codeigniter.com/
- Yii：https://www.yiiframework.com/
- ThinkPHP：https://www.thinkphp.cn/

### 开发工具

- PHPStorm：https://www.jetbrains.com/phpstorm/
- VS Code + PHP 插件：https://code.visualstudio.com/
- Xdebug：https://xdebug.org/
- PHP-CS-Fixer：https://github.com/PHP-CS-Fixer/PHP-CS-Fixer
- PHPStan：https://phpstan.org/
- Psalm：https://psalm.dev/

### 包管理

- Composer：https://getcomposer.org/
- Packagist：https://packagist.org/

### 学习资源

- PHP 菜鸟教程：https://www.runoob.com/php/php-tutorial.html
- PHP The Right Way：https://phptherightway.com/
- PHP-FIG（编码标准）：https://www.php-fig.org/
- Laracasts（视频教程）https://laracasts.com/

### 社区资源

- Stack Overflow PHP 标签：https://stackoverflow.com/questions/tagged/php
- Reddit r/PHP：https://www.reddit.com/r/PHP/
- PHP 中文社区：https://php.net/

### PHP 7.3 迁移指南

- 从 PHP 7.2 迁移：https://www.php.net/manual/en/migration73.php
- 废弃特性：https://www.php.net/manual/en/migration73.deprecated.php
- 向后不兼容变更：https://www.php.net/manual/en/migration73.incompatible.php
