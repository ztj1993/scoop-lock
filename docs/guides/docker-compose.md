# Docker Compose 使用指南

## 简介

Docker Compose 是一个用于定义和运行多容器 Docker 应用程序的工具。通过 Compose，您可以使用 YAML 文件来配置应用程序的服务，然后使用一个命令创建并启动所有服务。

**版本**: 2.32.4  
**官网**: https://docs.docker.com/compose/  
**许可证**: Apache-2.0

## 主要功能

- 单主机多容器编排
- 声明式配置
- 开发、测试、生产环境一致性
- 一键启动/停止所有服务
- 服务依赖管理
- 网络和卷管理

## 常用命令

### 基本操作

```bash
# 启动所有服务
docker-compose up

# 后台启动所有服务
docker-compose up -d

# 停止所有服务
docker-compose down

# 停止并删除所有容器、网络、卷
docker-compose down -v

# 查看服务状态
docker-compose ps

# 查看服务日志
docker-compose logs

# 查看特定服务日志
docker-compose logs service-name

# 实时查看日志
docker-compose logs -f
```

### 服务管理

```bash
# 启动特定服务
docker-compose up service-name

# 停止特定服务
docker-compose stop service-name

# 重启特定服务
docker-compose restart service-name

# 删除特定服务
docker-compose rm service-name

# 查看服务进程
docker-compose top
```

### 构建和镜像

```bash
# 构建服务镜像
docker-compose build

# 构建并启动
docker-compose up --build

# 强制重新构建
docker-compose build --no-cache

# 拉取最新镜像
docker-compose pull

# 推送镜像
docker-compose push
```

### 执行命令

```bash
# 在运行的服务中执行命令
docker-compose exec service-name command

# 在新容器中执行命令
docker-compose run service-name command

# 以交互模式执行
docker-compose exec -it service-name bash

# 执行单次命令
docker-compose run --rm service-name command
```

## 配置文件 (docker-compose.yml)

### 基本结构

```yaml
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    networks:
      - frontend

  api:
    build: ./api
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DB_HOST=db
    depends_on:
      - db
    networks:
      - frontend
      - backend

  db:
    image: postgres:13
    environment:
      - POSTGRES_DB=myapp
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=secret
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - backend

volumes:
  db-data:

networks:
  frontend:
  backend:
```

### 服务配置详解

```yaml
services:
  web:
    # 使用镜像
    image: nginx:latest
    
    # 或者构建上下文
    build:
      context: ./web
      dockerfile: Dockerfile
      args:
        - NODE_ENV=production
    
    # 端口映射
    ports:
      - "80:80"           # 主机:容器
      - "443:443"
      - "8080:80"
    
    # 环境变量
    environment:
      - NODE_ENV=production
      - API_URL=http://api:3000
    
    # 从文件加载环境变量
    env_file:
      - .env
    
    # 卷挂载
    volumes:
      - ./html:/usr/share/nginx/html  # 绑定挂载
      - db-data:/var/lib/data          # 命名卷
      - /tmp/cache:/tmp/cache          # 主机目录
    
    # 依赖服务
    depends_on:
      - api
      - db
    
    # 网络
    networks:
      - frontend
      - backend
    
    # 重启策略
    restart: unless-stopped
    
    # 资源限制
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    
    # 健康检查
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    
    # 命令覆盖
    command: ["nginx", "-g", "daemon off;"]
    
    # 入口点覆盖
    entrypoint: ["/entrypoint.sh"]
    
    # 工作目录
    working_dir: /app
    
    # 用户
    user: "1000:1000"
    
    # 标签
    labels:
      - "com.example.environment=production"
    
    # 日志配置
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

### 网络配置

```yaml
networks:
  # 自定义网络
  frontend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
  
  # 外部网络
  external-net:
    external: true
  
  # 驱动选项
  custom-net:
    driver: bridge
    driver_opts:
      com.docker.network.bridge.name: custom-br0
```

### 卷配置

```yaml
volumes:
  # 命名卷
  db-data:
    driver: local
  
  # 带选项的卷
  app-data:
    driver: local
    driver_opts:
      type: none
      device: /path/on/host
      o: bind
  
  # 外部卷
  external-vol:
    external: true
```

## 高级用法

### 多环境配置

```bash
# 使用多个配置文件
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# 使用环境变量文件
docker-compose --env-file .env.prod up -d

# 使用 override 文件
docker-compose up -d  # 自动加载 docker-compose.override.yml
```

### 扩展服务

```bash
# 扩展服务实例数
docker-compose up -d --scale web=3

# 扩展并指定端口范围
docker-compose up -d --scale web=3
# 需要在配置中使用端口范围
# ports:
#   - "8080-8082:80"
```

### 配置验证

```bash
# 验证配置文件
docker-compose config

# 验证并输出完整配置
docker-compose config --services
```

### 服务依赖

```yaml
services:
  web:
    depends_on:
      api:
        condition: service_healthy
      db:
        condition: service_started
  
  api:
    depends_on:
      db:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 10s
      timeout: 5s
      retries: 3
```

## 常见应用场景

### Web 应用开发环境

```yaml
version: '3.8'

services:
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend/src:/app/src
    environment:
      - REACT_APP_API_URL=http://localhost:8000

  backend:
    build: ./backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:13
    environment:
      - POSTGRES_DB=mydb
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  postgres_data:
```

### 微服务架构

```yaml
version: '3.8'

services:
  gateway:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - user-service
      - order-service

  user-service:
    build: ./user-service
    environment:
      - DB_HOST=user-db
    depends_on:
      - user-db

  order-service:
    build: ./order-service
    environment:
      - DB_HOST=order-db
    depends_on:
      - order-db

  user-db:
    image: postgres:13
    volumes:
      - user-db-data:/var/lib/postgresql/data

  order-db:
    image: postgres:13
    volumes:
      - order-db-data:/var/lib/postgresql/data

volumes:
  user-db-data:
  order-db-data:
```

### 开发工具链

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
    command: npm run dev

  test:
    build: .
    volumes:
      - .:/app
      - /app/node_modules
    command: npm test
    depends_on:
      - app

  lint:
    build: .
    volumes:
      - .:/app
      - /app/node_modules
    command: npm run lint
```

## 常见问题

### 1. 如何查看服务日志？

```bash
# 查看所有服务日志
docker-compose logs

# 查看特定服务日志
docker-compose logs service-name

# 实时查看日志
docker-compose logs -f

# 查看最后100行
docker-compose logs --tail=100
```

### 2. 如何进入容器内部？

```bash
# 进入运行中的容器
docker-compose exec service-name bash

# 以 root 用户进入
docker-compose exec -u root service-name bash
```

### 3. 如何重建服务？

```bash
# 重建并启动
docker-compose up -d --build

# 强制重建
docker-compose build --no-cache
docker-compose up -d
```

### 4. 如何清理所有资源？

```bash
# 停止并删除所有资源
docker-compose down -v --rmi all

# 删除所有未使用的资源
docker system prune -a
```

## 最佳实践

### 1. 使用 .env 文件

```bash
# .env 文件
POSTGRES_DB=myapp
POSTGRES_USER=admin
POSTGRES_PASSWORD=secret
API_PORT=3000
```

### 2. 使用命名卷

```yaml
volumes:
  postgres_data:
    name: myapp_postgres_data
```

### 3. 健康检查

```yaml
services:
  db:
    image: postgres:13
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5
```

### 4. 资源限制

```yaml
services:
  web:
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
```

## 脚本示例

### 部署脚本

```bash
#!/bin/bash
# 部署脚本

# 拉取最新代码
git pull

# 构建并启动服务
docker-compose -f docker-compose.prod.yml up -d --build

# 等待服务启动
sleep 10

# 检查服务状态
docker-compose ps

# 运行数据库迁移
docker-compose exec api npm run migrate

echo "部署完成"
```

### 备份脚本

```bash
#!/bin/bash
# 备份数据库

# 获取当前日期
DATE=$(date +%Y%m%d_%H%M%S)

# 备份数据库
docker-compose exec db pg_dump -U postgres myapp > backup_$DATE.sql

# 压缩备份
gzip backup_$DATE.sql

echo "备份完成: backup_$DATE.sql.gz"
```

## 相关资源

- [Docker Compose 官方文档](https://docs.docker.com/compose/)
- [Docker Compose 文件参考](https://docs.docker.com/compose/compose-file/)
- [Docker Compose 示例](https://github.com/docker/awesome-compose)
- [Docker Hub](https://hub.docker.com/)