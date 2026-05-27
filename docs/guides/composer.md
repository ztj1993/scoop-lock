# Composer 使用指南

## 简介

Composer 是 PHP 的依赖管理工具，当前版本为 v2.4.1，采用 MIT 开源许可证。

Composer 允许您声明项目所依赖的库，并为您管理（安装/更新）这些依赖。它是 PHP 生态系统中最重要的工具之一，类似于 Node.js 的 npm 或 Python 的 pip。

**主要特性：**
- PHP 官方依赖管理工具
- MIT 开源许可证
- 支持自动加载
- 版本约束管理
- 使用 Aliyun 镜像加速
- 跨平台支持

**官方网站：** https://getcomposer.org/

---

## 主要功能

### 1. 依赖管理
Composer 能够自动解决项目依赖关系，下载并安装所需的库。它支持复杂的版本约束，确保依赖兼容性。

### 2. 自动加载
自动生成符合 PSR-4 标准的自动加载文件，简化类的引入过程。无需手动 require 或 include 文件。

### 3. 版本锁定
通过 composer.lock 文件锁定依赖版本，确保团队成员和部署环境使用相同的依赖版本。

### 4. 包发布
支持将自己的代码发布为 Composer 包，供他人使用。遵循 Packagist 标准。

### 5. 脚本执行
支持在特定事件（如安装、更新前后）执行自定义脚本，方便自动化工作流。

### 6. 仓库管理
支持多种仓库类型，包括 Packagist、私有仓库、本地路径仓库等。

---

## 常用命令/操作

### 安装与配置

```bash
# 通过 Scoop 安装
scoop install composer

# 验证安装
composer --version

# 查看帮助
composer --help

# 配置中国镜像（已默认使用 Aliyun 镜像）
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# 查看全局配置
composer config -g --list

# 设置 GitHub OAuth Token（避免 API 限制）
composer config -g github-oauth.github.com <your-token>
```

### 项目初始化

```bash
# 交互式创建 composer.json
composer init

# 示例交互过程：
# Package name (<vendor>/<name>): myproject/app
# Description: My PHP application
# Author: Your Name <your@email.com>
# Minimum Stability: stable
# License: MIT
```

### 依赖管理

```bash
# 安装所有依赖
composer install

# 安装指定包
composer require <vendor/package>

# 安装指定版本
composer require <vendor/package>:^2.0

# 安装开发依赖
composer require --dev <vendor/package>

# 移除包
composer remove <vendor/package>

# 更新所有依赖
composer update

# 更新指定包
composer update <vendor/package>

# 更新 composer 本身
composer self-update

# 查看已安装的包
composer show

# 查看包的详细信息
composer show <vendor/package>

# 检查过时的依赖
composer outdated
```

### 版本约束

```bash
# 精确版本
composer require vendor/package:1.2.3

# 版本范围
composer require vendor/package:>=1.0 <2.0

# 通配符
composer require vendor/package:1.2.*

# 波浪号约束（允许补丁版本更新）
composer require vendor/package:~1.2

# 脱字号约束（允许次版本更新）
composer require vendor/package:^1.2

# 分支约束
composer require vendor/package:dev-main
```

### 自动加载

```bash
# 生成自动加载文件
composer dump-autoload

# 优化自动加载（生产环境推荐）
composer dump-autoload --optimize

# 查看自动加载配置
composer show --self
```

### 脚本执行

```bash
# 运行 composer 脚本
composer run-script <script-name>

# 运行自定义脚本
composer run-script post-install-cmd

# 执行 PHP 脚本
composer exec phpunit

# 执行包提供的命令
composer exec -- <command>
```

### 仓库操作

```bash
# 搜索包
composer search <keyword>

# 验证 composer.json
composer validate

# 诊断项目问题
composer diagnose

# 清除缓存
composer clear-cache

# 查看缓存目录
composer cache-dir
```

### 常用包示例

```bash
# 安装 Laravel 框架
composer create-project laravel/laravel my-project

# 安装 Symfony 框架
composer create-project symfony/skeleton my-project

# 安装 PHPUnit 测试框架
composer require --dev phpunit/phpunit

# 安装 PHP_CodeSniffer
composer require --dev squizlabs/php_codesniffer

# 安装 Monolog 日志库
composer require monolog/monolog

# 安装 Guzzle HTTP 客户端
composer require guzzlehttp/guzzle

# 安装 Twig 模板引擎
composer require twig/twig
```

### composer.json 示例

```json
{
    "name": "myproject/app",
    "description": "My PHP Application",
    "type": "project",
    "license": "MIT",
    "require": {
        "php": ">=8.1",
        "monolog/monolog": "^3.0",
        "guzzlehttp/guzzle": "^7.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "squizlabs/php_codesniffer": "^3.7"
    },
    "autoload": {
        "psr-4": {
            "MyProject\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "MyProject\\Tests\\": "tests/"
        }
    },
    "scripts": {
        "test": "phpunit",
        "cs-check": "phpcs",
        "cs-fix": "phpcbf",
        "post-install-cmd": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ]
    },
    "config": {
        "optimize-autoloader": true,
        "preferred-install": "dist",
        "sort-packages": true
    },
    "minimum-stability": "stable",
    "prefer-stable": true
}
```

### 镜像配置

```bash
# 使用 Aliyun 镜像（推荐，已默认配置）
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# 使用 Laravel China 镜像
composer config -g repo.packagist composer https://mirrors.laravel.com/

# 使用腾讯云镜像
composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer/

# 取消镜像配置
composer config -g --unset repos.packagist

# 仅当前项目使用镜像
composer config repo.packagist composer https://mirrors.aliyun.com/composer/
```

### 环境变量

```bash
# 设置 Composer 主目录
export COMPOSER_HOME=$HOME/.composer

# 设置 Composer 缓存目录
export COMPOSER_CACHE_DIR=$HOME/.composer/cache

# 设置 Composer 环境文件路径
export COMPOSER=/path/to/composer.json

# 禁用交互模式（CI/CD 环境）
export COMPOSER_NO_INTERACTION=1

# 设置内存限制
export COMPOSER_MEMORY_LIMIT=-1
```

---

## 常见问题

### Q1: Composer 安装依赖很慢怎么办？

**解决方案：**

1. **使用中国镜像**
   ```bash
   # 配置 Aliyun 镜像
   composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
   ```

2. **优化安装选项**
   ```bash
   # 使用 --prefer-dist（推荐）
   composer install --prefer-dist
   
   # 并行下载
   composer install --prefer-dist --no-scripts
   ```

3. **清理缓存**
   ```bash
   composer clear-cache
   ```

4. **使用 --no-dev 生产环境**
   ```bash
   composer install --no-dev --optimize-autoloader
   ```

### Q2: 如何解决版本冲突问题？

**排查步骤：**

1. **查看依赖树**
   ```bash
   composer show --tree
   ```

2. **诊断问题**
   ```bash
   composer diagnose
   ```

3. **分析冲突原因**
   ```bash
   composer why-not <vendor/package> <version>
   ```

4. **解决方案**
   - 调整版本约束
   - 使用 `--with-all-dependencies` 更新相关依赖
   - 手动解决冲突

### Q3: 如何处理 "Allowed memory size exhausted" 错误？

**解决方案：**

```bash
# 方法一：增加内存限制
php -d memory_limit=-1 /usr/local/bin/composer install

# 方法二：设置环境变量
export COMPOSER_MEMORY_LIMIT=-1
composer install

# 方法三：使用命令行参数
COMPOSER_MEMORY_LIMIT=-1 composer install
```

### Q4: composer.lock 文件应该提交到版本控制吗？

**建议：**

- **项目（Applications）**：应该提交
  - 确保团队成员使用相同版本
  - 保证生产环境和开发环境一致
  
- **库（Libraries）**：不应该提交
  - 让使用者决定具体版本
  - 在 .gitignore 中添加 composer.lock

### Q5: 如何创建自己的 Composer 包？

**步骤：**

1. **创建 composer.json**
   ```bash
   composer init
   ```

2. **添加自动加载配置**
   ```json
   {
       "autoload": {
           "psr-4": {
               "Vendor\\Package\\": "src/"
           }
       }
   }
   ```

3. **发布到 Packagist**
   - 在 GitHub 上创建仓库
   - 在 Packagist.org 提交
   - 设置自动更新钩子

### Q6: 如何在生产环境优化 Composer？

**优化建议：**

```bash
# 安装时优化
composer install --no-dev --optimize-autoloader --no-scripts

# 生成优化的自动加载文件
composer dump-autoload --optimize --classmap-authoritative

# 使用 --classmap-authoritative 提高性能
# 注意：这会禁用 PSR-4 回退
```

### Q7: 如何处理 SSL 证书问题？

**解决方案：**

```bash
# 方法一：更新 CA 证书
composer config -g cafile /path/to/cacert.pem

# 方法二：禁用 SSL 验证（不推荐）
composer config -g disable-tls true

# 方法三：使用 HTTP 代替 HTTPS（不推荐）
composer config -g secure-http false
```

### Q8: 如何使用私有 Composer 仓库？

**配置私有仓库：**

```json
{
    "repositories": [
        {
            "type": "composer",
            "url": "https://packages.example.com"
        },
        {
            "type": "vcs",
            "url": "https://github.com/your-org/private-package"
        },
        {
            "type": "path",
            "url": "packages/local-package"
        }
    ]
}
```

**认证配置：**

```bash
# 设置 HTTP 认证
composer config -g http-basic.packages.example.com username password

# 设置 GitHub Token
composer config -g github-oauth.github.com <your-token>

# 设置 GitLab Token
composer config -g gitlab-oauth.gitlab.com <your-token>
```

---

## 相关资源

### 官方资源
- [Composer 官方网站](https://getcomposer.org/)
- [Composer 文档](https://getcomposer.org/doc/)
- [Packagist 包仓库](https://packagist.org/)

### 安装与配置
- [Composer 安装指南](https://getcomposer.org/doc/00-intro.md)
- [Scoop 包管理器](https://scoop.sh/)
- [Aliyun 镜像](https://mirrors.aliyun.com/composer/)

### 学习资源
- [PHP 官方文档](https://www.php.net/manual/)
- [Composer 最佳实践](https://getcomposer.org/doc/articles/)
- [PHP-FIG 标准](https://www.php-fig.org/)

### 相关工具
- [PHP-CS-Fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer)
- [PHPStan](https://github.com/phpstan/phpstan)
- [Psalm](https://github.com/vimeo/psalm)

### 社区支持
- [Composer GitHub](https://github.com/composer/composer)
- [Stack Overflow Composer 标签](https://stackoverflow.com/questions/tagged/composer-php)
- [Reddit r/PHP](https://www.reddit.com/r/PHP/)

### 框架集成
- [Laravel](https://laravel.com/)
- [Symfony](https://symfony.com/)
- [CodeIgniter](https://codeigniter.com/)
- [CakePHP](https://cakephp.org/)

---

## 更新日志

### v2.4.1
- 性能优化
- 改进依赖解析
- 修复已知问题
- 更新镜像支持

---

*本文档最后更新于：2026年5月27日*
