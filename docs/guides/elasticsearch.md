# Elasticsearch 使用指南

## 简介

Elasticsearch 是一款分布式、RESTful 风格的搜索与数据分析引擎，由 Elastic 公司开发并开源。
它基于 Apache Lucene 构建，能够对海量数据进行近实时的存储、搜索和分析。
Elasticsearch v9.4.1 是目前最新的主版本之一，采用 Apache-2.0 开源许可证。

作为 Elastic Stack（ELK Stack）的核心组件，Elasticsearch 通常与 Logstash（数据采集）和
Kibana（数据可视化）配合使用，广泛应用于全文检索、日志分析、应用性能监控、安全分析等场景。

Elasticsearch 以 JSON 格式存储数据，通过 RESTful API 进行交互，支持水平扩展、自动分片与副本机制，
可以在数百台服务器上处理 PB 级别的数据。

- **版本**: v9.4.1
- **许可证**: Apache-2.0
- **官方网站**: https://www.elastic.co/products/elasticsearch
- **安装方式**: Scoop 包管理器

## 主要功能

### 全文搜索

Elasticsearch 的核心能力是全文搜索。它使用倒排索引（Inverted Index）技术，能够对文本数据
进行高效的全文检索。支持以下特性：

- 分词与分析：内置多种分词器，支持中文分词（需安装 IK 分词器等插件）
- 模糊搜索：支持模糊匹配、前缀搜索、通配符搜索
- 高级查询：布尔查询、范围查询、正则表达式查询
- 高亮显示：自动对搜索结果中的关键词进行高亮标注
- 相关性评分：基于 TF-IDF 或 BM25 算法计算搜索结果的相关性

### 结构化数据查询

除了全文搜索，Elasticsearch 还支持结构化数据的精确查询：

- 术语查询（Term Query）：精确匹配关键词
- 范围查询（Range Query）：数值、日期等范围过滤
- 存在查询（Exists Query）：判断字段是否存在
- 嵌套查询：支持嵌套对象和父子关系的查询

### 数据分析与聚合

Elasticsearch 提供强大的聚合分析功能：

- 桶聚合（Bucket Aggregation）：按条件将数据分组
- 指标聚合（Metrics Aggregation）：计算统计指标（平均值、最大值、最小值等）
- 管道聚合（Pipeline Aggregation）：基于其他聚合结果进行二次计算
- 矩阵聚合（Matrix Aggregation）：对多个字段进行矩阵运算

### 分布式架构

- 自动分片：数据自动分散到多个节点
- 副本机制：每个分片可创建多个副本，保证高可用
- 自动故障转移：节点故障时自动将分片迁移到健康节点
- 水平扩展：可通过增加节点来线性提升存储容量和查询性能

### 近实时索引

- 文档写入后约 1 秒即可被搜索到
- 支持批量索引操作（Bulk API）
- 支持索引生命周期管理（ILM）

## 常用命令/操作

### 启动与停止

Elasticsearch 提供了命令行启动脚本 `bin/elasticsearch.bat`，在 Windows 环境下使用：

```bash
elasticsearch
```

直接运行 `elasticsearch` 命令即可启动服务。默认情况下，Elasticsearch 会在前台运行，
监听 9200 端口（HTTP）和 9300 端口（节点间通信）。

后台运行方式：

```bash
elasticsearch -d -p pid
```

参数说明：
- `-d`：以后台守护进程方式运行
- `-p pid`：将进程 ID 写入指定文件

### 基本配置

启动时可通过命令行参数或配置文件修改运行参数：

```bash
elasticsearch -Ecluster.name=my_cluster -Enode.name=my_node
```

常用启动参数：

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `-Ecluster.name` | 集群名称 | elasticsearch |
| `-Enode.name` | 节点名称 | 随机生成 |
| `-Ehttp.port` | HTTP 端口 | 9200 |
| `-Etransport.port` | 节点通信端口 | 9300 |
| `-Expack.security.enabled` | 启用安全特性 | false |
| `-Epath.data` | 数据存储路径 | 默认 data 目录 |
| `-Epath.logs` | 日志路径 | 默认 logs 目录 |

### REST API 操作

集群健康检查：

```bash
curl -X GET "localhost:9200/_cluster/health?pretty"
```

查看节点信息：

```bash
curl -X GET "localhost:9200/_cat/nodes?v"
```

查看所有索引：

```bash
curl -X GET "localhost:9200/_cat/indices?v"
```

创建索引：

```bash
curl -X PUT "localhost:9200/my_index" -H "Content-Type: application/json" -d '{
  "settings": {
    "number_of_shards": 3,
    "number_of_replicas": 1
  }
}'
```

索引文档：

```bash
curl -X POST "localhost:9200/my_index/_doc" -H "Content-Type: application/json" -d '{
  "title": "Elasticsearch Guide",
  "content": "This is a comprehensive guide."
}'
```

搜索文档：

```bash
curl -X GET "localhost:9200/my_index/_search?pretty" -H "Content-Type: application/json" -d '{
  "query": {
    "match": {
      "title": "guide"
    }
  }
}'
```

删除索引：

```bash
curl -X DELETE "localhost:9200/my_index"
```

### 插件管理

列出已安装插件：

```bash
elasticsearch-plugin list
```

安装插件：

```bash
elasticsearch-plugin install analysis-icu
```

删除插件：

```bash
elasticsearch-plugin remove analysis-icu
```

### 版本与帮助

查看版本信息：

```bash
elasticsearch --version
```

查看帮助：

```bash
elasticsearch --help
```

## 常见问题

### Q: 启动时报错 "max virtual memory areas vm.max_map_count [65530] is too low"

这是 Linux 环境下常见的问题，Windows 环境下通常不会遇到。如果在 WSL 中运行，
需要修改系统参数：

```bash
sudo sysctl -w vm.max_map_count=262144
```

### Q: 如何修改默认端口？

可以通过启动参数修改：

```bash
elasticsearch -Ehttp.port=9201
```

或修改配置文件 `config/elasticsearch.yml`：

```yaml
http.port: 9201
transport.port: 9301
```

### Q: 如何设置集群安全认证？

从 v8.0 开始，Elasticsearch 默认启用安全特性。初次启动时会生成密码和证书。
如需手动配置：

```bash
elasticsearch-reset-password -u elastic
```

### Q: 索引数据如何备份与恢复？

使用 Snapshot API：

```bash
curl -X PUT "localhost:9200/_snapshot/my_backup" -H "Content-Type: application/json" -d '{
  "type": "fs",
  "settings": {
    "location": "/backup/path"
  }
}'
```

### Q: 如何优化搜索性能？

- 合理设置分片数量，避免过多或过少
- 使用路由（Routing）减少需要查询的分片数
- 合理使用缓存（Fielddata、Request Cache）
- 避免深分页，使用 Search After 或 Scroll API
- 选择合适的字段类型和索引策略

### Q: 如何安装中文分词器？

推荐使用 IK Analysis 插件：

```bash
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v9.4.1/elasticsearch-analysis-ik-9.4.1.zip
```

## 相关资源

- **官方网站**: https://www.elastic.co/products/elasticsearch
- **官方文档**: https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
- **GitHub 仓库**: https://github.com/elastic/elasticsearch
- **Kibana 官网**: https://www.elastic.co/products/kibana
- **Logstash 官网**: https://www.elastic.co/products/logstash
- **Elastic 社区论坛**: https://discuss.elastic.co
- **Scoop 包管理器**: https://scoop.sh
- **IK 中文分词器**: https://github.com/medcl/elasticsearch-analysis-ik
- **Elastic Stack 下载**: https://www.elastic.co/downloads
